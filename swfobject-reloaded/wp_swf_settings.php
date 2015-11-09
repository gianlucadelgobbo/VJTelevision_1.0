<?php

function mc_swf_activate() {
	/*
	 	register_setting('media','mc_setting_name');
	 	register_setting('media','mc_iphone_setting_name');
	 	register_setting('media','mc_altcontent_setting_name');
	 	register_setting('media','mc_params_setting_name');
	*/

	if (!trim(get_option('mc_setting_name'))){
		update_option('mc_setting_name', true);
	}
	if (!trim(get_option('mc_iphone_setting_name'))){
		update_option('mc_iphone_setting_name', __("Sorry, flash content is not available on the iPhone."));
	}
	if (!trim(get_option('mc_altcontent_setting_name'))){
		update_option('mc_altcontent_setting_name', __("Sorry, either Adobe flash is not installed or you do not have it enabled"));
	}

	if (!trim(get_option('mc_feed_setting_name'))){
			$format = '<br />To view the flash content, please go to <a href="%2$s">%3$s</a><br />';
	//////	update_option('mc_feed_setting_name', $format);
	}
	/*
	if (!trim(get_option('mc_params_setting_name'))){
		update_option('mc_params_setting_name', __("Default params"));
	}
	*/

	if (!trim(get_option('mc_flashver_setting_name'))){
		update_option('mc_flashver_setting_name', __("9.0.0"));
	}

}?>
