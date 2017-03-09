# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->

	if $('#booking-id').length > 0
		booking_id = $('#booking-id').text();
		$.getScript("/chat_messages/index/scoped/" + booking_id + "/Booking");
	
	chboxContainer = $('#chbox-direct-container');
	chbox = chboxContainer.find(':checkbox');

	chbox.click ->
		if $(this).is(':checked')
			$('#casting-date-field').hide();
		else
			$('#casting-date-field').show();
		
