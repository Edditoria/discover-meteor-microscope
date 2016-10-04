Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> [
    Meteor.subscribe 'posts'
  ]

Router.route '/', name: 'postsList'

Router.route '/posts/:_id', {
  name: 'postPage'
  waitOn: ->
    Meteor.subscribe 'comments', @params._id
  data: -> Posts.findOne @params._id
}
Router.route '/posts/:_id/edit', {
  name: 'postEdit'
  data: -> Posts.findOne @params._id
}
Router.route '/submit', name: 'postSubmit'


requireLogin = ->
  if not Meteor.user()
    if Meteor.loggingIn()
      @render(@loadingTemplate)
    else @render('accessDenied')
  else @next() # also take care of Router.onBeforeAction requireLogin

Router.onBeforeAction 'dataNotFound', only: 'postPage'

Router.onBeforeAction requireLogin, only: 'postSubmit'