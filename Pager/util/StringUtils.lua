---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by momo.
--- DateTime: 2019/4/3 上午10:47
---
---
--- string 功能扩展
---


---
--- 字符串拷贝
---@param str   string  将要被拷贝的字符串
---@return  string
string.copy = function(str)
    if type(str) == 'string' then
       return str .. ""
    end
    return str
end


---
--- 分割字符串
---
---@param str   string  待分割字符串
---@param c     string  分割标志
---@return string
---
string.split = function (str, c)
    if type(c) == nil then
        print("split character is nil !!!")
        return {str}
    end

    local pat = table.concat({"[^", c, "]+"})

    local tb = {}
    string.gsub(str, pat, function(w)
        table.insert(tb, w)
    end )
    return tb
end


---
--- 字符串拼接
---
---@vararg string
---@return string
---
string.append = function (...)
    local arg = {}
    for k, v in pairs({...}) do
        -- 过滤nil值
        table.insert(arg,v)
    end
    return table.concat(arg)
end


---
--- 去除字符串两端的换行符&空格
---
---@param   str   string
---@return  string
---
string.trim = function (str)
    if (str and string.len(str) > 0) then
        return string.gsub(str, "^%s*(.-)%s*$", "%1")
    end
    return ""
end


---
--- 计算字符串长度
---
---@param str   string
---@return number
---
string.length = function (str)
    return StringUtil:length(str)
end


---
--- 计算字符串size
---
---@param str       string  字符串
---@param fontSize  number  字体大小
---@return Size
---
string.size = function (str, fontSize)
    return StringUtil:sizeWithContentFontSize(str, fontSize)
end


---
--- json To Map
---
---@param json string
---@return Map
---
string.jsonToMap = function (json)
    return StringUtil:jsonToMap(json)
end


---
--- json To Array
---
---@param json string   list json
---@return Array
---
string.jsonToArray = function(json)
    local text text = table.concat({'{"m":', json, '}'})
    local map = string.jsonToMap(text)
    return map:get("m")
end


---
--- map 转 json
---
---@param map Map
---@return string
---
string.mapToJson = function (map)
    return StringUtil:mapToJSON(map)
end


---
--- array to json
---
---@param   arr     Array
---@return  string
---
string.arrayToJson = function(arr)
    local map = Map():put("m", arr)
    local json = StringUtil:mapToJSON(map)
    local b,_ = string.find(json, "%[")
    return string.sub(json, b, #json - 1)
end


---
--- 子字符串位置
---
---@param   s   string  目标字符串
---@param   sub string  子字符串
---@return  table
---
string.range = function(s, sub)
    if s == nil or sub == nil or string.match(s, sub) ~= sub then
        -- sub不是s的子字符串
        return nil
    end

    local b, e = string.find(s, sub)
    if string.len(s) == string.length(s) then
        -- 不包含中文等其他字符
        return {
            location = b,
            length = e - b + 1
        }
    else
        -- 包含中文等其他字符
        local header = string.sub(s, 1, b - 1)
        return {
            location = string.length(header) + 1,
            length = string.length(sub)
        }
    end
end


---
--- 字符串替换，匹配不到待替换字符串则返回原字符串，正则匹配可直接使用gsub
---
---@param   s   string  原始字符串
---@param   ori string  待替换字符串
---@param   new string  将ori替换为new
---@return  string
---
string.replace = function(s, ori, new)
    if type(s) ~= "string" then
        return s
    end
    s = string.gsub(s, ori, new)
    return s
end

---
--- 是否为非空字符串
---
---@param   str string
---@return  boolean
---
string.notEmpty = function(str)
    return (type(str) == "string" and string.len(str) > 0)
end

---
--- 解析json形式的goto， 三段式goto原样返回
---
---@param gotoStr string
---@return Map
---
string.analysisGoto = function(gotoStr)
    if type(gotoStr) == "string" and string.len(gotoStr) > 0 then
        if string.match(gotoStr, '%[.*|.*%]') then
            return gotoStr
        end

        -- 多写个字符串分割方法，减少字符串拼接
        local function __xxsplit(str, pat)
            local tb = {}
            string.gsub(str, pat, function(w)
                table.insert(tb, w)
            end )
            return tb
        end

        local tmp = StringUtil:jsonToMap(gotoStr) or Map()
        local m = tmp:get("m") or Map()
        local prm = m:get("prm")

        if type(prm) == "string" then
            prm = StringUtil:jsonToMap(prm)
            if TypeUtils:isMap(prm) then
                local url = prm:get("url")
                if url then
                    local urlParam = Map()
                    local urlSeg = __xxsplit(url, "[^?]+")

                    if #urlSeg > 1 then
                        local paramString = urlSeg[2]
                        local paramSeg = __xxsplit(paramString, "[^&]+")
                        for i = 1, #paramSeg do
                            local p = paramSeg[i]
                            local kv = __xxsplit(p, "[^=]+")
                            if #kv > 1 then
                                urlParam:put(kv[1], kv[2])
                            end
                        end
                    end

                    prm:put("urlParams", urlParam)
                end
                m:put("prm", prm)
            end
        end

        return tmp
    end

    print("gotoStr not correct !!!", gotoStr)
    return Map()
end

string.startsWith = function(str, pattern)
    if (pattern == nil) then
        return false
    end
    return string.match(str, "^" .. pattern) ~= nil
end

string.endsWith = function(str, pattern)
    if (pattern == nil) then
        return false
    end
    return string.match(str, pattern .. "$") ~= nil
end