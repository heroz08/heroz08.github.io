---
title: antd table列表分页删除时要注意的page current
date: 2019-11-23 10:55:42
tags: ['antd', 'table', '分页']

---

### 当列表项被删除时判断删除后的page current 的取值:



```js
// 当删除项为最后一页且只有一项时 page current 需要向前一页即 -1 否则都是 当前current
(current > 1 && total % pageSize === 1 && current === Math.ceil(total / pageSize)) ? current - 1 : current
```

