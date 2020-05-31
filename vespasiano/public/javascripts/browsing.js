$(document).ready(function() {
	// $('li:contains("http://vespasianodabisticciletters.unibo.it/tomasi-letters, ")').each(function(){
 //    $(this).html($(this).html().split("http://vespasianodabisticciletters.unibo.it/tomasi-letters, ").join(""));
	// });

	// sliding menu
	var menuVisible = false;
	$('.menuBtn').click(function() {
		$('.browsingmenu').slideToggle('slow');	
		$('i').toggleClass("fa-bars fa-times");
	});

	// grouping biblio references in bibliography
	$('.biblioRef').each(function () {
  		var letter = $(this).text().charAt(0);
  		if (!$(this).parent().find('[data-letter="'+ letter +'"]').length) {
    		$(this).parent().append('<div data-letter="'+ letter+'"><span class="letterList">'+ letter +'</span></div>');
  		}
  		$(this).parent().find('[data-letter="'+ letter +'"]').append(this);
	});
	// dropdown list in bibliography
	$('.letterList').click(function() {
		$(this).nextAll('p').slideToggle('slow');
	});

	// dropdown text
	$('.dropDown h3').nextAll().hide();
	$('.dropDown h3').click(function() {
		$(this).nextAll().slideToggle('slow');
	});

	// labels oh htmls
	$('span.letter a').each(function() {
		var letterNum = $(this).attr('href');
		var URI = letterNum.substring(52);
		$(this).html(URI + ' ');
	});

	// rewrite URI of htmls (partial URIs)
	$('.html a').each(function() {
		var letterNum = $(this).attr('href');
		var URI = letterNum.substring(52);
		$(this).attr('href', '../letters/' + URI);
	});

	// rewrite URI of images (partial URIs)
	$('img').each(function() {
		var letterNum = $(this).attr('src');
		var URI = letterNum.substring(43);
		$(this).attr('src', URI);
	});
	// letters
	$( ".metadata" ).wrapAll( "<section class='Metadata' id='Metadata'></section>" );
	$( ".Letter" ).wrapAll( "<section class='Letter' id='Letter'></section>" );
	$( ".Footnote" ).wrapAll( "<section class='Notes' id='Notes'></section>" );
	$(".letterContainer > div").prepend("<ul class='letterMenu'><li><a href='#Metadata'>METADATI</a></li><li><a href='#Letter'>TESTO</a></li><li><a href='#Notes'>NOTE</a></li></ul>");
	$(".letterContainer > div").tabs();
	// dropdown footnotes
	$('.Footnote h2').nextAll().hide();
	$('.Footnote h2').prepend('<i class="fa fa-bookmark-o" aria-hidden="true"></i> ');
	$('.Footnote h2').click(function() {
		$(this).nextAll().slideToggle('slow');
	});
	// set URIs
	// var partialURI = $('.Person').attr('href').val().toLowerCase();
	// var baseURI = "http://vespasianodabisticciletters.unibo.it/";
	// var personURI = baseURI.concat(partialURI);

});