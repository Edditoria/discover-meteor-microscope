Template.postItem.helpers
  ownPost: ->
    @userId is Meteor.userId()
  domain: ->
    a = document.createElement 'a'
    a.href = @url
    a.hostname
  ### removed since the data can be found in the post
  commentsCount: ->
    Comments.find(
      postId: @_id
    ).count()
  ###
  upvotedClass: ->
    userId = Meteor.userId()
    if userId and !_.include(@upvoters, userId)
      'btn-primary upvotable'
    else
      'disabled'

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id
