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
#   hubot bukkit me - displays a random image from http://bukk.it
#   hubot bukkit me <query> - displays a random image whose base filename matches `query` from http://bukk.it
#
# Notes:
#
# Authors:
#   Adam Anderson (scudco)
#   Justin Anderson (tinifni)
#
#   based on https://github.com/sauliusg/hubot/blob/master/scripts/bukkit.coffee

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

class Bukkit
  url: "http://bukk.it/"
  selector: "td a"
  regex: /bukkit me.*?([a-zA-Z0-9_\-\.]*)$/i

  constructor: (robot)->
    @robot = robot

  handleGet: (err, res, body) =>
    handler = new HtmlParser.DefaultHandler()
    parser  = new HtmlParser.Parser handler

    parser.parseComplete body
    links = ("#{link.attribs.href}" for link in Select handler.dom, @selector)

    matchedLinks = []
    for link in links
      matchedLinks.push(link) if link.match(@query)

    links = matchedLinks if matchedLinks.length > 0
    link  = @msg.random(links)
    @display(link)

  display: (image)->
    @msg.send "#{@url}#{image}"

  responseHandler: (msg) =>
    @msg = msg
    @query = @msg.match[1]
    @robot.http(@url).get() @handleGet

module.exports = (robot) ->
  bukkit = new Bukkit(robot)
  robot.respond bukkit.regex, bukkit.responseHandler
