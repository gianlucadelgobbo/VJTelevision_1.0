<?php

 // ------------------------------------------------------------------
 // Add all your sections, fields and settings during admin_init
 // ------------------------------------------------------------------
 //
 
 function eg_settings_api_init() {
 	// Add the section to reading settings so we can add our fields to it
 	add_settings_section('mc_setting_section', '<hr />' . __("swfobject settings"), 'mc_setting_section_callback_function', 'media');
 	
 	// Add the field with the names and function to use for our new settings, put it in our new section
 	add_settings_field('mc_setting_name', __('Scale Flash content (while preserving aspect ratio)'), 'mc_setting_callback_function', 'media', 'mc_setting_section');
 	add_settings_field('mc_iphone_setting_name', __('iPhone Alternate content'), 'mc_iphone_callback_function', 'media', 'mc_setting_section');
 	add_settings_field('mc_feed_setting_name', __('Feed Alternate content'), 'mc_feed_callback_function', 'media', 'mc_setting_section');
 	add_settings_field('mc_altcontent_setting_name', __('Alternate Content'), 'mc_altcontent_callback_function', 'media', 'mc_setting_section');
 	add_settings_field('mc_params_setting_name', __('additional params'), 'mc_params_callback_function', 'media', 'mc_setting_section');
 	add_settings_field('mc_flashver_setting_name', __('Minimum Flash version'), 'mc_flashver_callback_function', 'media', 'mc_setting_section');
 	
 	// Register our setting so that $_POST handling is done for us and our callback function just has to echo the <input>
 	register_setting('media','mc_setting_name');

	register_setting('media','mc_setting_name');
	register_setting('media','mc_iphone_setting_name');
	register_setting('media','mc_feed_setting_name');
	register_setting('media','mc_altcontent_setting_name');
	register_setting('media','mc_params_setting_name');
	register_setting('media','mc_flashver_setting_name');


 }// eg_settings_api_init()
 
 add_action('admin_init', 'eg_settings_api_init');
 
  
 // ------------------------------------------------------------------
 // Settings section callback function
 // ------------------------------------------------------------------
 //
 // This function is needed if we added a new section. This function 
 // will be run at the start of our section
 //
 
 function mc_setting_section_callback_function() {
 	echo '<p>' . __("The settings below define how Flash content will be embedded with the ") . "<code>[swfobject][/swfobject]</code>" .__("shortcode") .'</p>';
 }

 
 // ------------------------------------------------------------------
 // Callback function for our example setting
 // ------------------------------------------------------------------
 //
 // creates a checkbox true/false option. Other types are surely possible
 //
 
 function mc_setting_callback_function() {
 	$checked = "";
 	
 	// Mark our checkbox as checked if the setting is already true
 	if (get_option('mc_setting_name')) 
 		$checked = " checked='checked' ";
 
 	echo "<input {$checked} name='mc_setting_name' id='gv_thumbnails_insert_into_excerpt' type='checkbox'
 value='mc_setting_name' class='code' /> " . __("Leaving this unchecked means that content is not scaled and excessively large or small flash files will remain excessively large or small ");
 } // mc_setting_callback_function()


 function mc_iphone_callback_function() {
	echo "<input id='mc_iphone_setting_name' name='mc_iphone_setting_name' size='40' type='text' value='" .get_option('mc_iphone_setting_name') ."' />";
	echo " this content will show if the Flash detection fails due to the user using an iPhone.";
 } // mc_setting_callback_function()

 function mc_feed_callback_function() {
	echo "<input id='mc_feed_setting_name' name='mc_feed_setting_name' size='40' type='text' value='" .get_option('mc_feed_setting_name') ."' />";
	$s = "$s";
	echo 'this content will show if the feed (rss, atom etc.) is being displayed. Use %1$s for the post-id, %2$s for the post\'s permalink, and %3$s for the swf\'s title; If no value is specified it will default to:';

$format = '<br />To view the flash content, please go to <&#97; href="%2$s">%3';
$format2 = '$s';

echo "<code>".$format.$format2."<<span></span>/<span>&#97;</span>></code>";

 } // mc_setting_callback_function()


function mc_altcontent_callback_function() {
 	echo "<input id='mc_altcontent_setting_name' name='mc_altcontent_setting_name' size='40' type='text' value='" .get_option('mc_altcontent_setting_name') ."' />";
	echo " this content will show if the Flash detection fails.";
 } // mc_setting_callback_function()


function mc_params_callback_function() {
 	echo "<input id='mc_params_setting_name' name='mc_params_setting_name' size='40' type='text' value='" .get_option('mc_params_setting_name') ."' />";
	echo __('These are the parameters  in name:"value" pairs that are applied to every instance of the swfobject shortcode. See this page on ') . "<a href='http://kb2.adobe.com/cps/127/tn_12701.html'>Flash OBJECT and EMBED tag attributes</a> " . __("for more information about using parameters. Example parameter usage: ") . '<code>wmode:"transparent", quality:"low"</code>';
 } // mc_setting_callback_function()

function mc_flashver_callback_function() {
 	echo "<input id='mc_flashver_setting_name' name='mc_flashver_setting_name' size='40' type='text' value='" .get_option('mc_flashver_setting_name') ."' />";
	echo __("This is the minimum flash version that can be embedded on your blog. This can be overridden by setting the value on the media itself.");
 } // mc_setting_callback_function()


?>
