# Enchanted

This landing page has been ripped off (or stripped off) from 
[Magic](http://getmagicnow.com) because they have done so many things right.

In the spirit of _learning from the best_ and _standing on the shoulders of
giants_ it is more than sensible to adopt elements that have worked before.

The [very first](https://web.archive.org/web/20150222041533/http://www.getmagicnow.com/) page of Magic simply allows for the submission of an e-mail
address.

## Preview

On larger displays, the logo is somewhat large and the screenshots are
presented in a very simple grid.

![Large preview](preview-large.png)

On smaller displays, the logo is a bit smaller and some elements are slightly reorganized. All but the first one of the screenshots disappear.

![Mobile preview](preview-small.png)

## Usage

 - Replace all occurrences of `LandingStrip` in `index.html` with your project
 name and modify the remaining copy to your liking.
 - Comment out the `.show > ul > li:not(:first-child) { display: none; }` line
 in `main.css` if you want to display all screenshots in the smaller-screen
 version of the page.
