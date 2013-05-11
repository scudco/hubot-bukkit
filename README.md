# hubot-bukkit

## Hubot Bukkit

A [hubot](https://github.com/github/hubot) script to display images from
[bukkit](http://bukk.it).

It displays a random image or tries to find an image based on a query.

    bukkit # random image
    bukkit epiphany.gif # displays http://bukk.it/epiphany.gif

1. Edit `package.json` and add `hubot-bukkit` to the `dependencies` section. It should look something like this:

        "dependencies": {
          "hubot-bukkit": ">= 0.1.0",
          ...
        }
