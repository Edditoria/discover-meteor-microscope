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
