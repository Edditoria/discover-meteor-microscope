@Posts = new Mongo.Collection 'posts'

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
    user = Meteor.user()
    post = _.extend postAttributes, {
      userId: user._id
      author: user.username
      submitted: new Date()
    }
    postId = Posts.insert post
    _id: postId
    # note: _.extend comes from Underscore package
