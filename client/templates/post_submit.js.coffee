Template.postSubmit.events
  'submit form': (e) ->
    e.preventDefault()
    post = {
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()
    }

    # remove:
    # post._id = Posts.insert post
    # Router.go 'postPage', post
    # use the Meteor method instead:
    Meteor.call 'postInsert', post, (error, result) ->
      # show error and exit
      if error
        return alert error.reason
      Router.go 'postPage', _id: result._id
      return
