# hubot-bukkit

## Hubot Bukkit

A [hubot](https://github.com/github/hubot) script to display images from
[bukkit](http://bukk.it).

It displays a random image or tries to find an image based on a query.

    bukkit me # random image
    bukkit me epiphany # displays http://bukk.it/epiphany.gif
    bukkit me business # randomly displays http://bukk.it/business.gif or http://bukk.it/business.jpg

1. Edit `package.json` and add `hubot-bukkit` to the `dependencies` section. It should look something like this:

        "dependencies": {
          "hubot-bukkit": ">= 0.3.0",
          ...
        }
1. Add "hubot-bukkit" to your `external-scripts.json`. It should look something like this:

    ["hubot-bukkit"]
