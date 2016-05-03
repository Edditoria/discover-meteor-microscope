@Posts = new Mongo.Collection 'posts'

Posts.allow
  update: (userId, post) -> ownsDocument userId, post
  remove: (userId, post) -> ownsDocument userId, post

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
    }
    postId = Posts.insert post
    _id: postId
    # note: _.extend comes from Underscore package
