---
layout: post
title:  "Hack the Box, Part 0"
---
# Invite Challenge

[Link](https://www.hackthebox.eu/invite)

## Check Source Code

- Chrome *Elements* view identifies below:

```html
<script defer src="/js/inviteapi.min.js"></script>
<script defer src="https://www.hackthebox.eu/js/calm.js"></script>
```

## calm.js

- Is a red herring
- Hints at location of correct file

```js
console.log(`%c
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.           The first step of the challenge!                                      .
.                                                                                 .
.                      uuuuuuu                                                    .
.                  uu$$$$$$$$$$$uu                                                .
.               uu$$$$$$$$$$$$$$$$$uu                                             .
.              u$$$$$$$$$$$$$$$$$$$$$u                                            .
.             u$$$$$$$$$$$$$$$$$$$$$$$u                                           .
.            u$$$$$$$$$$$$$$$$$$$$$$$$$u                   K E E P  C A L M       .
.            u$$$$$$$$$$$$$$$$$$$$$$$$$u                                          .
.            u$$$$$$"   "$$$"   "$$$$$$u                        A N D             .
.            "$$$$"      u$u       $$$$"                                          .
.             $$$u       u$u       u$$$                        H A C K            .
.             $$$u      u$$$u      u$$$                                           .
.              "$$$$uu$$$   $$$uu$$$$"                         T H I S            .
.               "$$$$$$$"   "$$$$$$$"                                             .
.                 u$$$$$$$u$$$$$$$u                             B O X             .
.                  u$"$"$"$"$"$"$u                                                .
.       uuu        $$u$ $ $ $ $u$$       uuu                                      .
.      u$$$$        $$$$$u$u$u$$$       u$$$$                                     .
.       $$$$$uu      "$$$$$$$$$"     uu$$$$$$                                     .
.     u$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$                                   .
.     $$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"                                   .
.      """      ""$$$$$$$$$$$uu ""$"""                                            .
.                uuuu ""$$$$$$$$$$uuu                                             .
.       u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$                                    .
.       $$$$$$$$$$""""           ""$$$$$$$$$$$"              HackTheBox           .
.        "$$$$$"                      ""$$$$""           info@hackthebox.eu       .
.          $$$"                         $$$$"                                     .
.                                                                                 .
.    This page loads an interesting javascript file. See if you can find it :)    .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .`,"color:#9acc14; background:black; font-family: monospace");
```

## inviteapi.min.js

- Contains obfuscated code

```js
//This javascript code looks strange...is it obfuscated???

eval(function(p,a,c,k,e,r){e=function(c){return c.toString(a)};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('0 3(){$.4({5:"6",7:"8",9:\'/b/c/d/e/f\',g:0(a){1.2(a)},h:0(a){1.2(a)}})}',18,18,'function|console|log|makeInviteCode|ajax|type|POST|dataType|json|url||api|invite|how|to|generate|success|error'.split('|'),0,{}))
```

## De-Obfuscate Javascript Code 

- Paste `eval` function into [deobfuscatejavascript.com](http://deobfuscatejavascript.com/#)
- Result:

```js
function makeInviteCode() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: '/api/invite/how/to/generate',
        success: function(a) {
            console.log(a)
        },
        error: function(a) {
            console.log(a)
        }
    })
}
```

## Run Code

- Chrome *Console* returns `undefined`
- Navigating to [hackthebox.eu/api/invite/how/to/generate](hackthebox.eu/api/invite/how/to/generate) results in a page displaying "Whoops, looks like something went wrong."

