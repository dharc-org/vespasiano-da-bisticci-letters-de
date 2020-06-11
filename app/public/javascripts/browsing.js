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
		var URI = '..'+letterNum.substring(43);
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

	///////////////////////////////////////////////////////////////////

	//legenda
	$( "article.Letter" ).append( "<form><fieldset><legend>Legenda</legend><ul class='legenda'><li>Una <span style='color:rgb(0, 174, 255)'>persona</span> riportata nella lettera è evidenziata in colore blu.</li><li>Un <span style='color:rgb(250, 32, 25)'>codice</span> riportato nella lettera è evidenziato in colore rosso.</li><li>Un <span style='color:rgb(231, 25, 238)'>luogo</span> riportato nella lettera è evidenziato in colore magenta.</li><li>Una <span style='color:rgb(207, 105, 22)'>data</span> riportata nella lettera è evidenziata in colore arancione.</li><li>Una <span style='color:rgb(206, 171, 19)'>forma di lessico tecnico</span> riportata nella lettera è evidenziata in colore giallo.</li><li>Una <span style='color:rgb(29, 172, 117)'>citazione</span> riportata nella lettera è evidenziata in colore verde.</li></ul></fieldset></form><br>" );

	//barra con prev-next
	$("section.letterContainer").prepend("<div class='prevnext-bar'><span class='prev'><a href=''>&lt;&lt; Lettera precedente</a></span><span class='next'><a href=''>Lettera successiva &gt;&gt</a></span></div><br>");

	//funzionalità prev-next
	$("span.prev>a").each(function() {
		var HREF = $(this).attr("href");
		var letterNum = $('section.letterContainer>div.ui-tabs').attr('id');
		var numero = letterNum.substring(7, 9);
		if (numero != 1) {
			var HREFprev = HREF.replace(HREF, "../letters/" + String(Number(numero - 1)));
			$(this).attr("href", HREFprev);
		}
	});

	$("span.next>a").each(function() {
		var HREF = $(this).attr("href");
		var letterNum = $('section.letterContainer>div.ui-tabs').attr('id');
		var numero = letterNum.substring(7, 9);
		if (numero != 45) {
			var HREFnext = HREF.replace(HREF, "../letters/" + String(Number(+numero + 1)));
			$(this).attr("href", HREFnext);
		}
	});

	//numero id della lettera corrente nel centro del prev-next
	$('section.letterContainer>div.ui-tabs').each(function() {
		var letterNum = $(this).attr('id');
		var numero = letterNum.substring(7, 9);
		$("div.prevnext-bar").append("<span class='nomelettera' style='position:absolute;right:50%'>" + "Lettera " + numero + "</span>");
	});

	//trasformare <li.Item> in <a>
	$("li.Item").each(function() {
		var HREF = $(this).attr("href");
		//se href contiene "images"
		if (HREF.includes("images")) {
			$(this).replaceWith("<a class='Item' href='/" + HREF + "'>" + $(this).text() + "</a>");
		} else {
			$(this).replaceWith("<a class='Item' href='" + HREF + "'>" + $(this).text() + "</a>");
		}
	});

	$("ul.visualization>a").wrap("<li></li>");

	//ingannare immagine
	$("figure>img").each(function(){
		var SRC = "images/testata.jpg";
		$(this).attr("src", SRC);
	});

	$("li.Edition").each(function() {
		//var HREF = $(this).attr("href");
		$(this).replaceWith("<li class='Edition' href='./vespasiano/bibliografia'>" + "Former editor: " + $(this).text() + "</li>");
	});

	$("li.Identifier").each(function() {
		$(this).replaceWith("<li class='Identifier' href='./vespasiano/bibliografia'>Shelfmark: " + $(this).text() + "</li>");
	});
	////////////////////////////////////////////////////////////

	// CLEANING

	// elimina ed.parziale e ed. completa dalla lista
	$("ul.editions>li").each(function(){
		var content = $(this).text() ;
		if (content.includes("Ed. ")) {
			$(this).replaceWith("");
		};
	});
});
