# check if the userId owns the documents
@ownsDocument = (userId, doc) ->
  doc and doc.userId is userId
