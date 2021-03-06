---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by momo.
--- DateTime: 2019/5/23 下午4:22
---
--- 自定义类基类
---

local BaseClass = {_name = "BaseClass"}

function BaseClass:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o:_initConfig()
    return o
end

function BaseClass:extend()
    local sub =  setmetatable({}, {__index = self, __call = self.__call})
    sub.super = self
    return sub
end

function BaseClass:release()
    for i, v in pairs(self) do
        self[i] = nil
    end

    collectgarbage("collect")
end

-- 对象初始化后自动调用该方法，可在方法中进行页面的初始化配置
function BaseClass:_initConfig() end

-- 通过__call的方式支持通过类名调用new方法
function BaseClass:__call()
    return self:new()
end

setmetatable(BaseClass, BaseClass)

return BaseClass