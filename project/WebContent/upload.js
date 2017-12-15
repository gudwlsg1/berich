$(document).ready(function(){
	$("#browsebutton").on('click', function(){
		$("#fileinput").trigger('click');
	});
	$("#filename").on('click', function(){
		
		$("#fileinput").trigger('click');
	});
	$("#fileinput").on('change',function(){
		  $("#filename").val($("#fileinput").val().replace(/C:\\fakepath\\/i, ''));
	});
});