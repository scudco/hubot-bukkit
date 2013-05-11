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
  regex: /(bukkit) (.+)$/i

  handleGet: (err, res, body) =>
    handler = new HtmlParser.DefaultHandler()
    parser  = new HtmlParser.Parser handler

    parser.parseComplete body

    links = ("#{link.attribs.href}" for link in Select handler.dom, @selector)
    imageHref = @msg.random links

    @msg.send "#{@url}#{imageHref}"

  respond: (msg) =>
    @msg = msg
    @query = @msg.match[2]

    if @query?
      image = "#{@url}#{@query}"
      @msg.send image
    else
      @msg.http(@url).get() @handleGet

module.exports = (robot) ->
  bukkit = new Bukkit
  robot.respond bukkit.regex, bukkit.respond
