---
title: antd table列表分页删除时要注意的page current
date: 2019-11-23 10:55:42
tags: [antd, table, 分页]

---

### 当列表项被删除时判断删除后的page current 的取值:



```js

function getCurrentPage(total, pageSize, current){
  const yu = total % pageSize
  const maxPage = Math.ceil(total / pageSize)
  // 如果最后一页只有一条并且此时在最后一页 或者 每一页都是一条 符合这个条件的可能要-1
  if ((yu === 1 && maxPage === current) || pageSize === 1) {
    current = current - 1 === 0 ? 1 : current - 1 
  }
  return current;
}
```

