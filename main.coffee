@Go ?= {}
Go.Stones = new Meteor.Collection "stones", transform: (stone) ->
  stone

Meteor.methods
  'resetBoard': ->
    Go.Stones.remove {}

if (Meteor.isClient)

  Meteor.startup ->
    Go.current_board = new Go.Board(Go.Stones)
    Go.current_boardUI = new Go.BoardUI(Go.current_board)

if (Meteor.isServer)
  Meteor.startup ->
