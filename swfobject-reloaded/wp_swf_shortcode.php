<?php

	// attach our function to the correct hook
	add_shortcode('swfobject', 'mc_swf_shortcode');
	add_shortcode('swflink', 'mc_swf_link');	
	add_filter("attachment_fields_to_edit", "mc_image_attachment_fields_to_edit", null, 2);
	add_filter("attachment_fields_to_save", "mc_image_attachment_fields_to_save", null, 2);
	add_filter('media_send_to_editor', 'send_swf_to_editor', 10, 3);	
	//	add_filter('the_excerpt_rss', 'mc_feed_content');
	add_filter( "the_content", "mc_content", -9999999999999999999 );

	function send_swf_to_editor ($html, $id, $alt=null, $title=null, $align=null, $url=null){
		if (get_post_mime_type( $id ) == "application/x-shockwave-flash") {
			return "[swfobject]" .$id ."[/swfobject]";
		}	else {
			return $html;
		}
	}


	function mc_feed_content ($content) {
		global $post, $shortcode_tags;
		if (trim($post->post_content) && false) {
			$tempElem = $shortcode_tags["swfobject"];
			unset($shortcode_tags["swfobject"]);
			$content = strip_shortcodes( $post->post_content );
			$shortcode_tags["swfobject"] = $tempElem;
			$content = do_shortcode($content);			
		}
		return $content;
	}
	

	function mc_content ($content) {
		global $post;
		if (true && is_feed() && trim($post->post_content)) {
			global $post, $shortcode_tags;	
			$tempElem = $shortcode_tags["swfobject"];
			unset($shortcode_tags["swfobject"]);
			$contentA = strip_shortcodes( $post->post_content );
			$shortcode_tags["swfobject"] = $tempElem;
			$content = do_shortcode($contentA);			
			return $content;
		} elseif(is_feed()) {
			return $content;
		} elseif (get_post_mime_type( $post->ID )=="application/x-shockwave-flash"){
			return "" . mc_swf_shortcode( null, $post->ID) . "<p>" .$post->post_excerpt ."</p><p>"  .$post->post_content ."</p>";
		}
		else return $content;
	}



function mc_image_attachment_fields_to_save($post, $attachment) {
	// $attachment part of the form $_POST ($_POST[attachments][postID])
	// $post attachments wp post array - will be saved after returned
	//     $post['post_type'] == 'attachment'
	

	if( $post['post_type'] == 'attachment' && isset($attachment['mc_x'])  && is_int_id($attachment['mc_x'])){
		// update_post_meta(postID, meta_key, meta_value);
		update_post_meta($post['ID'], '_mc_x', $attachment['mc_x']);
	}
	if( $post['post_type'] == 'attachment' && isset($attachment['mc_y']) && is_int_id($attachment['mc_y'])){
		// update_post_meta(postID, meta_key, meta_value);
		update_post_meta($post['ID'], '_mc_y', $attachment['mc_y']);
	}
	if( $post['post_type'] == 'attachment' && isset($attachment['mc_base']) ){
		// update_post_meta(postID, meta_key, meta_value);
		update_post_meta($post['ID'], '_mc_base', $attachment['mc_base']);
	}
	if( $post['post_type'] == 'attachment' && isset($attachment['mc_swfver']) ){
		// update_post_meta(postID, meta_key, meta_value);
		update_post_meta($post['ID'], '_mc_swfver', $attachment['mc_swfver']);
	}
	
	return $post;
}

