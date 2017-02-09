$(document).on "turbolinks:load", ->
	$('#spinner-container').hide();

	$(document).on "turbolinks:request-start", ->
		$('#spinner-container').show();

	$(document).on "turbolinks:request-end", ->
		$('#spinner-container').hide();

	$('.show-spinner').click ->
		$('#spinner-container').show();

	$('.show-spinner').on "ajax:success", ->
		$('#spinner-container').hide();

	$('.show-spinner').on "ajax:error", ->
		alert("Sorry, connection request failed.");

	$('.form-remote-spinner').on "ajax:success", ->
		$('#spinner-container').hide();

	$('.form-remote-spinner').on "ajax:error", ->
		alert("Sorry, connection request failed.");