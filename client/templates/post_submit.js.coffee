Template.postSubmit.onCreated ->
  Session.set 'postSubmitErrors', {}
  return
# similar code: post_edit.js.coffee

Template.postSubmit.helpers
  errorMessage: (field) ->
    Session.get('postSubmitErrors')[field]
  errorClass: (field) ->
    if !!Session.get('postSubmitErrors')[field] then 'has-error' else ''
# - to test, do in browser console:
#   Session.set('postSubmitErrors', {title: 'Warning'});
# - similar code: post_edit.js.coffee


Template.postSubmit.events
  'submit form': (e) ->
    e.preventDefault()
    post = {
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()
    }

    # will stop 'submit form' and display reason
    errors = validatePost post
    if errors.title or errors.url
      return Session.set 'postSubmitErrors', errors
    # similar code: post_edit.js.coffee

    # remove:
    # post._id = Posts.insert post
    # Router.go 'postPage', post
    # use the Meteor method instead:
    Meteor.call 'postInsert', post, (error, result) ->
      # show error and exit
      if error
        # return throwError error.reason
        return Errors.throw error.reason
      # alert message if submitting post already exists
      if result.postExists
        # throwError 'This link has already been posted'
        return Errors.throw 'This link has already been posted'

      Router.go 'postPage', _id: result._id
      return
