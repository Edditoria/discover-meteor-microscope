Package.describe({
  name: 'edditoria:errors-by-discover-meteor',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'A pattern to display application errors to the user, by tutorial in the book Discover Meteor',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('0.9.0');
  // api.versionsFrom('1.3.2.4');
  api.use(['minimongo', 'mongo-livedata', 'templating'], 'client');
  api.addFiles(['errors.js', 'errors_list.html', 'errors_list.js'], 'client');
  if (api.export)
    api.export('Errors');
  // api.mainModule('errors-by-discover-meteor.js');
});

Package.onTest(function(api) {
  // api.use('ecmascript');
  // api.use('tinytest');
  api.use('edditoria:errors-by-discover-meteor', 'client');
  api.use(['tinytest', 'test-helpers', 'ui', 'templating'], 'client');
  api.addFiles('errors_tests.js', 'client');
  // api.mainModule('errors-by-discover-meteor-tests.js');
});
