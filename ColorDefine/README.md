
- ####ColorDefine color对象处理

```lua
-- 返回rgb相同的颜色
function white(num, alp) end

function RGB(r, g, b) end

function RGBA(r, g, b, a) end

function StringRGB(rgbString) end

function StringRGBA(rgbaString) end

function HEX(hex, alp) end

-- 16进制颜色，最后两位为alpha，如：0xf0f0f0ff，相当于HEX(0xf0f0f0, 1)
function HEXA(hexa) end

-- 16进制颜色，前两位为alpha，如：0xffe0e0e0，相当于HEX(0xe0e0e0, 1)
function AHEX(ahex) end
```
