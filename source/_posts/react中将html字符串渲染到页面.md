---
title: react中将html字符串渲染到页面
date: 2019-09-08 15:04:41
tags: [react, html字符串]
---

```jsx
<div dangerouslySetInnerHTML={{__html:this.props.content}}></div>
```

this.props.content 为要渲染的数据

