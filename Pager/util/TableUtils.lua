---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by momo.
--- DateTime: 2019/6/12 下午7:45
---
--- table扩展方法


---
--- Map或Array转table
---
---@param   ma  Map_Array
---@return  table
---
table.maToTable = function(ma)
    if ma == nil then return nil end

    if TypeUtils:isMap(ma) then
        return table.mapToTable(ma)
    elseif TypeUtils:isArray(ma) then
        return table.arrayToTable(ma)
    else
        print("param is not Map or Array !!!!!\n-----------------\n\n", ma, "----------------- \n\n")
        return {}
    end
end


---
--- Map转table
---
---@param   map Map 字典 【注:因goto是关键字，将被转换为gotoStr】
---@return  table
---
table.mapToTable = function(map)
    map = map or Map(0)

    local t = {}
    local keys = map:allKeys() or Array()

    for i = 1, keys:size() do
        local k = keys:get(i)
        local v = map:get(k)

        if k == "goto" then k = "gotoStr" end
        if type(v) ~= "userdata" then
            t[k] = v
        else
            t[k] = table.maToTable(v)
        end
    end

    return t
end


---
--- Array转table
---
---@param   arr Array   数组
---@return  table
---
table.arrayToTable = function(arr)
    local t = {}

    for i = 1, arr:size() do
        local item = arr:get(i)
        if type(item) ~= "userdata" then
            table.insert(t, item)
        else
            table.insert(t, table.maToTable(item))
        end
    end

    return t
end



---
--- table转类json（不合法的json，因Array的格式不正确）
---
---@param   tab     table
---@return  string
---
table.toString = function(tab)
    local str = ""
    local _type = type(tab)
    if _type ~= "table" then
        if _type == "function" then
            return tostring(tab)
        elseif _type == "string" then
            return table.concat({"\"", tab, "\""})
        elseif _type == "boolean" then
            return tab and "true" or "false"
        end
        return tab
    else
        local idx = 1
        local filter = {}

        local formatArray = function(i, v, idx)
            local s = table.toString(v) or "nil"
            if idx > 1 then
                str = table.concat({str, ",\n", i,":",s})
            else
                str = table.concat({str, "\n", i,":",s})
            end

            filter[i] = true
        end

        local formatMap = function(i,  v ,idx)
            if not filter[i] then
                if type(i) == "string" then
                    i = table.concat({"\"", i, "\""})
                end

                local s = table.toString(v) or "nil"
                if idx > 1 then
                    str = table.concat({str, ",\n", i,":",s})
                else
                    str = table.concat({str, "\n", i,":",s})
                end
            end
        end

        -- 数组部分优先
        for i, v in ipairs(tab) do
            formatArray(i, v, idx)
            idx = idx + 1
        end

        -- map部分在下
        for i, v in pairs(tab) do
            formatMap(i, v, idx)
            idx = idx + 1
        end

        -- super部分最后
        local super = getmetatable(tab)
        if type(super) == "table" and type(super.__index) == "table" then
            for i, v in pairs(super.__index) do
                -- 规避__index死循环
                if i ~= "__index" then
                    formatMap(i, v, idx)
                    idx = idx + 1
                end
            end
        end
    end

    return table.concat({"{", str, "\n}"})
end


---
--- table 转 Map, 若table中包含list部分，则舍去其中的key-value部分
---
---@param   t   table
---@return  Map
---
table.toMap = function(t)
    assert(type(t) == "table", "t is not table -- ", t)

    local function tableToMap(t)
        local m = Map()
        if #t > 0 then
            m = Array()
            for _, v in ipairs(t) do
                if type(v) == "table" then
                    v = tableToMap(v)
                end
                m:add(v)
            end
        else
            for k, v in pairs(t) do
                if type(v) == "table" then
                    v = tableToMap(v)
                end

                if type(k) ~= "string" then
                    k = tostring(k)
                end
                m:put(k, v)
            end
        end

        return m
    end

    return tableToMap(t)
end

table.toArray = function(list)
    return table.toMap(list)
end

---
--- 清空table
---
---@param   list    table
---
table.removeAll = function(list)
    if table.isTable(list) then
        for i, v in pairs(list) do
            list[i] = nil
        end
    else
        print("list is:", type(list) , "--")
    end
end



---
--- 将subList中的元素添加至list中
---
---@param   list    table
---@param   subList table
---
table.addAll = function(list, subList)
    if table.isTable(list) and table.isTable(subList) then
        local size = #subList
        for i = 1, size do
            table.insert(list, subList[i])
        end
    else
        print("list is:", type(list))
        print("sub list is:", type(subList))
    end
end



---
--- 对象是否是table
---
---@param   t   table
---@return  boolean
table.isTable = function(t)
    return type(t) == "table"
end



---
--- table是否为空
---
---@param   t   table
---@return  boolean
---
table.isEmpty = function(t)
    if type(t) ~= "table" then
        return true
    end
    return next(t) == nil
end


---
--- 拷贝table
---
---@param   t   table
---@return  table
---
table.copy = function(t)
    local tmp = {}
    if t ~= nil and table.isTable(t) then
        for i, v in pairs() do
            if type(v) == "table" then
                v = table.copy(v)
            end
            tmp[i] = v
        end
    end

    return tmp
end


---
--- 把category的内容合并进t
---
---@param   t   table
---@param   category    table
---@return  table
---
table.merge = function(t, category)
    if type(category) == "table" then
        for k, v in pairs(category) do
            t[k] = v
        end
    end
    return t
end

-- iOS上table无unpack方法，unpack方法为公用方法，Android上存在
if type(unpack) == 'function' and type(table.unpack) == 'nil' then
    table.unpack = unpack
end
