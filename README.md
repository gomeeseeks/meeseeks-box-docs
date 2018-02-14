Documentation website for [Meeseeks-box](https://github.com/gomeeseeks/meeseeks-box).

## Installation

Clone this repo and then:

```
$ git submodule init
Submodule 'themes/hugo-simpledoc-theme' (https://github.com/aerohub/hugo-simpledoc-theme) registered for path 'themes/hugo-simpledoc-theme'
$ git submodule update
Cloning into '/home/user/go/src/github.com/gomeeseeks/meeseeks-box-docs/themes/hugo-simpledoc-theme'...
Submodule path 'themes/hugo-simpledoc-theme': checked out '08c2097b76faf727d6d05d41a40fb118002a6612'
```

## Build the website locally

```
$ make
hugo --disableKinds=RSS --disableKinds=sitemap

                   | EN
+------------------+----+
  Pages            |  1
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  2
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  0
  Cleaned          |  0

Total in 32 ms
```

Now you can browse the contents of the `public` directory.
