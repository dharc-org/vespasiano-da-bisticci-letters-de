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
var timeout = 5000 // 5000 ms timeout
// var fetcher = rdf.Fetcher('http://it.dbpedia.org/resource/', timeout)

try{
    rdf.parse(rdfData,store,uri,contentType)
   	// people
   	var people = [];
   	var abstract = [];
   	var personClass = rdf.sym('http://xmlns.com/foaf/0.1/Person')
   	var peopleURI = store.each(undefined, RDF('type'), personClass)
   	for (i=0; i<peopleURI.length; i++) {
   		var peopleLabel = store.any(peopleURI[i], RDFS('label'))
   		var peopleSameAs = store.each(peopleURI[i], OWL('sameAs'))
   		people.push({
   			"URI": peopleURI[i].value,
   			"LABEL": peopleLabel.value,
			"SAMEAS": peopleSameAs
		})	
   	}
   	
   	peopleObj = JSON.stringify(people)
   	} catch(err){console.log(err);} 

// for (j=0; j<peopleSameAs.length; j++) { 	
// 			   	fetcher.nowOrWhenFetched(peopleSameAs[j], undefined, function(ok, body, xhr) {
// 					if (!ok) {
// 						console.log("Oops, something happened and couldn't fetch data");
// 					} else {
// 						var names = [];
// 						names.push(store.any(peopleSameAs[j], FOAF('depiction')));
// 					    console.log(names)	
// 					}
// 				})
				
// 		}

/* GET letters page. */
router.get('/:id', function(req, res, next) {
	var id = req.params.id;
	res.set('content-type','text/html');
 	var text = fs.readFileSync('./public/letters/'+id+'.html');
  	res.render('letter-layout', { title: 'Lettera ' + id, lettername: 'Lettera num. ' + id, text, people });
});

module.exports = router;