function mc_image_attachment_fields_to_edit($form_fields, $post) {
	// $form_fields is a special array of fields to include in the attachment form
	// $post is the attachment record in the database
	//     $post->post_type == 'attachment'
	// (attachments are treated as posts in WordPress)

	// add our custom field to the $form_fields array
	// input type="text" name/id="attachments[$attachment->ID][custom1]"

	if (get_post_mime_type($post->ID) == "application/x-shockwave-flash") {

		$form_fields["custom_line"]["label"] = "";
		$form_fields["custom_line"]["input"] = "html";
		$form_fields["custom_line"]["html"] = "<hr />";

		$form_fields["mc_x"]["label"] =  __("Width");
		$form_fields["mc_x"]["input"] = "text";
		$form_fields["mc_x"]["value"] = get_post_meta($post->ID, "_mc_x", true);
		
		$form_fields["mc_y"]["label"] =  __("Height");
		$form_fields["mc_y"]["input"] = "text";
		$form_fields["mc_y"]["value"] = get_post_meta($post->ID, "_mc_y", true);

		$form_fields["mc_base"]["label"] =  __("Base");
		$form_fields["mc_base"]["input"] = "text";
		$form_fields["mc_base"]["value"] = get_post_meta($post->ID, "_mc_base", true);

		$form_fields["mc_base"]["label"] =  __("SWF Version");
		$form_fields["mc_base"]["input"] = "text";
		$form_fields["mc_base"]["value"] = get_post_meta($post->ID, "_mc_swfver", true);

	}
	return $form_fields;
}

/// [swfobject]ID, X, Y, flashvars, Base [/swfobject]


