=== swfObject Reloaded ===  
Contributors: CodeAndReload  
Donate link: http://www.codeandreload.com/wp-plugins/swfobjectreloaded#donate  
Tags: media, swf, animation, flash, flex, javascript, embed, insert, media-button, shortcode, upload  
Requires at least: 2.9
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
Tested up to: 3.4.2  
Stable tag: 1.6  


Allows easy embedding (shortcode inserted via Add Media button while posting) and better management of swf files.


== Description ==

This plugin allows easy embedding of swf files and better media management for swf files, allowing swf files to have a
height, width, and their own minimum flash version.  This plugin adds a swfobject shortcode that can be inserted via
the "Add media" button while editing a post.  SWF files are now also automatically embedded on their respective
attachment pages.


== Installation ==

Installation is simple and straight-forward:

1. Upload `swfobject_reloaded.zip` to the `/wp-content/plugins/` directory
1. Activate the plugin through the 'Plugins' menu in WordPress.
1. Configure the plugin options under the 'Settings->Media' menu in WordPress. Don't forget to Save Changes!


== Frequently Asked Questions ==


= How do I embed a swf in a post (or on a page)? =

To embed a swf in a post (or page), do the following:

1. Upload the swf, either directly into the Media Library or when creating or editing the post (or page).
1. Enter the width and height of the swf.  If the swf requires a different version of Flash than you have
configured in the 'Settings->Media' menu in WordPress, enter that version number also.
1. Click 'Insert into Post' to embed the swf.  This will add the swfobject shortcode to the post (or page).
1. At this point, you can edit the shortcode to provide other parameters for the swf, if desired.


= What are the other parameters available for use with the swfobject shortcode? =

At a minimum, the swf media file must be specified, either as the media ID number (entered automatically by
swfObject Reloaded when the swf is inserted into the post or page), or as a URL.

Here are all the parameters that can be specified:

1. media ID or URL (required)
1. width
1. height
1. flashvars
1. base

Parameters must be entered in the order shown. To skip a parameter, just leave it completely blank (*i.e.*,
don't type anything) followed by the comma to separate it from the next parameter.

See [Flash OBJECT and EMBED tag attributes](http://kb2.adobe.com/cps/127/tn_12701.html "Flash OBJECT and EMBED
tag attributes on Adobe website") for more information on using the flashvar and base parameters.

Examples:  

>    `[swfobject]573[/swfobject]`
>>This is the simplest usage, specifying only the media ID of the swf.

>    `[swfobject]http://www.example.com/test.swf,300,200[/swfobject]`
>>Another simple example using an external URL.  Note that the width and height parameters *should* be specified.

>    `[swfobject]http://www.example.com/test2.swf,250,120,foo:"bar"|bar:"baz",http://www.example.com/[/swfobject]`
>>    This example uses an external URL, and includes the width, height, flashvar (foo:"bar" and bar:"baz") and base
(http://www.example.com/) parameters.

	Flashvars are separated by a delimiter that cannot be a comma. You can change the delimiter by passing a delimiter attribute.
	`[swfobject delimiter='&']12,,,foo:"bar"&bar:"baz"[/swfobject]`


= What if I only want to display a link to the attachment page? =

Use the `swflink` shortcode in the form of `[swflink]ID[/swflink]`.
For example `[swflink]573[/swflink]`


= What size will the swf file be when displayed? =

The screen size of the swf file is determined by checking for the following, in this order:

1. dimensions specified in the shortcode
1. dimensions assigned to the media in the Media Libary
1. dimensions configured as the "Maximum Embed Size" on the Settings->Media menu
1. dimensions configured as the "Image Sizes->Medium Size" on the Settings->Media menu

If none of those are found, an error message will be displayed instead of the swf.


= What is the maximum size to which the swf will will be scaled? =

If Scale Flash Content is checked, the screen size of the swf file will be scaled (preserving its aspect ratio) to:

1. dimensions configured as the "Maximum Embed Size" on the Settings->Media menu
1. dimensions configured as the "Image Sizes->Medium Size" on the Settings->Media menu


= What are the various swfobject settings on the Media menu? =

The settings define how Flash content will be embedded with the shortcode, as follows:

* Scale Flash content - Checking this box will cause excessively large or small flash content to be scaled to
the "Maximum embed size", if any, entered on the 'Settings->Media' menu (or the "Medium Size" on that same
menu if no maximum size is entered).  The original aspect ratio will be preserved.

* iPhone Alternate content - iPhones do not currently support Flash content.  The text entered here will be
displayed if the user is accessing the site via an iPhone.

* Alternate Content - If Flash is not detected on the user's browser, the text entered here will be displayed.

* additional params - These are the parameters in name:"value" pairs that are applied to every instance of the
swfobject shortcode.  See [Flash OBJECT and EMBED tag attributes](http://kb2.adobe.com/cps/127/tn_12701.html
"Flash OBJECT and EMBED tag attributes on Adobe website") for more information on using parameters.

* Minimum Flash version - This is the minimum Flash version that can be embedded on your blog.  This can be
overridden by setting the value on the media itself when it's added to the Media Library.


== Screenshots ==

1. This is the media upload screen showing the new fields added by **swfObject Reloaded** for Width, Height and
SWF Version.
2. This is the swfObject's settings added to the Settings->Media menu.


== Changelog ==

= 1.0 =  
* Initial public release.
= 1.2 =  
* Added support for the feed so that a sprintf'd string is used instead of a swfobject.
= 1.3 =  
* Fixed the way the shortcode is returned from the Insert Media button on tinyMCE and set the content to an earlier priority.
= 1.4 =  
* Added the default values for the arguments in the send_swf_to_editor function.
= 1.5 =  
* Fixed an error that occurred in certain version of IE. Fixed the way the shortcode appears in the feed, it now appears at the top of the article in the feed. Removed break tags from being displayed before the swf.
= 1.6 =  
* Added better support for flashvars with the ability to set your own delimiter, added the [swflink] shortcode for linking to an attachment page instead of embedding flash content. Fixed and error that was causing flashvars to not be used.


== Upgrade Notice ==

= 1.0 =  
* Initial public release.
= 1.2 =  
* Added support for the feed so that a sprintf'd string is used instead of a swfobject.
= 1.3 =  
* Fixed the way the shortcode is returned from the Insert Media button on tinyMCE and set the content to an earlier priority.
= 1.4 =  
* Minor Fix: Added the default values for the arguments in the send_swf_to_editor function.
= 1.5 =  
* Fixed an error that occurred in certain version of IE. Fixed the way the shortcode appears in the feed, it now appears at the top of the article in the feed. Removed break tags from being displayed before the swf.
= 1.6 =  
* Added better support for flashvars with the ability to set your own delimiter, added the [swflink] shortcode for linking to an attachment page instead of embedding flash content. Fixed and error that was causing flashvars to not be used.



== Support ==

Technical support for this plugin will be provided via the WordPress plugin forum.  Additional support may be
available at [plugin's homepage](http://www.codeandreload.com/wp-plugins/swfobjectreloaded "swfObject Reloaded
at Code and Reload").