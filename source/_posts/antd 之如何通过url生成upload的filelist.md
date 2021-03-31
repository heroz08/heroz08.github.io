---
title: antd 之如何通过url生成upload的filelist
date: 2021-04-01 12:07:21
tags: []
---
antd的upload组件在编辑回填数据的时候 往往得到的都是接口里返回的url而不是file，
所以我们可以通过url来生成fileList
```javascript
fileList = [{uid:'0',name: url, status: 'done', url: url}]
```


