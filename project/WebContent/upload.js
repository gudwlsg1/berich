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
	$("#browsebutton2").on('click', function(){
		$("#fileinput2").trigger('click');
	});
	$("#filename2").on('click', function(){
		
		$("#fileinput2").trigger('click');
	});
	$("#fileinput2").on('change',function(){
		  $("#filename2").val($("#fileinput2").val().replace(/C:\\fakepath\\/i, ''));
	});
});