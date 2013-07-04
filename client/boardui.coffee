@Go ?= {}
Go.BoardUI = class BoardUI

  constructor: (board) ->
    @_board = board

  addStone: (event) ->
    [x,y] = @coordsFromEvent(event)
    stone = @_board.stone x, y

    if !stone
      @_board.addStone x, y, "black"

  changeStone: (event) ->
      [x,y] = @coordsFromEvent(event)
      stone = @_board.stone x, y
      color = null
      if "black" == stone.color
        color = "white"
      else
        color = null

      @_board.removeStone(x, y)

      if color?
        @_board.addStone x, y, color

  coordsFromEvent: (event) ->
    [Math.floor(event.offsetX/50), Math.floor(event.offsetY/50)]

  renderTiles: ->
    tiles = d3.select("svg").select(".tiles").selectAll(".inter")
      .data([0..80])

    updateTiles = (group) -> 
      group.append("rect")
        .attr("x", (tile) -> 50*(tile%9) )
        .attr("y", (tile) -> 50*Math.floor(tile/9))
        .attr("width", 50 )
        .attr("height", 50 )

      group.append("line")
        .attr("x1", (tile) -> 50*(tile%9)+25 )
        .attr("y1", (tile) -> 50*Math.floor(tile/9) )
        .attr("x2", (tile) -> 50*(tile%9)+25 )
        .attr("y2", (tile) -> 50*Math.floor(tile/9)+50 )
        .attr("class", "cross")

      group.append("line")
        .attr("x1", (tile) -> 50*(tile%9) )
        .attr("y1", (tile) -> 50*Math.floor(tile/9)+25 )
        .attr("x2", (tile) -> 50*(tile%9)+50 )
        .attr("y2", (tile) -> 50*Math.floor(tile/9)+25 )
        .attr("class", "cross")
      	
      group.attr "class", "inter"

    updateTiles tiles.enter().append("g")

  renderStones: ->
    stones = d3.select("svg").select(".stones").selectAll(".stone")
      .data(@_board.stones(), (stone) -> stone._id )
  
    updateStones = (group) ->
      group.attr("class", (stone) -> "stone " + stone.color)
        .attr("cx", (stone) -> 25 + 50*stone.x)
        .attr("cy", (stone) -> 25 + 50*stone.y)
        .attr("r", 25)

    updateStones stones.enter().append("circle")
    stones.exit().transition().duration(250).attr("r",0).remove()

  
