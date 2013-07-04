Template.board.events
  "click #reset": (event, template)->
    Go.current_board.resetBoard()

  "click .inter": (event, template)->
    Go.current_boardUI.addStone(event)

  "click .stone": (event, template)->
    Go.current_boardUI.changeStone(event)

Template.board.rendered = ->
  Go.current_boardUI.renderTiles()

  Deps.autorun ->
    Go.current_boardUI.renderStones()