function mc_swf_shortcode( $atts=null, $content = null, $code="", $contentStringOveride="" ) {
	global $swf_instance;
	global $post;
	$swf_instance++;
	
	if (trim($atts["delimiter"])){
		$delim = trim($atts["delimiter"]);
	} else {
		$delim = "|";
	}

	// strings to use the option API.
	if (trim($contentStringOveride)){
		$contentline = $contentStringOveride;
	} else if(isset($atts["altcontent"]) && trim($atts["altcontent"])){
		$contentline = $atts["altcontent"];	
	} else {
		$contentline = get_option('mc_altcontent_setting_name');
	}
	
	$scale_to_medium = get_option('mc_setting_name');
	$iphone_message = get_option('mc_iphone_setting_name');
	$feed_message = get_option('mc_feed_setting_name');
	$max_width  = get_option('embed_size_w');
	$max_height = get_option('embed_size_h');

	$content = explode(",",$content);
	$contentbefore = $content[0];

	if ($content[4]){
		$content[4] = " base:\"" . $content[4] . "\"";
	}

	if (	is_int_id(trim($content[0]))	){

		if (get_post_mime_type( $content[0] )!="application/x-shockwave-flash"){
			return "<br />" .__("Error: Attachment is not available or is not Flash content.") ."<br />";
		}
		if (!$content[4]){
			get_post_meta($content[0], "_mc_base", true);
		}
		if (!$content[4]){
			$content[4]= 'base:"' . mc_strip_swf_basetag(wp_get_attachment_url($content[0])) . "\"";
		} elseif ($content[4] == "null"){
			$content[4]="";			
		}			 

		if (!$content[1]){
			$content[1] =  get_post_meta($content[0], "_mc_x", true);
		}

		if (!$content[2]){
			$content[2] =  get_post_meta($content[0], "_mc_y", true);
		}
		$flash_ver = get_post_meta($content[0], '_mc_swfver', true);
		$content[0] = wp_get_attachment_url($content[0]);

	} elseif ($content[0] && !$content[4] ) {

	// if the swf location is valid there is no base argument then determine it
		if (!$content[4]){
			$content[4]= 'base:"' . mc_strip_swf_basetag($content[0]) . "\"";
		} elseif ($content[4] == "null"){
			$content[4]="";			
		}			 
	}


		if (!$flash_ver){
			$flash_ver = get_option('mc_flashver_setting_name');
		}
		if (!$flash_ver){
			$flash_ver = "9.0.0";
		}


	/// dimension heirarchy; dimension provided by shortcode, dimension assigned to the media, dimension provided in the 'Maximum embed size', dimension provided in the 'Image-sizes: Medium size', 
	/// Scales to dimension provided in the 'Maximum embed size', dimension provided in the 'Image-sizes: Medium size';

	if (!$max_width){
		$max_width  = get_option('medium_size_w');
	}
	if (!$max_height){
		$max_height  = get_option('medium_size_h');
	}

	if (!$content[1]){
		$content[1] = $max_width;
	}

	if (!$content[2]){
		$content[2] = $max_height;
	}

	if ($scale_to_medium && $max_height && $max_width) {
		list( $content[1], $content[2] ) = wp_expand_dimensions( $content[1], $content[2], $max_width, $max_height );
	}

	if (!$content[1] && !$content[2]){
		return __("Error: Dimensions are not specified.");
	} elseif(!(strpos($_SERVER['HTTP_USER_AGENT'], "iPhone") === false)) {
		if (is_feed()){		
			echo $iphone_message."<br /><br />";
			return "";
		} else {
			return $iphone_message;
		}
	} elseif(is_feed()){
		if(!trim($feed_message)){
			$format = 'To view the flash content, please go to <a href="%2$s">%3$s</a>';
		} else {
			$format = $feed_message;
		}

		if ($post->ID == $contentbefore[0]) {
			// the post is the media itself. 
			$myPermalink = "$post->guid";
		}
		else {	
			// the media is embedded on a post.
			$myPermalink = get_permalink();
		}

		echo sprintf($format, $post->ID, $myPermalink, $post->post_title) . "<br /><br />";
		return "";

		}  elseif ($content[0]) {
		// allow flashvars to have quotes because tinyMCE has annoying quotes.
		$content[3] = str_replace("&#8217;", "'", $content[3]);
		$content[3] = str_replace("&#8221;", '"', $content[3]);

		if ($post->ID == $contentbefore) {
			// the post is the media itself. 
			$myPermalinkA = "$post->guid";
		}
		else {	
			// the media is embedded on a post.
			$myPermalinkA = $content[0];
		}


		$echoline = "<span id='swf-".$post->ID."-".$swf_instance."'>". $contentline ."</span>";


		$sw = '<script type="text/javascript">swfobject.embedSWF(';
	
		/// File URL
		$sw .= '"' . $content[0] . '"';
		/// New ID
		$sw .= ', "swf-'	.$post->ID	."-"	.$swf_instance . '"';
		/// X
		$sw .= ', "' . trim($content[1]) . '"';
		/// Y
		$sw .= ', "' . trim($content[2]) . '"';
		/// flash_ver
		$sw .= ', "' . trim($flash_ver ) . '"';
		/// flashvars
		$sw .= ', "" ';		
		$sw .= ', {' . str_replace($delim, ", ", trim($content[3] )) . '}';
		/// base
		$mc_are_global_params = get_option('mc_params_setting_name');
		$sw .= ', {' . trim($content[4]);
			if (trim($mc_are_global_params)) {
			$sw .= "," . $mc_are_global_params;
			}
		$sw .=  '}';
		$sw .= ');</script>';
	
		return $echoline . $sw;
	}
	else {
		return "<br />" .__("ERROR: Error Embedding SWF") ."<br />";
	}

}

function mc_swf_link($atts,$content = null ){
	if (is_int($content) || ctype_digit($content) && trim(get_post_mime_type($content))){
		return "<a href='".get_permalink( $content )."' rel='attachment wp-att-$content'>".apply_filters( 'the_title',get_the_title($content), $content)."</a>";
	}
}

function mc_strip_swf_basetag($inp) {	

	$inp_array = explode("/", $inp);
	
	if(!$inp_array[count($inp_array)-1]){
		unset($inp_array[count($inp_array)-1]);
		// remove the trailing slash.
		// remove the last part of the path '/flash.swf/';
	}
	
	unset($inp_array[count($inp_array)-1]);
	// remove the last part of the path '/flash.swf';
	
	if (count($inp_array)){
		return (implode("/", $inp_array));
	}
	
}

?>