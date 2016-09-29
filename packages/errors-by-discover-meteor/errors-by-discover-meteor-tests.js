// Import Tinytest from the tinytest Meteor package.
import { Tinytest } from "meteor/tinytest";

// Import and rename a variable exported by errors-by-discover-meteor.js.
import { name as packageName } from "meteor/errors-by-discover-meteor";

// Write your tests here!
// Here is an example.
Tinytest.add('errors-by-discover-meteor - example', function (test) {
  test.equal(packageName, "errors-by-discover-meteor");
});
