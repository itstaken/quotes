# quotes

dumb shell scripts for putting quotes on wallpapers

`wallpaper.sh` - pass it an image and it will put quotes in it
`quotes.sh` - used by wallpaper.sh to fetch quotes
`quotes.txt` - contains the text fetched by `quotes.sh`

I download a bunch of wallpapers from [wallhaven.cc](https://wallhaven.cc) and
put them in the same directory as these scripts.  Then I put some quotes into
the `quotes.txt` file -- which is currently somewhat rigidly formatted -- and
use `wallpaper.sh` to put one of the quotes from the text file onto the bottom
of the wallpaper.

For example, I have a file named `sakura.jpg` and to stamp it with a quote I do
this:

    $ bash wallpaper.sh sakura.jpg

That will put the resulting image into /tmp and output something like this:

    /tmp/tmp.l3a5j0M7kU.png

This makes it convenient to do something like this:

    feh --bg-center $(bash wallpaper.sh sakura.jpg)

Or to pick a random JPG from the current directory, put a quote in it, and make
it the background:

    feh --bg-center $(bash wallpaper.sh `ls *.jpg | sort -R | head -n 1`)
