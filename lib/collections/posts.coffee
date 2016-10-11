@Posts = new Mongo.Collection 'posts'

Posts.allow
  update: (userId, post) -> ownsDocument userId, post
  remove: (userId, post) -> ownsDocument userId, post

Posts.deny
  update: (userId, post, fieldNames) ->
    # note that length is 0 in normal case
    # so, if someone do things other than normal process, length will become 0
    _.without(fieldNames, 'url', 'title').length > 0

Posts.deny
  update: (userId, post, fieldNames, modifier) ->
    errors = validatePost modifier.$set
    errors.title or errors.url


# removed:
# Posts.allow
#   insert: (userId, doc) -> return !!userId
# use Meteor method instead
Meteor.methods
  postInsert: (postAttributes)->
    check Meteor.userId(), String
    check postAttributes, {
      title: String
      url: String
    }

    # this will be activated when user do wried things
    # such as add a post via browser console
    # to test, do in browser conosole:
    # Meteor.call('postInsert', {url: '', title: 'No URL here!'});
    errors = validatePost postAttributes
    if errors.title or errors.url
      msg = 'You must set a title and URL for your post'
      throw new Meteor.Error('invalid-post', msg)

    # check if the submitting post is already exist
    postWithSameLink = Posts.findOne { url: postAttributes.url }
    if postWithSameLink
      return {
        postExists: true
        _id: postWithSameLink._id
      }

    user = Meteor.user()
    post = _.extend postAttributes, {
      userId: user._id
      author: user.username
      submitted: new Date()
      commentsCount: 0
      upvoters: []
      votes: 0
    }
    postId = Posts.insert post
    _id: postId
    # note: _.extend comes from Underscore package

  upvote: (postId) ->
    check @userId, String
    check postId, String

    # lower preformance; and double vote may occur if clicking is done before checking is finished.
    # post = Posts.findOne postId
    # if !post
    #   throw new Meteor.Error 'invalid', 'Post not found'
    # if _.include post.upvoters, @userId
    #   throw new Meteor.Error 'invalid', 'Already upvoted this post'
    # Posts.update post._id,
    #   $addToSet: {upvoters: @userId}
    #   $inc: {votes: 1}

    # do this instead:
    # update operation will $inc vote only if upvoters do not contains ($ne) @userId. Then, return true
    affected = Posts.update
      _id: postId
      upvoters: {$ne: @userId}
      {
        $addToSet: {upvoters: @userId}
        $inc: {votes: 1}
      }
    if not affected
      throw new Meteor.Error 'invalid', 'You weren\'t able to upvote that post'

    return


@validatePost = (post) ->
  errors = {}
  if !post.title
    errors.title = 'Please fill in a headline'
  if !post.url
    errors.url = 'Please fill in a URL'
  errors
