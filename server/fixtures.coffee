if Posts.find().count() is 0

  # create 2 users
  tomId = Meteor.users.insert
    profile:
      name: 'Tom Coleman'
  tom = Meteor.users.findOne tomId
  sachaId = Meteor.users.insert
    profile:
      name: 'Sacha Greif'
  sacha = Meteor.users.findOne sachaId

  # create 3 posts and 2 comments

  now = new Date().getTime()

  initPostId = Posts.insert
    title: 'Awesome book to get start with Meteor.js'
    userId: sacha._id
    author: sacha.profile.name
    url: 'https://www.discovermeteor.com'
    submitted: new Date(now - 7 * 3600 * 1000)
    commentsCount: 2
  Comments.insert
    postId: initPostId
    userId: tom._id
    author: tom.profile.name
    submitted: new Date(now - 5 * 3600 * 1000)
    body: 'Interesting project. Can I do it too?'
  Comments.insert
    postId: initPostId
    userId: sacha._id
    author: sacha.profile.name
    submitted: new Date(now - 3 * 3600 * 1000)
    body: 'Yes. You Can!'

  Posts.insert
    title: 'Meteor.js'
    userId: tom._id
    author: tom.profile.name
    url: 'https://www.meteor.com/'
    submitted: new Date(now - 10 * 3600 * 1000)
    commentsCount: 0
  Posts.insert
    title: 'this repo: Discover Meteor: Microscope'
    userId: tom._id
    author: tom.profile.name
    url: 'https://github.com/Edditoria/discover-meteor-microscope'
    submitted: new Date(now - 12 * 3600 * 1000)
    commentsCount: 0

  for i in [1..20]
    Posts.insert
      title: "Auto post ##{i}"
      author: sacha.profile.name
      userId: sacha._id
      url: "http://google.com/?q=test-#{i}"
      submitted: new Date(now - i * 3600 * 1000)
      commentsCount: 0
