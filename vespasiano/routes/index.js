var express = require('express');
var router = express.Router();

var fs = require('fs')
var rdf = require('rdflib');
// namespaces
var DCTERMS = rdf.Namespace("http://purl.org/dc/terms/")
var FABIO = rdf.Namespace("http://purl.org/spar/fabio/")
var RDF = rdf.Namespace("http://www.w3.org/1999/02/22-rdf-syntax-ns#")

// rdflib variables
var rdfData = fs.readFileSync('./public/rdf/vdbRdf.rdf').toString();
var store = rdf.graph();
var contentType = 'application/rdf+xml';
var uri = "http://vespasianodabisticciletters.unibo.it/";

try{
	rdf.parse(rdfData,store,uri,contentType)
	var bookClass = rdf.sym('http://purl.org/spar/fabio/Book')
	var bookChapterClass = rdf.sym('http://purl.org/spar/fabio/BookChapter')
	var articleClass = rdf.sym('http://purl.org/spar/fabio/Article')
	var books = store.each(undefined, RDF('type'), bookClass)
	var chapters = store.each(undefined, RDF('type'), bookChapterClass)
	var articles = store.each(undefined, RDF('type'), articleClass)
	var bibliography = [];
	for (var i=0; i<books.length; i++) {
		bibliography.push(store.any(books[i], DCTERMS('bibliographicCitation')))
	}
	for (var j=0; j<chapters.length; j++) {
		bibliography.push(store.any(chapters[j], DCTERMS('bibliographicCitation')))
	}
	for (var k=0; k<articles.length; k++) {
		bibliography.push(store.any(articles[k], DCTERMS('bibliographicCitation')))
	}
	// remove duplicates in bibliography in the new array 'biblio'
    	var biblio = [];
    	for (var i=0; i<bibliography.length; i++) { biblio.push(bibliography[i]) }
    	var arr = {};
		  for ( var i=0, len=biblio.length; i < len; i++ ) arr[biblio[i]] = biblio[i];
		  biblio = [];
		  for ( var key in arr ) biblio.push(arr[key]);
} catch(err){console.log(err);} 

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', 
  	{ title: 'Vespasiano da Bisticci, lettere' }
  	);
});

/* section GUIDA ALL'EDIZIONE */
/* GET markup page. */
router.get('/markup', function(req, res, next) {
  res.render('markup', 
  	{ title: 'Il markup e l\'ipertesto' }
  	);
});

/* GET annotazione page. */
router.get('/annotazione', function(req, res, next) {
  res.render('annotazione', 
  	{ title: 'I livelli di annotazione' }
  	);
});

/* GET dati page. */
router.get('/dati', function(req, res, next) {
  res.render('dati', 
  	{ title: 'Il dataset e le ontologie' }
  	);
});

/* section STRUMENTI */
/* GET nota page. */
router.get('/nota', function(req, res, next) {
  res.render('nota', 
  	{ title: 'Nota filologica: i principi della trascrizione' }
  	);
});

/* GET testimoni page. */
router.get('/testimoni', function(req, res, next) {
  res.render('testimoni', 
  	{ title: 'I testimoni della raccolta' }
  	);
});

/* GET bibliografia page. */
router.get('/bibliografia', function(req, res, next) {
	biblio.sort(function(a, b){
	    	if(a < b) return -1;
	    	if(a > b) return 1;
	    	return 0;
		})
  res.render('bibliografia', { title: 'La bibliografia', biblio });
});

/* section IL CORPUS */
/* GET raccolta page. */
router.get('/raccolta', function(req, res, next) {
  res.render('raccolta', 
  	{ title: 'La raccolta' }
  	);
});

/* GET corrisponenti (static) page. */
router.get('/i-corrispondenti', function(req, res, next) {
  res.render('i-corrispondenti', 
  	{ title: 'I corrispondenti' }
  	);
});

/* GET manoscritti (static) page. */
router.get('/manoscritti', function(req, res, next) {
  res.render('manoscritti', 
  	{ title: 'I manoscritti' }
  	);
});

/* GET copisti (static) page. */
router.get('/copisti', function(req, res, next) {
  res.render('copisti', 
  	{ title: 'I copisti' }
  	);
});

/* GET copisti (static) page. */
router.get('/biblioteche', function(req, res, next) {
  res.render('biblioteche', 
  	{ title: 'Le biblioteche' }
  	);
});

module.exports = router;
