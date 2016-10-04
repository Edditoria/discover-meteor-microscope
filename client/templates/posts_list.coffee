Template.postsList.helpers
  posts: ->
    Posts.find {}, {sort: {submitted: -1}} # sort (newer first)

### removed since Posts is inserted in MongoDB
postsData = [
  {
    title: 'Awesome book to get start with Meteor.js'
    url: 'https://www.discovermeteor.com'
  }
  {
    title: 'Meteor.js'
    url: 'https://www.meteor.com/'
  }
  {
    title: 'this repo: Discover Meteor: Microscope'
    url: 'https://github.com/Edditoria/discover-meteor-microscope'
  }

]

Template.postsList.helpers { posts: postsData }

###
