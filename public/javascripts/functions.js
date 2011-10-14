// Side Navigation Menu Slide

$(document).ready(function() {
	$("#nav > li > a.collapsed + ul").slideToggle("medium");
	$("#nav > li > a").click(function() {
		$(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
	});
});
		
// Tab Switching

	$(document).ready(function(){
		$("#tabs, #graphs").tabs();
	});	

