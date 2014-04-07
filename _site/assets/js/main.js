$(function () {
	if ($('body.cv').length == 1) {
		$('.picto-email').bind('click', function () {
			$(this).parent().siblings('.email').fadeToggle();

			return false;
		});
	}
});