---
title: antd的坑之checkbox的冒泡和捕获问题
date: 2019-09-08 14:29:48
tags: [antd, checkbox, 冒泡, 捕获]
---

可以在checkbox里面添加event

onClick=(e) =>e.stopPropagation()

只能阻止checkbox不能阻止里面的lable



stopPropagation()函数用于**阻止当前事件在DOM树上冒泡**。



使用stopPropagation()函数可以阻止当前事件向祖辈元素的冒泡传递，也就是说该事件不会触发执行当前元素的任何祖辈元素的任何事件处理函数。



如果antd里面的组件里面还有label之类的则添加阻止冒泡事件不能添加到组件内部，所以还会产生冒泡



可以根据stopPropagaion的原理只阻止祖辈元素的冒泡传递，可以在组件外部添加一个div

在div上添加对应事件添加stopPropagaion即可阻止冒泡向上传递