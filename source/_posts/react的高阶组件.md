---
title: react的高阶组件
date: 2019-09-08 15:57:21
tags: [react, 高阶组件]
---

> *高阶组件就是一个函数，传给它一个组件，它返回一个新的组件*。新的组件使用传入的组件作为子组件。

> *高阶组件的作用是用于代码复用*，可以把组件之间可复用的代码、逻辑抽离到高阶组件当中。

> *新的组件和传入的组件通过 props 传递信息*。

### 整体逻辑原理:

base组件 以参数形式传递进入 高阶函数, 高阶函数里面的 wrap组件作为父级render自己base组件,

通过wrap组件的一系列逻辑处理, 将不同的props传递给base组件,生成不同的wrap组件,然后return wrap组件



### base组件:



```jsx
class base extend Component {
  render() {
    return (
    <input value={this.props.data} />
    )
  }
}
```



### 高阶函数:



```jsx
higherOrder = (MyComponent, index, ...params) => {
  class Wrap extend Component {
    state = {
      datas: [
        1,2,3,4,5
      ]
    }
    render() {
    return (
      <MyComponent data={this.state.datas[index]} />
    );
    }
  }
  return Wrap
}
```



### 调用:



```jsx
import higherOrder from './higerOrder' // 高阶函数的路径(引入高阶函数)
const newBase = higherOrder(base, 0); // base组件, index 
export default newBase; // 这样可以抛出多个input组件且其值与传入的index有关
```