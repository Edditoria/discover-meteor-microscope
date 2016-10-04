Template.errors.helpers
  errors: -> Errors.find()

Template.error.onRendered ->
  error = @data
  Meteor.setTimeout ->
    Errors.remove error._id
  , 3000
# #todo : should log errors,
#         and use CSS to fix display problem rather than just remove it
