---
title: antd 之Alert警告提示框如何给内容添加链接
date: 2019-09-08 14:34:55
tags: [antd, Alert, 链接]
---

### 看antd的官方文档知道 message 就是 React.Node

```jsx
const message =  (
  <div>
    请完善你们的企业信息 >><Link href="/message/baseinfo">我要完善</Link>;
  </div>
 );

<Alert message={message} type="warning" />
```



```jsX
render() {
  const {
    header,
    freshFlag
  } = this.Store;

  const message = (
    <div>
      xxxxxxxxxxxxx<a href='#'>点我</a>xxxxxxxxxx
    </div>
  )

  return (
    <div className="Create-App-Page" data-fresh={freshFlag}>
      <Commonheader {...header} />
      <Alert showIcon type="info" closable message={ message }  className="Alert"/>
      <ContentWrap newclass="newclass">
      </ContentWrap>
    </div>
  );
}
```

