Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'notifications'

@PostsListController = RouteController.extend
  template: 'postsList'
  increment: 5
  postsLimit: -> parseInt(@params.postsLimit) or @increment
  findOptions: -> {
    sort: {submitted: -1}
    limit: @postsLimit()
  }
  subscriptions: ->
    @postsSub = Meteor.subscribe 'posts', @findOptions()
    return
  # waitOn: -> Meteor.subscribe 'posts', @findOptions()
  posts: -> Posts.find {}, @findOptions()
  data: ->
    hasMore = @posts().count() is @postsLimit()
    nextPath = @route.path
      postsLimit: @postsLimit() + @increment
    {
      posts: @posts()
      ready: @postsSub.ready
      nextPath: if hasMore then nextPath else null
    }


# removed and use /:postsLimit? instead
# Router.route '/', name: 'postsList'

Router.route '/posts/:_id', {
  name: 'postPage'
  waitOn: -> [
    Meteor.subscribe 'singlePost', @params._id
    Meteor.subscribe 'comments', @params._id
  ]
  data: -> Posts.findOne @params._id
}
Router.route '/posts/:_id/edit', {
  name: 'postEdit'
  waitOn: ->
    Meteor.subscribe 'singlePost', @params._id
  data: -> Posts.findOne @params._id
}
Router.route '/submit', name: 'postSubmit'

Router.route '/:postsLimit?',
  name: 'postsList'
  ### delegate to PostsListController
  waitOn: ->
    limit = parseInt(@params.postsLimit) or 5
    Meteor.subscribe 'posts',
      sort: {submitted: -1}
      limit: limit
  data: ->
    limit = parseInt(@params.postsLimit) or 5
    posts: Posts.find {},
      sort: {submitted: -1}
      limit: limit
  ###


requireLogin = ->
  if not Meteor.user()
    if Meteor.loggingIn()
      @render(@loadingTemplate)
    else @render('accessDenied')
  else @next() # also take care of Router.onBeforeAction requireLogin

Router.onBeforeAction 'dataNotFound', only: 'postPage'

Router.onBeforeAction requireLogin, only: 'postSubmit'
