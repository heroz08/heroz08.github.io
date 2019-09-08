---
title: antd 之table sort 鼠标放上去提示修改
date: 2019-09-08 14:31:17
tags: [antd, table, sort, 提示]
---

```jsx
import React from 'react';
import { Table } from 'antd';

const DEFAULTPROPS = {
  locale: {
    emptyText: '暂无数据',
    sortTitle:'' //为空不显示提示
  }
}


export default class TableCmp extends React.Component {
  render = () => {
    return (
      <Table {DEFAULTPROPS} />
    )
  }
}
```

