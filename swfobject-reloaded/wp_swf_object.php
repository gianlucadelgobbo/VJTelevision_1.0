<?php

/*
Plugin Name: swfObject Reloaded
Plugin URI: http://www.codeandreload.com/wp-plugins/swfobjectreloaded
Description: This plugin allows easy embedding of swf files and better media management for swf files, allowing swf files to have a height, width, and their own minimum flash version.  This plugin adds a swfobject shortcode that can be inserted via the "Add media" button while editing a post.  SWF files are now also automatically embedded on their respective attachment pages.
Author: Robert Wise
Version: 1.6
Author URI: http://www.codeandreload.com
*/

/* http://www.adobe.com/devnet/flashplayer/articles/swfobject.html */
/* http://code.google.com/p/swfobject/wiki/documentation */

register_activation_hook( __FILE__, 'mc_swf_activate' );

require_once("wp_swf_shortcode.php");
require_once("wp_swf_settings.php");
require_once("wp_swf_media_options.php");


function mc_head() {
	if ( !is_admin() ) { 
	// don't do this for admin pages.
		wp_enqueue_script("swfobject");
	}
}

function is_int_id ($id) {
	return is_numeric("".$id);
}

add_action('init', 'mc_head');

?>
