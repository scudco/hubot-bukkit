# Description:
#   Return a random image from bukk.it
#
# Dependencies:
#   htmlparser 1.7.6
#   soupselect 0.2.0
#
# Configuration:
#
# Commands:
#   hubot bukkit <query> - displays an image whose filename matches `query` (or a random one if `query` is not present) from http://bukk.it
#
# Notes:
#
# Author:
#   Adam Anderson (scudco)
#   based on https://github.com/sauliusg/hubot/blob/master/scripts/bukkit.coffee

Select     = require("soupselect").select
HtmlParser = require "htmlparser"
JQuery     = require('jquery')

class Bukkit
  url: "http://bukk.it/"
  selector: "td a"
  randomRegex: /bukkit$/i
  queryRegex: /bukkit\s.*?([a-zA-Z0-9_\-\.]*)$/i
  links: []
  link: []

  constructor: (robot)->
    @robot = robot

  handleGet: (err, res, body) =>
    handler = new HtmlParser.DefaultHandler()
    parser  = new HtmlParser.Parser handler

    parser.parseComplete body
    @links = ("#{link.attribs.href}" for link in Select handler.dom, @selector)
    @display(@chooseLink(@links))

  display: (image)->
    @msg.send "#{@url}#{image}"

  randomResponseHandler: (msg) =>
    @msg = msg
    @query = null
    @robot.http(@url).get() @handleGet

  queryResponseHandler: (msg) =>
    @msg = msg
    @query = @msg.match[1]
    @robot.http(@url).get() @handleGet

  chooseLink: (links) =>
    # No link specified
    return @msg.random(@links) unless @query

    for link in links
      @link.push(link) if link.match(@query)

    # Link(s) found, return a random match
    return @msg.random(@link) if (@link.length > 0)
    # No matching links; return random
    return @msg.random(@links)

module.exports = (robot) ->
  bukkit = new Bukkit(robot)
  robot.respond bukkit.randomRegex, bukkit.randomResponseHandler
  robot.respond bukkit.queryRegex, bukkit.queryResponseHandler
