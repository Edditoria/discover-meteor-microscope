Template.commentSubmit.onCreated ->
  Session.set 'commentSubmitErrors', {}

Template.commentSubmit.helpers
  errorMessage: (field) ->
    Session.get('commentSubmitErrors')[field]
  errorClass: (field) ->
    !!Session.get('commentSubmitErrors')[field] ? 'has-error' : ''

Template.commentSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()
    $body = $(e.target).find '[name=body]'
    comment =
      body: $body.val()
      postId: template.data._id
    errors = {}
    if !comment.body
      errors.body = 'Please write some content'
      return Session.set 'commentSubmitErrors', errors
    Meteor.call 'commentInsert', comment, (error, commentId) ->
      if error then throwError error.reason
      else $body.val ''
