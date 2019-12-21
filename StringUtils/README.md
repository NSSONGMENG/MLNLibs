
- #### string扩展方法

```lua

---
--- 字符串拷贝
---@param str   string  将要被拷贝的字符串
---@return  string
string.copy = function(str)         end

---
--- 分割字符串
---
---@param str   string  待分割字符串
---@param c     string  分割标志
---@return string
---
string.split = function (str, c)    end

---
--- 字符串拼接
---
---@vararg string
---@return string
---
string.append = function (...)      end

---
--- 去除字符串两端的换行符&空格
---
---@param   str   string
---@return  string
---
string.trim = function (str)        end

---
--- 计算字符串长度
---
---@param str   string
---@return number
---
string.length = function (str)      end

---
--- 计算字符串size
---
---@param str       string  字符串
---@param fontSize  number  字体大小
---@return Size
---
string.size = function (str, fontSize)  end

---
--- json To Map
---
---@param json string
---@return Map
---
string.jsonToMap = function (json)      end

---
--- json To Array
---
---@param json string   list json
---@return Array
---
string.jsonToArray = function(json)     end

---
--- map 转 json
---
---@param map Map
---@return string
---
string.mapToJson = function (map)       end

---
--- array to json
---
---@param   arr     Array
---@return  string
---
string.arrayToJson = function(arr)      end

---
--- 子字符串位置
---
---@param   s   string  目标字符串
---@param   sub string  子字符串
---@return  table
---
string.range = function(s, sub)         end

---
--- 解析json形式的goto， 三段式goto原样返回
---
---@param gotoStr string
---@return Map
---
string.analysisGoto = function(gotoStr) end

---
--- 返回utf-8字符串长度
---
string.utf8_len = function (s)          end

---
--- 倒置utf-8字符串
---
string.utf8_reverse = function (s)      end

---
--- 根据字符起始位获取utf-8子字符串
---
---@param   s   string
---@param   i   number  字符起始位置
---@param   j   number  字符终止位置
---@return  string
string.utf8_sub = function (s, i, j)    end
```
