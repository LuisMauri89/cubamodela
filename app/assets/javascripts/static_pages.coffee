# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->

	carousel = $('#home-banner-carousel');

	triggerAnimations = (items) ->
		animEndEv = 'webkitAnimationEnd animationend';

		items.each ->
			element = $(this);
			animation = element.data('animation');
			delay = element.data('delay');

			element.css('animation-delay': delay);

			element.addClass(animation).one animEndEv, ->
				element.removeClass(animation);

	firstSlide = carousel.find('.item:first').find('[data-animation ^= "animated"]');
	triggerAnimations(firstSlide);

	carousel.on 'slide.bs.carousel', (e) ->
		items = $(e.relatedTarget).find("[data-animation ^= 'animated']");
		triggerAnimations(items);

	funcWaypoint = (direction) ->
		if direction == 'down'
			container = $(this);
			items = container.find("[data-animation ^= 'animated']");
			triggerAnimations(items);

	$('.notify').waypoint(funcWaypoint, { offset:'95%' });

	$('#test').click ->
		alert("My example alert box.");