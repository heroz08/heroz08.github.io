---
title: antd之table组件的columns属性filter
date: 2019-09-08 14:23:57
tags: [antd, table, columns, filter]
---

## filteredValue
官方解释:

> 筛选的受控属性，外界可用此控制列的筛选状态，值为已筛选的 value 数组     string[]

  **外界通过此属性,去设置筛选的value值(可多选)**

## filters
官方解释:

> 表头的筛选菜单项

  **设置要筛选的value值,会出现筛选的图标,里面的项为value值, 如果外界通过filteredValue来筛选此值也可不设置**

## onFilter
官方解释:

> 本地模式下，确定筛选的运行函数

  **filter的回调函数(value,record) 两个参数,record为这一行,value为fitlers或filteredValue里面值,通过此值来    筛选record里面的项**

