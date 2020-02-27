---
title: react-router通过js导航
date: 2019-09-08 15:19:22
tags: [router, js, 导航]
---



```js
import { browserHistory } from 'react-router'  //引入路由函数

browserHistory.push('/some/path')   //js方式跳转
```

或者使用 hashHistory 代替 browserHistory



### 1.引入包 

```js
import {hashHistory} from 'React-router'
```

### 2.跳转传值

```js
handleClick = (value) => {
        hashHistory.push({
            pathname: 'message/detailMessage',
            query: {
                title:value.title,
                time:value.time,
                text:value.text
            },
        })
    }
```

### 3.接收值

```js
console.info(this.props.location.query.title)
console.info(this.props.location.query.time)
console.info(this.props.location.query.text)
```

