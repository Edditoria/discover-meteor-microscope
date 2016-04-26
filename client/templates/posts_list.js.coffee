postsData = [
  {
    title: 'Awesome book to get start with Meteor.js'
    url: 'https://www.discovermeteor.com/'
    domain: '#todo: test: work on \'domain\' later'
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
