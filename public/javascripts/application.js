// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function loadComments(gallery_id)
{
  var url = '/galleries/' + gallery_id + '/comments';
  new Ajax.Request(url, { method: 'get', asynchronous:true, evalScripts:true } );
}

function loadAllComments()
{
  var url = '/comments';
  new Ajax.Request(url, { method: 'get', asynchronous:true, evalScripts:true } );
}