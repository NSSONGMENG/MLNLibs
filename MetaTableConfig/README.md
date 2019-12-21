### Metatable元表修改

主要对`window`，`View`，`Label`，`EditTextView`，`LinearLayout`，`AnimationZone`，`ImageView`的原表进行修改

- 新增的方法：

```lua
-- 使以上SDK提供的UI组件支持通过table设置属性
function setConfig(table)   end 

-- 如：
local t = {
    fontNameSize = {PF_MEDIUM, 15},
    textColor = WHITE,
    setGravity = Gravity.CENTER,
    bgColor = white(200),
    textAlign = TextAlign.CENTER,
    width = 100,
    height = 50,
    text = "momo",
}

lab = Label():setConfig(t)

t.bgColor = CLR_0_214_228
t.padding = {10, 10, 10, 10}
t.width = nil
t.height = nil
v = View():setConfig(t)

v:addView(lab)
window:addView(v)


-- 替换superview()，superview()写法不规范问题，覆盖原生superview实现
function superView()    end     

-- 以上拥有addView方法的控件拥有该方法，用于返回其所有的子视图
function allSubviews()  end     

-- 支持连续添加多个子view
function addViews(...)  end     

-- 给image view设置短链地址，设置短链头像一步搞定
function avatar(string) end     

```


-  被修改的方法：

```lua
-- 使addView()接受table作为参数，默认会读取table的contentView作为子视图添加
function addView(table or userdata) end

-- iOS端存在window被移除导致白屏问题，此方法屏蔽原生实现，并支持superView()调用
function superview()    end 

```

因用了全局表对父视图和子视图做了关联，其他修改的方法涉及到`addView()`,`insertView()`,`removeFromSuper()`三个


- 其他：

```lua
---
--- 通过对象实现方法【交】换（适用于对通过桥接或SDK提供的类进行操作）
---
---@param obj           userdata / table
---@param oriFuncName   string
---@param newFunc       function
---@return  boolean 操作是否成功
---
function swizz_sdk_method(obj, oriFuncName, newFunc)        end


---
--- 通过对象实现方法【替】换（适用于对通过桥接或SDK提供的类进行操作）
--- 若有oriFuncName对应的方法则覆盖，否则将添加
---
---@param obj           userdata / table
---@param oriFuncName   string
---@param newFunc       function
---@return  boolean 操作是否成功
---
function replace_sdk_method(obj, oriFuncName, newFunc)      end


---
--- 通过类实现方法【交】换 （使用于Lua自定义类）
---
---@param class         table   Lua类
---@param oriFuncName   string
---@param newFunc       function
---@return  boolean 操作是否成功
---
function swizz_lua_method(class, oriFuncName, newFunc)      end


---
--- 通过类实现方法【替】换 （使用于Lua自定义类）
--- 若有oriFuncName对应的方法则覆盖，否则将添加
---
---@param class         table   Lua类
---@param oriFuncName   string
---@param newFunc       function
---@return  boolean 操作是否成功
---
function replace_lua_method(class,oriFuncName, newFunc)     end
```
