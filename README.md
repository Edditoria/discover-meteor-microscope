# About This Repo

This repo is an exercise done following the tutorials in the book Discover Meteor.

- Awesome book to get start with Meteor.js: <https://www.discovermeteor.com/>
- Meteor.js: <https://www.meteor.com/>

# My Notes

- When read tutorials, don't use `mrt`, use `meteor` directly. (`mrt` is outdated)
- \[!\] MUST DO `meteor remove autopublish insecure` on every project you're going to build.
- Meteor will run `/lib` first, then others by filename a-z, and `main.*` stuff at the end.
- Iron router:
  - use `waitOn: -> Meteor.subscribe 'posts'` in router.js rather than client\\main.js
  - use `waitOn: -> loadingTemplate 'loading'` and setup spinner with `meteor add sacha:spin` for better user experience.
  - use build-in hook `'loading'` and also `'dataNotFound'`
- MongoDB:
  - shell: `meteor mongo` to enter Mongo shell, `meteor reset` to erase all data.

    ```sql
    db.posts.insert({title: "test post"});
    db.posts.find();
    ```

  - used operators in tutorial: `$set`, `$addToSet` and `$inc`.
- building **form**: use `e.preventDefault()` of jQuery event to prevent submitting data again.
- for `e.preventDefault()` must read: <https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault>

# Additional Notes

- working with Jade and Spacebar:
  - `+postsList` is equivalent to `{{> postsList}}`.
  - `#{url}` is equivalent to `{{spacebar}}`.
  - `if` `unless` `each` `with` (or `+something`) for `{{#each}}` `{{#with}}` etc.
  - to pass an argument(s), you still need to `a(href='{{pathFor "postsList"}}')` or `div(class='{{errorClass "url"}}').form-group` or `p {{pluralize votes "vote"}}` etc.
  - and need to `(class='#{upvotedClass}')` or `(class='{{upvotedClass}}')`.
    - **cannot** `span.#{doThis}` or `span.{{doThis}}`.
  - `_uihooks` affect the parsing of Jade. There are a Meteor package may help.
    - <https://atmospherejs.com/gwendall/ui-hooks>
    - However, there is an issue (with solution):
      - <https://github.com/gwendall/meteor-ui-hooks/issues/4>
- working with Coffeescript in Meteor:
  - do alert to add `@` especially in some lib script
  - e.g. `@Post = new Mongo.Collection posts` as you don't need `var` in Javascript.
- `iron:router` is great, and there is another package you may try: `kadira:flow-router`
  - forum discussion: <https://forums.meteor.com/t/flowrouter-or-ironrouter/4705/3>
  - blog post: The State of Routing in Meteor <https://themeteorchef.com/blog/the-state-of-routing-in-meteor/>
- some good packages must try: `nimble:restivus` and `aldeed:collection2`
- Meteor package `matb33:collection-hooks` extends Mongo.Collection with before/after hooks for insert, update, remove, find, and findOne.

# Worth Mention

Some of the tools I use happily:

- Macbook Air 13", Cloud9 @ Windows
- use `brew` to install `nvm` to manage `npm`
- Chrome browser
- Atom Editor (yah!)
- Terminal-Plus Atom package (so I can operate a few terminals within Atom in full screen mode)
- enjoy a lot of Coffeescript, Pug (formerly Jade) and Stylus w/ Nib

Some References:

- What is underscore.js? [Getting Started with Underscore.js](http://www.sitepoint.com/getting-started-with-underscore-js/) *- Sitepoint.com*
- [Is there a way to get data GUI view in Meteor.js?](http://stackoverflow.com/questions/18313997/is-there-a-way-to-get-data-gui-view-in-meteor-js) *- StackOverflow*
- [Testing: How to test your Meteor application](https://guide.meteor.com/testing.html) *- Meteor.com*
- [Developer's Guide to Improving Project Structure in Meteor Applications](https://www.toptal.com/meteor/improving-project-structure-meteor-framework) *- Darion Cassel*
- [Meteor Tutorial: Building Real-Time Web Applications with Meteor](https://www.toptal.com/meteor/building-real-time-web-applications-with-meteor) *- Peter Rogers*
  > On a side note: you can also address security issues in Meteor by using “allow and deny rules”. You can find out more about those and some reasons I prefer the above approach instead at discovermeteor.com.

- Coffeescript: <http://coffeescript.org/>
- Jade: <https://atmospherejs.com/mquandalle/jade> and <http://jade-lang.com/tutorial/>
- Stylus <http://stylus-lang.com> and Nib <https://tj.github.io/nib/>
