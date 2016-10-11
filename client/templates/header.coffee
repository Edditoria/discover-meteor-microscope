Template.header.helpers
  activeRouteClass: (routeName...) ->
    active = _.any routeName, (name) ->
      Router.current() and Router.current().route.getName() is name
    active and 'active'
