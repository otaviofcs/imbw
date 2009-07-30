// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function loadComments(gallery_id)
{
  var url = '/galleries/' + gallery_id + '/comments';
  new Ajax.Updater('comments',  url, { method: 'get' } );
}