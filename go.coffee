Match = new Meteor.Collection "match"

@.Match = Match

Meteor.methods
  'resetBoard': ->
    Match.remove {}

if (Meteor.isClient)

  Template.hello.events
    "click #reset": (event, template)->
      Meteor.call "resetBoard"

    "click .inter": (event, template)->
      stone = Match.findOne offsetX: Math.floor(event.offsetX/50), y: Math.floor(event.offsetY/50)
      if !stone
        Match.insert x: Math.floor(event.offsetX/50), y: Math.floor(event.offsetY/50), color: "black"
      
    "click .stone": (event, template)->
      stone = Match.findOne x: Math.floor(event.offsetX/50), y: Math.floor(event.offsetY/50)
      color = null
      if "black" == stone.color
        color = "white"
      else
        color = null

      Match.remove stone._id

      if color?
        Match.insert x: stone.x, y: stone.y, color: color

  Template.hello.rendered = ->
   Deps.autorun ->
    circles = d3.select("svg").select(".circles").selectAll("circle")
    .data(Match.find().fetch(), (stone) -> stone._id )
  
    updateStone = (stoneUI) ->
     stoneUI.attr("class", (stone) -> "stone " + stone.color)
     .attr("cx", (stone) -> 25 + 50*(stone.x))
     .attr("cy", (stone) -> 25 + 50*(stone.y))
     .attr("r", 25)

    updateStone(circles.enter().append("circle"))
    circles.exit().remove()

    tiles = d3.select("svg").select(".tiles").selectAll(".inter")
      .data([0..80])

    updateTile = (tileUI) -> 
      tileUI.append("rect")
      .attr("x", (tile) -> 50*(tile%9) )
      .attr("y", (tile) -> 50*Math.floor(tile/9))
      .attr("width", 50 )
      .attr("height", 50 )

      tileUI.append("line")
      .attr("x1", (tile) -> 50*(tile%9)+25 )
      .attr("y1", (tile) -> 50*Math.floor(tile/9) )
      .attr("x2", (tile) -> 50*(tile%9)+25 )
      .attr("y2", (tile) -> 50*Math.floor(tile/9)+50 )
      .attr("class", "cross")

      tileUI.append("line")
      .attr("x1", (tile) -> 50*(tile%9) )
      .attr("y1", (tile) -> 50*Math.floor(tile/9)+25 )
      .attr("x2", (tile) -> 50*(tile%9)+50 )
      .attr("y2", (tile) -> 50*Math.floor(tile/9)+25 )
      .attr("class", "cross")
       	
      tileUI.attr "class", "inter"

    updateTile(tiles.enter().append("g"))

if (Meteor.isServer)
  Meteor.startup ->
