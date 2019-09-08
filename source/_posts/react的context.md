---
title: react的context
date: 2019-09-08 15:59:20
tags: [react, context]
---



### 作用:

可以在父级组件上向下共享数据,减少props的传递

### 新版用法:

1. 父组件创建 Context文件



```jsx
import React from 'react';

const MyContext = React.createContext();
export default MyContext;
```

2. 父级组件里面设置:



```jsx
import React, { Component } from 'react';
import Child from './Child';
import MyContext from './Context'
const { Provider } = MyContext;

export default class Page extends Component {
  render = () => (
    <Provider value='hello world!'>
      <Child />
    </Provider>
  )
}
```

3. 子组件:



```jsx
import React, { Component } from 'react';
import Sun from './sun';
export default class Child extends Component {
  render() {
    return (
      <div>
        <Sun/>
      </div>
    )
  }
}
```

4. 子子组件:

Consumer的children要为一个函数

```jsx
import React, { Component } from 'react';
import MyContext from './Context';

export default class Sun extends Component {
  render () {
    return (
    <MyContext.Consumer>
      {
        context => context
      }
    </MyContext.Consumer>
  )
  }
}
```