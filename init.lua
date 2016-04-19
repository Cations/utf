local utf = {
	_VERSION		= "utf.lua 0.1.0",
	_DESCRIPTION	= "A Lua String Library compatible library which supports UTF-8",
	_URL			= "https://www.github.com/Cations/utf.lua",
	_AUTHOR			= "Cations",
	_LICENSE		= [[
		The MIT License (MIT)

		Copyright (c) 2016 Cations

		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:

		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	]]
}

local string, table, math = require "string" require "table", require "math"
local unpack = unpack or table.unpack

local ok, u --UTF-8 library (Lua 5.3 compatible)
for _, name in ipairs{"utf8", "lutf8", ... ".luautf"} do
	ok, u = pcall(require, name)
	if ok then break end
end

--Helper for utf.find and utf.match
local initvalue = function (s, init)
	if init and type(init) == "number" then
		local len = u.len(s)
		if init < len then
			return init = u.offset(s, init)
		else
			return false
		end
	end
end

--No change
utf.pattern		= u.charpattern
utf.char		= u.char
utf.len			= u.len
utf.codes		= u.codes
utf.code		= u.codepoint
utf.byte		= utf.code --Just for compat with Lua String library

--Not UTF8 dependant
utf.dump		= string.dump
utf.format		= string.format
utf.rep			= string.rep
--Too hard to implement
utf.lower		= string.lower
utf.upper		= string.upper
--Pattern matching functions (The "()" pattern returns bytes positions, use utf.position to fix this)
utf.gsub		= string.gsub
utf.gmatch		= string.gmatch

--New functions
utf.position	= function (s, byte)
	return u.len(s, 1, byte)
end

utf.offset		= function (s, n, i)
	local a, b = u.offset(s, n, i)

	if a and a < #s then
		b = utf8.offset(s, n == 0 and 2 or n+1, i)
		b = b and b - 1 or #s
	end

	return a, b
end

--Function re-implementations with UTF-8!
utf.reverse		= function (s)
	local ret = ""

	for p,c in u.codes(s) do
		ret = u.char(c) .. ret
	end

	return ret
end

utf.sub			= function (s, i, j)
	local len = u.len(s)
	local j = j or -1

	i = math.max(i < 0 and len + 1 + i or i, 1)
	j = math.min(j < 0 and len + 1 + j or j, len)

	if i > j then return end

	return string.sub(s, u.offset(s, i), j == len and -1 or u.offset(s, j + 1) - 1)
end

utf.find		= function (s, pattern, init, plain) --The "()" pattern returns bytes positions, use utf.position to fix this
	init = initvalue(s, init)
	if not init then return end

	local a, b = string.find(s, pattern, init)

	if a then
		a = u.len(s, 1, a)
		b = u.len(s, 1, b)
	end
	
	return a,b
end

utf.match		= function (s, pattern, init) --The "()" pattern returns bytes positions, use utf.position to fix this
	init = initvalue(s, init)
	if not init then return end

	return string.match(s, pattern, init)
end

return utf