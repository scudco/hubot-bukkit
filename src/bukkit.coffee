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

class Bukkit
  url: "http://bukk.it/"
  selector: "td a"
  randomRegex: /bukkit$/i
  queryRegex: /bukkit (.*)$/i
  links: []

  constructor: (robot)->
    @robot = robot

  handleGet: (err, res, body) =>
    handler = new HtmlParser.DefaultHandler()
    parser  = new HtmlParser.Parser handler

    parser.parseComplete body

    @links = ("#{link.attribs.href}" for link in Select handler.dom, @selector)
    @display(@msg.random(@links))

  display: (image)->
    @msg.send "#{@url}#{image}"

  randomResponseHandler: (msg) =>
    @msg = msg
    @robot.http(@url).get() @handleGet

  queryResponseHandler: (msg) =>
    @msg = msg
    @query = @msg.match[1]
    @display(@query)

module.exports = (robot) ->
  bukkit = new Bukkit(robot)
  robot.respond bukkit.randomRegex, bukkit.randomResponseHandler
  robot.respond bukkit.queryRegex, bukkit.queryResponseHandler
