---
title: react中getDefaultProps和getInitialState的区别是什么
date: 2019-09-08 15:46:48
tags: [react, getDefaultProps, getInitIalState]
---

- getDefaultProps是设置默认props，如果父组件没有给某个prop那就用默认的(

  源码里显示:

  ​	假设 defaultProps = { title: 1}, 父组件没有传递title 给props

  ​	则 props.title = defaultProps.title;

  )

- getInitialState是设置组件mount以后的初始state的

