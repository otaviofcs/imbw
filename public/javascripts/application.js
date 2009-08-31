// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function load_comments(gallery_id)
{
  var url = '/galleries/' + gallery_id + '/comments.js';
  $.getScript(url);
}

function load_all_comments()
{
  var url = '/comments.js';
  $.getScript(url);
}