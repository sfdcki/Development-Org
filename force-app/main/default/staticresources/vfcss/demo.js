$(function(){
	$(".source").toggle(function() {
		$(".source-area", $(this).parent()).show();
		$(this).text("Hide JavaScript Code");
	}, function() {
		$(".source-area", $(this).parent()).hide();
		$(this).text("Show JavaScript Code");
	}).parent().addClass("noprint");
});