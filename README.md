#[utf.lua][1]

[`utf.lua`][1] is a library that gives you an API compatible with that of the [Lua String library][8] but whith [UTF-8][2] support already built in.

[Lua 5.3][3] came bundled with an awesome [UTF-8 module][9], yet it lacks most operations we are used to do with strings, like making substring, reversing it, and some others

To make it easier to swap the Lua String library with an UTF-8 aware module `utf.lua` was born

##Dependencies

`utf.lua` uses the built-in [`utf8`][9] library that came with [Lua 5.3][3]

Don't be afraid if you are using [LuaJIT][4] or an older version of Lua you can grab [lutf8 from here][5] or [luarocks][6]

If you really can't use lutf8 nor the built-in module `utf.lua` will default to a pure Lua implementation which can be found in [`luautf.lua`][7].

Be aware though that this pure Lua implementation doesn't give nice errors so you will fall into awful crashes or unexpected results.
This will be fixed soon, but it will always be recomended to use a binary module instead

Well you also need the built-in [`string`][8], [`math`][10] and [`table`][11] libraries so if you are using a sandbox you should expose them

##Usage

Once you have required the library you can already start to use it
```lua
local utf = require "utf"
```

###`utf.pattern`
This is the same string as that found in [`utf8.charpattern`][13]

###`utf.char`
This function is [`string.char`][19] compatible and is directly mapped to [`utf8.char`][12]

###`utf.len`
This function is [`string.len`][25] compatible and is directly mapped to [`utf8.len`][16] which also provides the functionality to find the length of substrings

###`utf.code` and `utf.byte`
This functions are the same and both are compatible with [`string.byte`][18] and are directly mapped to [`utf8.codepoint`][14]

###`utf.codes`
This function is the same as [`utf8.codes`][15], basically an iterator that iterates for each character and gives you the start position and the codepoint

###`utf.dump`, `utf.format`, `utf.rep`
Since [`string.dump`][20], [`string.format`][22] and [`string.rep`][28] don´t really care about UTF-8 stuff this functions are directly mapped to them (correspondingly)

###`utf.lower`, `utf.upper`
This functions are not yet implemented because they are hard and require huge replacement tables, so these are the same as [`string.lower`][26] and [`string.upper`][31]

###`utf.gsub`, `utf.gmatch`
Both of this pattern matching functions don't take encoding into account so they dont need to be changed. So they are the same as [`string.gsub`][24] and [`string.gmatch`][23]

The only problem being the `"()"` pattern which returns the byte position instead of UTF-8 character position. This can be fixed by passing the value to the [`utf.position`](#utfposition) function

###`utf.position`
Takes the byte position and returns the UTF-8 character position

```lua
for i=1, 6 do
   print(utf.position("Añejo", i))
end
```
```
Output:
1
2
2
3
4
5
```

###`utf.offset`
This functions does the same thing as [`utf8.offset`][17] but also returns the end byte of the character

```lua
print(utf8.offset("Añejo", 2))
print( utf.offset("Añejo", 2))
```
```
Output:
2
2	3
```

###`utf.reverse`
This function is compatible with [`string.reverse`][29] but is UTF-8 aware meaning that it doesn´t mess up your strings

```lua
print(string.reverse("añaña"))
print(   utf.reverse("añaña"))
```
```
Output:
a��a��a --Messed up string
añaña
```

###`utf.sub`
This function is compatible with [`string.sub`][30] but instead of taking byte position it takes UTF-8 characters position
```
print(string.sub("añaña", 3))
print(   utf.sub("añaña", 3))
```
```
Output:
�aña
aña
```

###`utf.find`, `utf.match`
This functions are mostly mapped to their string counterparts ([`string.find`][21] and [`string.match`][27]), but the third argument they take which is the initial position is changed, instead of byte position it takes UTF-8 character positions

Both of this functions have the same problem as `utf.gsub` and `utf.gmatch`. The `"()"` pattern returns the byte position instead of UTF-8 character position. This can be fixed by passing the value to the [`utf.position`](#utfposition) function

##License

First I need to give credits to Kyle Smith and [Minh Ngo][32] which created [this awesome utf8 library][33] which I used as a base to make [`luautf.lua`][7]

Both [`luautf.lua`][7] and the [`utf.lua`][1] library in general are licensed under [**MIT License**][34]

Copyright (c) 2016 [Cations][35] ([Pablo A. Mayobre][36])

[1]:https://github.com/Cations/utf.lua
[2]:https://en.wikipedia.org/wiki/UTF-8
[3]:https://www.lua.org/download.html
[4]:http://luajit.org/luajit.html
[5]:https://github.com/Cations/lutf8
[6]:http://luarocks.org/modules/positive07/lutf8


[8]:http://www.lua.org/manual/5.3/manual.html#6.4
[9]:http://www.lua.org/manual/5.3/manual.html#6.5
[10]:http://www.lua.org/manual/5.3/manual.html#6.7
[11]:http://www.lua.org/manual/5.3/manual.html#6.6

[12]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.char
[13]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.charpattern
[14]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.codepoint
[15]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.codes
[16]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.len
[17]:http://www.lua.org/manual/5.3/manual.html#pdf-utf8.offset

[18]:http://www.lua.org/manual/5.3/manual.html#pdf-string.byte
[19]:http://www.lua.org/manual/5.3/manual.html#pdf-string.char
[20]:http://www.lua.org/manual/5.3/manual.html#pdf-string.dump
[21]:http://www.lua.org/manual/5.3/manual.html#pdf-string.find
[22]:http://www.lua.org/manual/5.3/manual.html#pdf-string.format
[23]:http://www.lua.org/manual/5.3/manual.html#pdf-string.gmatch
[24]:http://www.lua.org/manual/5.3/manual.html#pdf-string.gsub
[25]:http://www.lua.org/manual/5.3/manual.html#pdf-string.len
[26]:http://www.lua.org/manual/5.3/manual.html#pdf-string.lower
[27]:http://www.lua.org/manual/5.3/manual.html#pdf-string.match
[28]:http://www.lua.org/manual/5.3/manual.html#pdf-string.rep
[29]:http://www.lua.org/manual/5.3/manual.html#pdf-string.reverse
[30]:http://www.lua.org/manual/5.3/manual.html#pdf-string.sub
[31]:http://www.lua.org/manual/5.3/manual.html#pdf-string.upper

[32]:https://github.com/markandgo
[33]:https://gist.github.com/markandgo/5776124


[35]:https://www.github.com/Cations
[36]:https://www.github.com/Positive07