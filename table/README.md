- #### table扩展方法

```lua

---
--- Map或Array转table
---
---@param   ma  Map_Array
---@return  table
---
table.maToTable = function(ma)          end

---
--- Map转table
---
---@param   map Map 字典
---@return  table
---
table.mapToTable = function(map)        end

---
--- Array转table
---
---@param   arr Array   数组
---@return  table
---
table.arrayToTable = function(arr)      end

---
--- table转类json（不合法的json，因Array的格式不正确）
---
---@param   tab     table
---@return  string
---
table.toString = function(tab)          end

---
--- table 转 Map
---
---@param   t   table
---@return  Map
---
table.toMap = function(t)               end

---
--- 清空table
---
---@param   list    table
---
table.removeAll = function(list)        end

---
--- 将subList中的元素添加至list中
---
---@param   list    table
---@param   subList table
---
table.addAll = function(list, subList)  end

---
--- 对象是否是table
---
---@param   t   table
---@return  boolean
table.isTable = function(t)             end

---
--- table是否为空
---
---@param   t   table
---@return  boolean
---
table.isEmpty = function(t)             end

---
--- 拷贝table
---
---@param   t   table
---@return  table
---
table.copy = function(t)                end

---
--- 把category的内容合并进t
---
---@param   t   table
---@param   category    table
---@return  table
---
table.merge = function(t, category)     end
```

