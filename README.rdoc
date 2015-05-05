Tic Tac Toe
==============


Features
------------
  * 2 player mode
  * Rails Backend, very little client side due to time.

Tests
-----

```sh
  rspec spec
```

Setup
-----

Seed movies from Rotten Tomatoes API

```ruby

  bundle install

  rake db:setup

  rails s

```

Challenges
----------
* Game logic wasn't too bad.
* The tricky part was getting rows and columns aligns on the actual page.
* The other tricky part was instantiating a board.  Which I did on creation of a new board each time.
* The board was defaulted to a 2D array

* Given the nature of the challenge, I wrongly assumed AJAXing the player-turns when the a player clicks on the button.  I some how heavily coupled my logic into the html and thus didn't know to make a specific asynchronous call.
*  I started out with :remote => true in the _board_form.html.erb form, but when rendering as json in the controller action, I was somehow iterating over the rows and columns and didn't know how to define that in a single variable.


Blockers
---------
- AJAXing to make more client-side friendly.
- Given my time contsraint, I was only able to work on this for two days.


*** Note ***

Commenting in this code is something I do not do in production - however, I've been burned in interviews regarding comments and not having them.  For the sake of the explaining myself here in the code challenge, and although I believe code should be made expressive without comments (https://robots.thoughtbot.com/letting-your-code-speak-for-itself), comments in this challenge are meant to further clarify any confusion to interviewer.

