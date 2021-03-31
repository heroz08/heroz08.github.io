---
title: 给Icon添加ToolTip的坑
date: 2021-04-01 12:07:21
tags: tooltip
---
再给iconfont 添加tooltip时 不能直接在iconfont外面套用，否则不显示
需要添加一层标签才能显示
错误代码： 不显示tooltip

```jsx
<Tooltip title={row.errorMessage || '计算异常，请重新创建媒介策略'}>
  <Icon  className="error_message" type="icon-xinxi1" scriptUrl/>
</Tooltip>
```
正确代码：

```jsx
<Tooltip title={row.errorMessage || '计算异常，请重新创建媒介策略'}>
  <span>
    <Icon  className="error_message" type="icon-xinxi1" scriptUrl/>
  </span>
</Tooltip>
```

