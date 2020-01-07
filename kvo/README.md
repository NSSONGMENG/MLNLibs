#### KVO.lua是用lua实现的类似iOS KVO监听table属性变化的组件

- 添加监听 ```lua kvo_observeForKey(table, key, callbackFunc)```
- 移除监听 ```lua  kvo_removeObserveForKey(table, key)```

注意事项：
  - 如果`keyPath`中只有一层`key`时,必须要用创建监听时返回的`proxy`替换原来的`table`, 否则后续的监听不会起作用；
  - `keyPath`为多级时可以不用替换，内部实现会帮忙替换掉，所以推荐用多级`keyPath`;
  - 多级`keyPath`是形如 "school.student.girl.name" 这种的,而一级`keyPath`是形如"name"这种的;
