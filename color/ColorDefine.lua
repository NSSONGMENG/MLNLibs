---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by momo.
--- DateTime: 2018/8/31 上午11:10
---


--- 本文件处理color对象的生成和缓存 ---


local colorCache = {}

---
--- 返回rgb相同的颜色
---
---@param   num   number  色值：0 ~ 255
---@param   alp   number  透明度：0 ~ 1
---@return  color
---
function white(num, alp)
	alp = alp or 1

	local key = table.concat({num, num, num, alp})
	if colorCache[key] then
		return colorCache[key]
	end

	local color = Color(num, num, num, alp)
	colorCache[key] = color

	return color
end

---
--- RGB
---
---@param   r   number  red
---@param   g   number  green
---@param   b   number  blue
---@return  color
---
function RGB(r, g, b)
	return RGBA(r, g, b, 1)
end

---
--- RGBA
---
---@param   r   number  red
---@param   g   number  green
---@param   b   number  blue
---@param   a   number  alpha
---@return  color
---
function RGBA(r, g, b, a)
	a = a or 1
	local key = table.concat({r, ",", g, ",", b, ",", a})

	if colorCache[key] then
		return colorCache[key]
	end

	local color = Color(r, g, b, a)
	colorCache[key] = color

	return color
end

---
--- StringRGB
---
---@param   rgbString   string  e.g. "255, 255, 255"
---@return  color
---
function StringRGB(rgbString)
	if nil == rgbString or type(rgbString) ~= "string" or string.len(rgbString) < 5 then
		--print("rgbString should be correct string -- ", rgbString, 'e.g. "255, 255, 255"')
		return CLEAR
	end

	rgbString = string.gsub(rgbString, "^%s*(.-)%s*$", "%1")
	rgbString = table.concat({rgbString, ",1"})
	return StringRGBA(rgbString)
end

---
--- StringRGBA
---
---@param   rgbaString  string  e.g.    "255, 255, 255, 0.5"
---@return  color
---
function StringRGBA(rgbaString)
	if nil == rgbaString or type(rgbaString) ~= "string" or string.len(rgbaString) < 7 then
		print("rgbaString should be string -- ", rgbaString)
		return CLEAR
	end

	rgbaString = string.gsub(rgbaString, "^%s*(.-)%s*$", "%1")
	if colorCache[rgbaString] then
		return colorCache[rgbaString]
	end

	local rgba = {}
	string.gsub(rgbaString, '[^,]+', function(w)
		table.insert(rgba, w)
	end )

	if #rgba < 4 then
		return CLEAR
	end

	local color = Color(tonumber(rgba[1] ), tonumber(rgba[2]), tonumber(rgba[3]), tonumber(rgba[4]))
	colorCache[rgbaString] = color

	return color
end

---
--- hex
---
---@param   hex   number  e.g. 0xFFFFFF(255, 255, 255)
---@param   alp   number  alpha
---@return  color
---
function HEX(hex, alp)
	if nil == hex or type(hex) == "string" then
		print("hex should be number -- ", hex)
		return CLEAR
	end

	local r = MBit:band(MBit:shr(hex, 16), 0xff)
	local g = MBit:band(MBit:shr(hex, 8), 0xff)
	local b = MBit:band(MBit:shr(hex, 0), 0xff)
	local a = alp or 1

	local key = table.concat({r, ",", g, ",", b, ",", a})
	if colorCache[key] then
		return colorCache[key]
	end

	local color = Color(r, g, b, a)
	colorCache[key] = color
	return color
end


---
--- 16进制颜色，最有两位为alpha，如：0xf0f0f0ff，相当于HEX(0xf0f0f0, 1)
---
---@param   hexa    number  e.g. 0xFFFFFFAA (255, 255, 255, 0xAA/255)
---@return  color
---
function HEXA(hexa)
	if nil == hexa or type(hexa) == "string" then
		print("hex should be number -- ", hexa)
		return CLEAR
	end

	local r = MBit:band(MBit:shr(hexa, 24), 0xff)
	local g = MBit:band(MBit:shr(hexa, 16), 0xff)
	local b = MBit:band(MBit:shr(hexa, 8), 0xff)
	local a = MBit:band(MBit:shr(hexa, 0), 0xff) / 0xff

	local key = table.concat({r, ",", g, ",", b, ",", a})
	if colorCache[key] then
		return colorCache[key]
	end

	local color = Color(r, g, b, a)
	colorCache[key] = color
	return color
end


---
--- 16进制颜色，前两位为alpha，如：0xffe0e0e0，相当于HEX(0xe0e0e0, 1)
---
---@param   ahex    number  e.g. 0xAAFFFFFF (255, 255, 255, 0xAA/255)
---@return  color
---
function AHEX(ahex)
	if nil == ahex or type(ahex) == "string" then
		print("ahex should be number -- ", ahex)
		return CLEAR
	end

	local a = MBit:band(MBit:shr(ahex, 24), 0xff) / 0xFF
	local r = MBit:band(MBit:shr(ahex, 16), 0xff)
	local g = MBit:band(MBit:shr(ahex, 8), 0xff)
	local b = MBit:band(MBit:shr(ahex, 0), 0xff)

	local key = table.concat({r, ",", g, ",", b, ",", a})
	if colorCache[key] then
		return colorCache[key]
	end

	local color = Color(r, g, b, a)
	colorCache[key] = color
	return color
end


CLEAR			= white(255, 0)
WHITE			= white(255)
WHITE_250		= white(250)
WHITE_240		= white(240)	--#f0f0f0
WHITE_230		= white(230)	--#e6e6e6
WHITE_210		= white(210)

DARK_0  		= white(0)
DARK_50 		= RGB(50, 51, 51)	--#323333

GRAY_170 		= white(170)	--#aaaaaa
GRAY_155		= white(155)

CLR_0_214_228 	= RGB(0, 214, 228)
CLR_248_85_67	= RGB(248, 85, 67)