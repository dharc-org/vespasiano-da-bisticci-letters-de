var express = require('express');
var router = express.Router();

var fs = require('fs')
var rdf = require('rdflib');
var _ = require('underscore');

var BIO = rdf.Namespace("http://purl.org/vocab/bio/0.1/")
var DCTERMS = rdf.Namespace("http://purl.org/dc/terms/")
var FRBR = rdf.Namespace("http://purl.org/vocab/frbr/core#")
var PRO = rdf.Namespace("http://purl.org/spar/pro/")
var RDFS = rdf.Namespace("http://www.w3.org/2000/01/rdf-schema#")
var TVC = rdf.Namespace("http://www.ontologydesignpatterns.org/cp/owl/timeindexedsituation.owl#")
var SAN = rdf.Namespace("http://dati.san.beniculturali.it/SAN/")

var rdfData = fs.readFileSync('./public/rdf/vdbRdf.rdf').toString();
var store = rdf.graph();
var contentType = 'application/rdf+xml';
var uri = "http://vespasianodabisticciletters.unibo.it/";

// function uniqBy(a, key) {
//     var seen = {};
//     return a.filter(function(item) {
//         var k = key(item);
//         return seen.hasOwnProperty(k) ? false : (seen[k] = true);
//     })
// };

	try{
    		rdf.parse(rdfData,store,uri,contentType)

    		// WORKS
    		var works = rdf.sym('http://vespasianodabisticciletters.unibo.it/tomasi-letters')
			var stms = store.each(works, FRBR('part') , undefined);
    		var i, n = stms.length, stm;

			// list of (labels of) works in the collection
			var label = [];
			for (i=0; i<n; i++) {
        		stm = stms[i]
        		if (stms[i], RDFS('label')) {
        			var labelNodes = store.any(stm, RDFS('label'));
        			label.push(labelNodes);
        		}
			}

			// SENDERS
			var senderRole = rdf.sym('http://vespasianodabisticciletters.unibo.it/sender')
			var sendRolesInTime = store.each(undefined, PRO('withRole'), senderRole);

			var senderRoleLetter = [];

			for (var i=0; i<sendRolesInTime.length; i++) {
				var sendRoleInTime = sendRolesInTime[i];
				if (sendRoleInTime, PRO('isHeldBy')) {
					var whowhoUris = store.any(sendRoleInTime, PRO('isHeldBy'));
					if (whowhoUris, RDFS('label')) {
						var whowhoLabels = store.any(whowhoUris, RDFS('label'));
					}
					var letters = store.any(sendRoleInTime, PRO('relatesTo'));
					if (letters, RDFS('label')) {
						var lettersLabels = store.any(letters, RDFS('label'));
					}
					if (undefined, DCTERMS('source'), letters) {
						var htmlURI = store.any(undefined, DCTERMS('source'), letters);
					}
					if (letters, FRBR('partOf')) {
						var manuscriptURIs = store.any(letters, FRBR('partOf'));
						if (manuscriptURIs, RDFS('label')) {
							var manuscriptLabels = store.any(manuscriptURIs, RDFS('label'));
							if (manuscriptURIs, FRBR('partOf')) {
								var manuscriptContainerURI = store.any(manuscriptURIs, FRBR('partOf'));
								if (manuscriptContainerURI, RDFS('label')) {
									var manuscriptContLabels = store.any(manuscriptContainerURI, RDFS('label'));
								}
								if (undefined, SAN('isConservatoreOf'), manuscriptContainerURI) {
									var repositoryURI = store.any(undefined, SAN('isConservatoreOf'), manuscriptContainerURI);
									if (repositoryURI, RDFS('label')) {
										var repositoryLabels = store.any(repositoryURI, RDFS('label'));
									}
									if (repositoryURI, SAN('has_luogoConservatore')) {
										var repositoryPlaceURI = store.any(repositoryURI, SAN('has_luogoConservatore'));
										if (repositoryPlaceURI, RDFS('label')) {
											var repositoryPlaceLabels = store.any(repositoryPlaceURI, RDFS('label'));
										}
									}
								}
							}
						}
					}
					var whereURIs = store.any(sendRoleInTime, BIO('place'));
					if (whereURIs, RDFS('label')) {
						var whereLabels = store.any(whereURIs, RDFS('label'));
					}
					var whenURIs = store.any(sendRoleInTime, TVC('atTime'));
					if (whenURIs, RDFS('label')) {
						var whenLabels = store.any(whenURIs, RDFS('label'));
					}

					// create an object containing sender, role, letter - not cleaned
					senderRoleLetter.push({
						"person" : whowhoLabels.value,
						"personURI" : whowhoUris.value,
						"roleInTime" : sendRoleInTime.value,
						"letter" : lettersLabels,
						"letterURI" : letters.value,
						"htmlURI" : htmlURI,
						"manuscript" : manuscriptLabels,
						"manuscriptURI" : manuscriptURIs.value,
						"container" : manuscriptContLabels.value,
						"repository" : repositoryLabels.value,
						"repositoryPlace" : repositoryPlaceLabels.value,
						"place" : whereLabels.value,
						"placeURI" : whereURIs.value,
						"date" : whenLabels.value,
						"dateURI" : whenURIs.value
					});

					// whowhoJ = whowhoJ.filter(function(elem, pos) { return who.indexOf(elem) == pos;});
					// count letters
				}
			}

			// grouping letters by senders
			senderLetters = _.chain(senderRoleLetter).groupBy('person').map(function(value, key) {
    			return {
			        person: key,
			        letter: _.pluck(value, 'htmlURI')
			    	}
				}).value();

			// sort by person name
			senderLetters.sort(function(a, b){
		    	if(a.person < b.person) return -1;
		    	if(a.person > b.person) return 1;
		    	return 0;
			})

			// grouping letters by place
			placeLetters = _.chain(senderRoleLetter).groupBy('place').map(function(value, key) {
    			return {
			        place: key,
			        letter: _.pluck(value, 'htmlURI')
			    	}
				}).value();
			// sort by place name
			placeLetters.sort(function(a, b){
		    	if(a.place < b.place) return -1;
		    	if(a.place > b.place) return 1;
		    	return 0;
			})

			// grouping letters by date
			dateLetters = _.chain(senderRoleLetter).groupBy('date').map(function(value, key) {
    			return {
			        date: key,
			        letter: _.pluck(value, 'htmlURI')
			    	}
				}).value();
			// sort by date
			dateLetters.sort(function(a, b){
		    	if(a.date < b.date) return -1;
		    	if(a.date > b.date) return 1;
		    	return 0;
			})
			// grouping letters by date
			idLetters = _.chain(senderRoleLetter).groupBy('manuscript').map(function(value, key) {
    			return {
			        manuscript: key,
			        letter: _.pluck(value, 'htmlURI')
			    	}
				}).value();

			// sort by manuscript name
			idLetters.sort(function(a, b){
		    	if(a.manuscript < b.manuscript) return -1;
		    	if(a.manuscript > b.manuscript) return 1;
		    	return 0;
			})

			// ADDRESSEES
			var addresseeRole = rdf.sym('http://vespasianodabisticciletters.unibo.it/addressee')
			var addresseeRolesInTime = store.each(undefined, PRO('withRole'), addresseeRole);

			var addresseeRoleLetter = [];
			for (var i=0; i<addresseeRolesInTime.length; i++) {
				var addresseeRoleInTime = addresseeRolesInTime[i];
				if (addresseeRoleInTime, PRO('isHeldBy')) {
					var whowhoUrisa = store.any(addresseeRoleInTime, PRO('isHeldBy'));
					if (whowhoUrisa, RDFS('label')) {
						var whowhoLabelsa = store.any(whowhoUrisa, RDFS('label'));
					}
					var lettersa = store.any(addresseeRoleInTime, PRO('relatesTo'));
					if (lettersa, RDFS('label')) {
						var lettersLabelsa = store.any(lettersa, RDFS('label'));
					}
					if (undefined, DCTERMS('source'), lettersa) {
						var htmlURIa = store.any(undefined, DCTERMS('source'), lettersa);
					}

					// create an object containing addressee, role, letter - not cleaned
					addresseeRoleLetter.push({
						"person" : whowhoLabelsa,
						"personURI" : whowhoUrisa.value,
						"roleInTime" : addresseeRoleInTime.value,
						"letter" : lettersLabelsa.value,
						"letterURI" : lettersa.value,
						"htmlURI" : htmlURIa
					});
				}
			}
			addresseeLetters = _.chain(addresseeRoleLetter).groupBy('person').map(function(value, key) {
    			return {
			        person: key,
			        letter: _.pluck(value, 'htmlURI')
			    	}
				}).value();

			// sort by person name
			addresseeLetters.sort(function(a, b){
		    	if(a.person < b.person) return -1;
		    	if(a.person > b.person) return 1;
		    	return 0;
			})
			//console.log(senderLetters);



		} catch(err){console.log(err);}

/* GET browsing home page. */
// router.get('/', function(req, res, next) {
//   res.render('browse-layout',
//   	{ title: 'Esplora la collezione' }
//   	);
// });

/* GET browsing 'corrispondenti' page. */
router.get('/corrispondenti', function(req, res, next) {
	res.render('corrispondenti', { title: 'i corrispondenti', obj: ' PER CORRISPONDENTE', senderRoleLetter, addresseeLetters});
});

/* GET browsing 'luoghi' page. */
router.get('/luoghi', function(req, res, next) {
	res.render('luoghi', { title: 'i luoghi', obj: ' PER LUOGO'});
});

/* GET browsing 'date' page. */
router.get('/date', function(req, res, next) {
	res.render('date', { title: 'le date', obj: ' PER DATA DI SPEDIZIONE'});
});

/* GET browsing 'segnatura' page. */
router.get('/segnatura', function(req, res, next) {
	res.render('segnatura', { title: 'le segnature', obj: ' PER SEGNATURA'});
});

module.exports = router;
