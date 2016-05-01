# About This Repo

This repo is an exercise done following the tutorials in the book Discover Meteor.

- Awesome book to get start with Meteor.js: <https://www.discovermeteor.com/>
- Meteor.js: <https://www.meteor.com/>

# My Notes

- When read tutorials, don't use `mrt`, use `meteor` directly. (`mrt` is outdated)
- Meteor preference:
  - Meteor will run `/lib` first, then others by filename a-z, and `main.*` stuff at the end.
- working with Jade and Spacebar:
  - `+postsList` is equivalent to `{{> postsList}}`.
  - `#{url}` is equivalent to `{{spacebar}}`.
  - you still need to `href='{{pathFor "postsList"}}'`
  - `{{#each}}` `{{#with}}` (or `+with` `+each` or just `with` `each`) \#todo dig deep
- working with Coffeescript in Meteor:
  - use `@Post = new Mongo.Collection posts` as you don't need `var`.
- MongoDB:
  - shell: `meteor mongo` to enter Mongo shell, `meteor reset` to erase all data.

    ```sql
    db.posts.insert({title: "test post"});
    db.posts.find();
    ```
- \[!\] MUST DO `meteor remove autopublish insecure`
  - \#todo any package that is better than autopublish?
- good packages `meteor add iron:router nimble:restivus aldeed:collection2` \#todo check
- do Test with [Velocity](https://github.com/meteor-velocity/velocity) using **Mocha, Jasmine, Cucumber, and Selenium** \#todo research Tinytest
- Iron router:
  - use `waitOn: -> Meteor.subscribe 'posts'` in router.js rather than client\\main.js
  - use `waitOn: -> loadingTemplate 'loading'` and setup spinner with `meteor add sacha:spin` for better user experience.
  - use build-in hook `'loading'` and also `'dataNotFound'`
- Meteor serve the static contents quite slow. May need a CDN? \#todo
- building **form**: use `preventDefault` of jQuery event to prevent submitting data again.


# Worth Mention

Some of the tools I use happily:

- Macbook Air 13", Cloud9 @ Windows
- use `brew` to install `nvm` to manage `npm`
- Chrome browser
- Atom Editor (yah!)
- Terminal-Plus Atom package (so I can operate a few terminals within Atom in full screen mode)
- enjoy a lot of Coffeescript, Pug(formerly Jade), SCSS w/ Compass: `meteor add coffeescript mquandalle:jade fourseven:scss francocatena:compass`
  > note: I prefer SCSS because it is readable for more front-end developers

- text
- text

Some References:
- What is underscore.js? [Getting Started with Underscore.js](http://www.sitepoint.com/getting-started-with-underscore-js/) *- Sitepoint.com*
- [Is there a way to get data GUI view in Meteor.js?](http://stackoverflow.com/questions/18313997/is-there-a-way-to-get-data-gui-view-in-meteor-js) *- StackOverflow*
- Coffeescript: <http://coffeescript.org/>
- Jade: <https://atmospherejs.com/mquandalle/jade> and <http://jade-lang.com/tutorial/>
- SCSS: <http://sass-lang.com/guide>
  - [Sass vs. SCSS: which syntax is better?](http://thesassway.com/editorial/sass-vs-scss-which-syntax-is-better) *- thesassway.com*
- Compass: <http://compass-style.org/help/>
- [Developer's Guide to Improving Project Structure in Meteor Applications](https://www.toptal.com/meteor/improving-project-structure-meteor-framework) *- Darion Cassel*
- [Meteor Tutorial: Building Real-Time Web Applications with Meteor](https://www.toptal.com/meteor/building-real-time-web-applications-with-meteor) *- Peter Rogers*
  > On a side note: you can also address security issues in Meteor by using “allow and deny rules”. You can find out more about those and some reasons I prefer the above approach instead at discovermeteor.com.
