# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
	
	if $('#contractor-id').length > 0
		contractor_id = $('#contractor-id').text();
		$.getScript("/castings/casting_reviews/" + contractor_id);

	if $('#casting-id').length > 0
		casting_id = $('#casting-id').text();
		$.getScript("/chat_messages/index/scoped/" + casting_id + "/Casting");
	
	chboxContainer = $('#chbox-direct-container');
	chbox = chboxContainer.find(':checkbox');

	chbox.click ->
		if $(this).is(':checked')
			$('#casting-date-field').hide();
		else
			$('#casting-date-field').show();