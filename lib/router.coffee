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
    sort: @sort
    limit: @postsLimit()
  }
  subscriptions: ->
    @postsSub = Meteor.subscribe 'posts', @findOptions()
    return
  # waitOn: -> Meteor.subscribe 'posts', @findOptions()
  posts: -> Posts.find {}, @findOptions()
  data: ->
    self = this
    # hasMore = @posts().count() is @postsLimit()
    # removed: nextPath refer to NewPostsControler and BestPostsController
    # nextPath = @route.path
    #   postsLimit: @postsLimit() + @increment
    # instead: do this
    {
      posts: self.posts()
      ready: self.postsSub.ready
      nextPath: ->
        if self.posts().count() is self.postsLimit()
          self.nextPath()
    }

@NewPostsController = PostsListController.extend
  sort: {submitted: -1, _id: -1}
  nextPath: ->
    Router.routes.newPosts.path
      postsLimit: @postsLimit() + @increment
@BestPostsController = PostsListController.extend
  sort: {votes: -1, submitted: -1, _id: -1}
  nextPath: ->
    Router.routes.bestPosts.path
      postsLimit: @postsLimit() + @increment

Router.route '/',
  name: 'home'
  controller: NewPostsController

Router.route '/new/:postsLimit?',
  name: 'newPosts'

Router.route '/best/:postsLimit?',
  name: 'bestPosts'


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

# # removed: replaced by NewPostsController
# Router.route '/:postsLimit?',
#   name: 'postsList'
  # # removed: delegate to PostsListController
  # waitOn: ->
  #   limit = parseInt(@params.postsLimit) or 5
  #   Meteor.subscribe 'posts',
  #     sort: {submitted: -1}
  #     limit: limit
  # data: ->
  #   limit = parseInt(@params.postsLimit) or 5
  #   posts: Posts.find {},
  #     sort: {submitted: -1}
  #     limit: limit


requireLogin = ->
  if not Meteor.user()
    if Meteor.loggingIn()
      @render(@loadingTemplate)
    else @render('accessDenied')
  else @next() # also take care of Router.onBeforeAction requireLogin

Router.onBeforeAction 'dataNotFound', only: 'postPage'

Router.onBeforeAction requireLogin, only: 'postSubmit'
