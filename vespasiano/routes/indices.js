var express = require('express');
var router = express.Router();

var fs = require('fs')
var rdf = require('rdflib');

// namespaces
var BIO = rdf.Namespace("http://purl.org/vocab/bio/0.1/")
var C4O = rdf.Namespace("http://purl.org/spar/c4o/")
var DCTERMS = rdf.Namespace("http://purl.org/dc/terms/")
var FABIO = rdf.Namespace("http://purl.org/spar/fabio/")
var FOAF = rdf.Namespace("http://xmlns.com/foaf/0.1/")
var FRBR = rdf.Namespace("http://purl.org/vocab/frbr/core#")
var PO = rdf.Namespace("http://www.essepuntato.it/2008/12/pattern#")
var PRO = rdf.Namespace("http://purl.org/spar/pro/")
var RDF = rdf.Namespace("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
var RDFS = rdf.Namespace("http://www.w3.org/2000/01/rdf-schema#")
var OWL = rdf.Namespace("http://www.w3.org/2002/07/owl#")
var TVC = rdf.Namespace("http://www.ontologydesignpatterns.org/cp/owl/timeindexedsituation.owl#")


// rdflib variables
var rdfData = fs.readFileSync('./public/rdf/vdbRdf.rdf').toString();
var store = rdf.graph();
var contentType = 'application/rdf+xml';
var uri = "http://vespasianodabisticciletters.unibo.it/";

function remove_duplicates(arr) {
    var obj = {};
    var ret_arr = [];
    for (var i = 0; i < arr.length; i++) {
        obj[arr[i]] = true;
    }
    for (var key in obj) {
        ret_arr.push(key);
    }
    return ret_arr;
}

function uniqBy(a, key) {
    var seen = {};
    return a.filter(function(item) {
        var k = key(item);
        return seen.hasOwnProperty(k) ? false : (seen[k] = true);
    })
};

try{
    	rdf.parse(rdfData,store,uri,contentType)

    	// people
    	var personClass = rdf.sym('http://xmlns.com/foaf/0.1/Person')
    	var anyCitedEntity = store.each(undefined, DCTERMS('isReferencedBy'))
    	// filtering people by only cited people
    	var citedPeople = [];
    	for (var a=0; a<anyCitedEntity.length; a++) {
    		var citing = store.statementsMatching(anyCitedEntity[a], RDF('type'), personClass)
    		for (var b=0; b<citing.length; b++) {
    			citedPeople.push(citing[b].subject)
    		}
    	}

    	// remove duplicates in people list in the new array 'example'
    	var example = [];
    	for (var i=0; i<citedPeople.length; i++) { example.push(citedPeople[i]) }
    	var arr = {};
		for ( var i=0, len=example.length; i < len; i++ ) arr[example[i]['value']] = example[i];
		example = [];
		for ( var key in arr ) example.push(arr[key]);
		// object containing people, labels, links to authorities, letters and attested forms
    	var people = [];
    	for (var i=0; i<example.length; i++) {
    		var citedPerson = example[i];
	    		var label = store.any(citedPerson, RDFS('label'), undefined)
	    		var sameAs = store.each(citedPerson, OWL('sameAs'), undefined)
	    		var attestedForms = store.each(citedPerson, DCTERMS('isReferencedBy'), undefined)
				var peoplesource = [];
				var peoplelabel = [];
    			for (var j=0; j<attestedForms.length; j++) {
    				var peoplesourc = store.any(attestedForms[j], DCTERMS('source'), undefined)
    				peoplesource.push(peoplesourc.value);
    				var formPers = store.any(attestedForms[j], RDFS('label'), undefined)
    				peoplelabel.push([formPers])
    				peoplesource = remove_duplicates(peoplesource)
    				peoplelabel = remove_duplicates(peoplelabel)
    			}
    		people.push({
		    			"URI": citedPerson,
		    			"LABEL": label,
		    			"SAMEAS": sameAs,
		    			"LETTERS": peoplesource,
		    			"FORMS": peoplelabel
		    	});	
    	}
    	// console.log(people)

    	// codices
    	var codexClass = rdf.sym('http://purl.org/spar/fabio/AnalogItem')
    	var codicesItems = store.each(undefined, RDF('type'), codexClass)
    	// filtering codices by only cited codices
    	for (var i=0; i<codicesItems.length; i++) {
    		var citedCodices = store.each(undefined, FABIO('isPortrayalOf'))
    	}
    	// object containing codices, works, authors, links to authorities, descriptions, shelfmarks, letters
    	var codices = [];
    	for (var i=0; i<citedCodices.length; i++) {
    		var codex = citedCodices[i]
    		if (codex, FABIO('isPortrayalOf')) {
	    		var title = store.any(codex, DCTERMS('title')) // CODICE
	    		var commission = store.any(codex, DCTERMS('description')) // COMMISSIONE
	    		var shelfmark = store.any(codex, DCTERMS('identifier')) // SEGNATURA
	    		var workAttr = store.any(codex, FABIO('isPortrayalOf'))
    			var work = store.any(codex, FABIO('isPortrayalOf'), undefined)
    			var workLabel = store.any(work, RDFS('label')) // OPERA
    			var workAuthority = store.any(work, OWL('sameAs')) // AUTHORITY CONTROL
    			var creator = store.any(work, DCTERMS('creator'))
    			var attestedCodex = store.each(undefined, DCTERMS('references'), codex)
    			var Codexsource = [];
    			for (var j=0; j<attestedCodex.length; j++) {
    				var Codexsourc = store.any(attestedCodex[j], DCTERMS('source'), undefined)
    				Codexsource.push(Codexsourc.value)
    			}
    			if (work, DCTERMS('creator')) {
    				var author = creator
    				var authorLabel = store.any(author, RDFS('label')) // AUTORE
    			}
    			if (!creator){
    				var author = rdf.sym('http://vespasianodabisticciletters.unibo.it/unknown-author')
    				var authorLabel = "-";
    			}  	
    			codices.push({
	    			"CODEX": codex,
	    			"TITLE": title,
	    			"WORK": workLabel,
	    			"AUTHORITYCONTROL": workAuthority,
	    			"AUTHOR": authorLabel,
	    			"COMMISSION": commission,
	    			"SHELFMARK": shelfmark,
	    			"LETTERS": [Codexsource]
    			})
    		}
    	}

    	// lexicon
    	var lexicalItems = store.each(undefined, DCTERMS('type'), rdf.sym('http://vespasianodabisticciletters.unibo.it/lexical-form'))
		// object containing lexical forms, tags, related codices, letters
		var lexicon = [];
		for (var i=0; i<lexicalItems.length; i++) {
			var lexicalForm = store.any(lexicalItems[i], RDFS('label'))
			var area = store.any(lexicalItems[i], FABIO('hasSubjectTerm'))
			if (area) {
				var area = store.any(lexicalItems[i], FABIO('hasSubjectTerm'))
				var areaLabel = store.any(area, RDFS('label'))
			}
			if (!area) {
				var area = rdf.sym('http://vespasianodabisticciletters.unibo.it/unknown-area')
				var areaLabel = ""
			}
			var areaLabel = store.any(area, RDFS('label'))
			var relCodex = store.any(lexicalItems[i], DCTERMS('relation'))
			if (relCodex) {
				var relCodex = relCodex;
				var codexLabel = store.any(relCodex, RDFS('label'))
			}
			if (!relCodex) {
				var relCodex = rdf.sym('http://vespasianodabisticciletters.unibo.it/unknown-codex')
				var codexLabel = "-"
			}
			var lettersLexicon = []
			var attestedLexicalForm = store.each(lexicalItems[i], DCTERMS('source'), undefined)
			for (var a=0; a<attestedLexicalForm.length; a++) {
				lettersLexicon.push(attestedLexicalForm[a].value)
			}
			lexicon.push({
				"LEXICALURI": lexicalItems,
				"TERM": lexicalForm,
				"AREA": areaLabel,
				"CODEX": codexLabel,
				"LETTERS": lettersLexicon
			})
    	}

    	// quotations
    	var textChuncks = store.each(undefined, C4O('isRelevantTo'))
		// object containing ...
		var quotations = [];
		for (var i=0; i<textChuncks.length; i++) {
				var textChunck = textChuncks[i]
				var quotation = store.any(textChunck, C4O('hasContent')) // QUOTATION
				var attribution = store.any(textChunck, DCTERMS('description')) // ATTRIBUTION
				var letterQuot = store.any(textChunck, DCTERMS('source'), undefined).value // LETTER - in this case just one letter contains the citation
			 	var quotationsItems = store.each(textChunck, C4O('isRelevantTo'), undefined)
			 	var biblioCit = [], expressionQuot = [], workQuot = [], workSameAs = [], authorQuotLabel = [], authorSameAs = [];
				for (var j=0; j<quotationsItems.length; j++) {
					var quotationsItem = quotationsItems[j]
					biblioCit.push(store.any(quotationsItem, DCTERMS('bibliographicCitation'), undefined)) // BIBLIOGRAPHIC CIT.
		    		expressionQuot.push(store.any(quotationsItem, FRBR('partOf'), undefined))
		    		for (var k=0; k<expressionQuot.length; k++) {
		    			workQuot.push(store.any(expressionQuot[k], FRBR('realizationOf'), undefined))
			    		for (var l=0; l<workQuot.length; l++) {
			    			var wsameAs = store.each(workQuot[l], OWL('sameAs'), undefined);
				    		var authorQuotation = store.any(workQuot[l], DCTERMS('creator'), undefined)
				    		if (authorQuotation){
								var authorQuot = authorQuotation;
					    			authorQuotLabel.push(store.any(authorQuot, RDFS('label'), undefined)) // AUTHOR
					    			var ausameAs = store.each(authorQuot, OWL('sameAs'));
					    			for (var n=0; n<ausameAs.length; n++) {
					    				authorSameAs.push(ausameAs[n].value) // AUTORITY AUTHOR	
					    			}
							}
							if (!authorQuotation) {
								var authorQuot = rdf.sym('http://vespasianodabisticciletters.unibo.it/unknown-author')
								var authorQuotLabel = "-"
								var authorSameAs = ""
							}
				    	}
				    	for (var m=0; m<wsameAs.length; m++) {
			    			workSameAs.push(wsameAs[m].value) // AUTORITY OPERA
				    	}
		    		}

		    		quotations.push({
		    			"QUOTATION": quotation,
		    			"ATTRIBUTION": attribution,
		    			"BIBLIOGRAPHICCIT": biblioCit,
		    			"EXPRESSION": expressionQuot,
		    			"WORK": workQuot,
		    			"AUTHORITYWORK": workSameAs[j],
		    			"AUTHOR": authorQuotLabel,
		    			"AUTORITYAUTHOR": authorSameAs[j],
		    			"LETTERS": letterQuot,
		    		})
				}	    	
		}
			
		// letters
		var letterCollection = rdf.sym('http://vespasianodabisticciletters.unibo.it/vdb-letters')
	    var letterWorks = store.each(letterCollection, FRBR('part'), undefined)
	    var letters = [];
	    for (var i=0; i<letterWorks.length; i++) {
	    	var letterItems = store.each(letterWorks[i], FABIO('hasPortrayal'), undefined)
	    	for (var j=0; j<letterItems.length; j++) {	
	    		var images = [];
	    		var letterLabel = store.any(letterItems[j], RDFS('label'))
	    		var shelfmarkLetter = store.any(letterItems[j], FRBR('partOf'))	
	    		var shelfmarkLabel = store.any(shelfmarkLetter, RDFS('label'))
	    		var eachimages = store.each(letterItems[j], FOAF('depiction'))
	    		for (var a=0; a<eachimages.length; a++) {
	    			images.push(eachimages[a].value)
	    		}
	    		var html = store.any(undefined, DCTERMS('source'), letterItems[j]).value
	    		var index = store.any(html, DCTERMS('identifier'))
	    		var rolesInTime = store.each(undefined, PRO('relatesTo'), letterItems[j])
	    		// senders
	    		for (var k=0; k<rolesInTime.length; k++) {
	    			var sendersRolesInTime = store.each(undefined, PRO('withRole'), rdf.sym('http://vespasianodabisticciletters.unibo.it/sender'))	
	    		}
	    		var senders = [], when = [], where = [];
	    		for (var m=0; m<sendersRolesInTime.length; m++) {
	    			var sendersURI = store.any(sendersRolesInTime[m], PRO('isHeldBy'))
	    			var whenURI = store.any(sendersRolesInTime[m], TVC('atTime'))
	    			var whenLabel = store.any(whenURI, RDFS('label'))
	    			var whereURI = store.any(sendersRolesInTime[m], BIO('place'))
	    			var whereLabel = store.any(whereURI, RDFS('label'))
	    			var sendersLabel = store.any(sendersURI, RDFS('label'))
	    			senders.push(sendersLabel)
	    			when.push(whenLabel)
	    			where.push(whereLabel)
	    			// for (var n=0; n<senders.length; n++) {
	    			// 	var sender = senders[n]
	    			// }
	    			
	    		}
	    		// addressee
	    		for (var k=0; k<rolesInTime.length; k++) {
	    			var addresseeRolesInTime = store.each(undefined, PRO('withRole'), rdf.sym('http://vespasianodabisticciletters.unibo.it/addressee'))	
	    		}
	    		var addressees = [];
	    		for (var m=0; m<addresseeRolesInTime.length; m++) {
	    			var addresseeURI = store.any(addresseeRolesInTime[m], PRO('isHeldBy'))
	    			var addresseeLabel = store.any(addresseeURI, RDFS('label'))
	    			addressees.push(addresseeLabel)
	    			// for (var n=0; n<senders.length; n++) {
	    			// 	var sender = senders[n]
	    			// }
	    			
	    		}
	    		letters.push({
	    			"INDEX": index,
					"ITEM": letterLabel,
					"HTML": html,
					"SHELFMARK": shelfmarkLabel,
					"ICONS": images,
					"SENDER": senders[i],
					"ADDRESSEE": addressees[i],
					"DATE": when[i],
					"PLACE": where[i]
				})
	    	}	
	    }
   } catch(err){console.log(err);} 


/* GET indices page. */
router.get('/', function(req, res, next) {
  res.render('indices-layout', 
  	{ title: 'Indici' }
  	);
});

/* GET persone page. */
router.get('/persone', function(req, res, next) {
		people.sort(function(a, b){
	    	if(a.LABEL < b.LABEL) return -1;
	    	if(a.LABEL > b.LABEL) return 1;
	    	return 0;
		})
  res.render('persone', { title: 'Indice delle persone', obj : 'DELLE PERSONE', people});
});

/* GET codici page. */
router.get('/codici', function(req, res, next) {
	codices.sort(function(a, b){
	    	if(a.TITLE < b.TITLE) return -1;
	    	if(a.TITLE > b.TITLE) return 1;
	    	return 0;
		})
  res.render('codici', { title: 'Indice dei codici', obj : 'DEI CODICI', codices });
});

router.get('/lessico', function(req, res, next) {
	lexicon.sort(function(a, b){
	    	if(a.TERM < b.TERM) return -1;
	    	if(a.TERM > b.TERM) return 1;
	    	return 0;
	})
  res.render('lessico', { title: 'Indice dei termini', obj : 'DEI TERMINI', lexicon });
});

router.get('/citazioni', function(req, res, next) {
	
  res.render('citazioni', { title: 'Indice delle citazioni', obj : 'DELLE CITAZIONI', quotations });
});

router.get('/lettere', function(req, res, next) {
	letters.sort(function(a, b){
	    	return a.INDEX-b.INDEX;
		})
  res.render('lettere', { title: 'Tavola sinottica delle lettere', obj : 'DELLE LETTERE', letters });
});

module.exports = router;
