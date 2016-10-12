Template.postsList.onRendered ->

  # it will replace the default behaviour of Blaze
  @find('.wrapper')._uihooks =
    insertElement: (node, next) ->
      $(node).hide().insertBefore(next).fadeIn()
    removeElement: (node) ->
      $(node).fadeOut ->
        $(@).remove()
    moveElement: (node, next) ->
      $node = $(node)
      $next = $(next)
      oldTop = $node.offset().top
      height = $node.outerHeight true

      # find all elements between `next` and `node`
      $inBetween = $next.nextUntil node
      if $inBetween.length is 0
        $inBetween = $node.nextUntil next

      # place the `node`
      $node.insertBefore next
      # measure new `top`
      newTop = $node.offset().top
      # `node` move to original place
      $node
        .removeClass 'animate'
        .css 'top', oldTop - newTop
      # push every other element down (or up) to put them back
      $inBetween
        .removeClass 'animate'
        .css 'top',
          if oldTop < newTop then height else -1* height
      # redraw
      $node.offset()
      # animate: reset all elements top to 0
      $node.addClass 'animate'
        .css 'top', 0
      $inBetween.addClass 'animate'
        .css 'top', 0
      return
  return

# Template.postsList.helpers
#   posts: ->
#     Posts.find {}, {sort: {submitted: -1}} # sort (newer first)

# removed since Posts is inserted in MongoDB
# postsData = [
#   {
#     title: 'Awesome book to get start with Meteor.js'
#     url: 'https://www.discovermeteor.com'
#   }
#   {
#     title: 'Meteor.js'
#     url: 'https://www.meteor.com/'
#   }
#   {
#     title: 'this repo: Discover Meteor: Microscope'
#     url: 'https://github.com/Edditoria/discover-meteor-microscope'
#   }

# ]

# Template.postsList.helpers { posts: postsData }
