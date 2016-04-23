#[utf][1]

[`utf`][1] is a library that gives you an API compatible with that of the [Lua String library][8] but whith [UTF-8][2] support already built in.

[Lua 5.3][3] came bundled with an awesome [UTF-8 module][9], yet it lacks most operations we are used to do with strings, like making substring, reversing it, and some others

To make it easier to swap the Lua String library with an UTF-8 aware module `utf.lua` was born

##Dependencies

`utf.lua` uses the built-in [`utf8`][9] library that came with [Lua 5.3][3]

Don't be afraid if you are using [LuaJIT][4] or an older version of Lua you can grab [lutf8 from here][5] or [luarocks][6]

If you really can't use lutf8 nor the built-in module you can use [`plutfo`][7], a pure Lua implementation. There are two methods to do this:

* Simply download [`plutfo`][7] in you main path so that `require "plutfo"` can find it
* Or call this `git` command on this repository:
  ```shell
  git submodule update --init --recursive
  ```
  This will download [`plutfo`][7] as a submodule

Be aware though that this pure Lua implementation doesn't give nice errors so you may fall into awful crashes or unexpected results.
This will be fixed soon, but it will always be recomended to use a binary module instead (because of performance)

Well you also need the built-in [`string`][8], [`math`][10] and [`table`][11] libraries so if you are using a sandbox you should expose them

##Usage

Download it:
```shell
git clone git@github.com:Cations/utf.git
```
or alternatively if you also wanna grab [`plutfo`][7] then:
```shell
git clone --recursive git@github.com:Cations/utf.git
```

Then require it:
```lua
local utf = require "utf"
```

And use it! Check the [Wiki][12] for documentation on each function

##Tests and Specs

Coming soon! ([#][13])

##License

The [`utf`][1] library is licensed under [**MIT License**][14]

Copyright (c) 2016 [Cations][15] ([Pablo A. Mayobre][16])

[1]:https://github.com/Cations/utf
[2]:https://en.wikipedia.org/wiki/UTF-8
[3]:https://www.lua.org/download.html
[4]:http://luajit.org/luajit.html
[5]:https://github.com/Cations/lutf8
[6]:http://luarocks.org/modules/positive07/lutf8
[7]:https://github.com/Cations/plutfo

[8]:http://www.lua.org/manual/5.3/manual.html#6.4
[9]:http://www.lua.org/manual/5.3/manual.html#6.5
[10]:http://www.lua.org/manual/5.3/manual.html#6.7
[11]:http://www.lua.org/manual/5.3/manual.html#6.6

[12]:https://github.com/Cations/utf/wiki
[13]:https://github.com/Cations/utf/issues/6

[14]:https://github.com/Cations/utf/blob/master/LICENSE
[15]:https://www.github.com/Cations
[16]:https://www.github.com/Positive07