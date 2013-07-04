@Go ?= {}
Go.Board = class Board
  
  constructor: (stones) ->
    @_stones = stones

  stones: ->
    @_stones.find().fetch()

  resetBoard: ->
    Meteor.call "resetBoard"

  stone: (x, y) ->
    @_stones.findOne x: x, y: y

  addStone: (x, y, color) ->
    @_stones.insert x: x, y: y, color: color

  removeStone: (x, y) ->
    stone = @stone(x, y)
    if stone?
      @_stones.remove stone._id
 
