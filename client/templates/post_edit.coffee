Template.postEdit.onCreated ->
  Session.set 'postEditErrors', {}
  return
# similar code: post_submit.js.coffee

Template.postEdit.helpers
  errorMessage: (field) ->
    Session.get('postEditErrors')[field]
  errorClass: (field) ->
    if !!Session.get('postEditErrors')[field] then 'has-error' else ''
# - to test, do in browser console:
#   Session.set('postEditErrors', {title: 'Warning'});
# - similar code: post_submit.js.coffee


Template.postEdit.events
  # submit form and click delete

  'submit form': (e) ->
    e.preventDefault()
    currentPostId = @_id
    postProperties = {
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()
    }

    # will stop 'submit form' and display reason
    errors = validatePost postProperties
    if errors.title or errors.url
      return Session.set 'postEditErrors', errors
    # similar code: post_submit.js.coffee

    Posts.update currentPostId, { $set: postProperties }, (error) ->
      if (error) then throwError error.reason
      else Router.go 'postPage', { _id: currentPostId }
      return
    return

  'click .delete': (e) ->
    e.preventDefault()
    if confirm('Delete this post?')
      currentPostId = @_id
      Posts.remove currentPostId
      Router.go 'postsList'
    return
