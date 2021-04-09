---
title: hooks和Ts
date: 2021-03-24 23:27:52
tags: [ts, hooks]
---
<a name="Y6XDX"></a>
### useState
```javascript
import React from 'react'

type UserInfo = {
  name: string,
  age: number,
}

export const User:React.FC<UserInfo> = ({ name, age }) => {
  return (
    <div className="User">
      <p>{ name }</p>
      <p>{ age }</p>
    </div>
  )
}

const user = <User name='vortesnail' age={25} />

```

- 在我们的参数为对象类型时，需要特别注意的是， `setXxx` 并不会像 `this.setState` 合并旧的状态，它是完全替代了旧的状态，所以我们要实现合并，可以这样写
```javascript
setArticle({
  title: '下一篇',
  content: '下一篇的内容',
  ...article
})
```
<a name="5efa7793"></a>
### 为啥使用useEffect?
你可以把 `useEffect` 看做 `componentDidMount` ， `componentDidUpdate` 和 `componentWillUnmount` 这三个函数的组合。<br />

<a name="756dc977"></a>
### 怎么使用useEffect?
```
useEffect(() => {
  ...
  return () => {...}
},[...])
```

- 每当状态改变 每次都执行useEffect
```javascript
import React, { useState, useEffect } from 'react'

let switchCount: number = 0

const User = () => {
  const [name, setName] = useState<string>('')
  useEffect(() => {
    switchCount += 1
  })

  return (
    <div>
      <p>Current Name: { name }</p>
      <p>switchCount: { switchCount }</p>
      <button onClick={() => setName('Jack')}>Jack</button>
      <button onClick={() => setName('Marry')}>Marry</button>
    </div>
  )
}

export default User
```

- 只执行一次 useEffect
```javascript
useEffect(() => {
  switchCount += 1
}, [])
```

- 根据某个状态去改变 只有该状态改变 useEffect才会执行
```javascript
const [value, setValue] = useState<string>('I never change')
useEffect(() => {
  switchCount += 1
}, [value])
```

- 组件卸载时处理一些内存问题，比如清除定时器、清除事件监听 需要卸载的时候要处理一些事件的时候需要return
```javascript
useEffect(() => {
  const handler = () => {
    document.title = Math.random().toString()
  }

  window.addEventListener('resize', handler)

  return () => {
    window.removeEventListener('resize', handler)
  }
}, [])

```
<a name="V2lmw"></a>
## useRef
<a name="ZszIx"></a>
### 为啥使用useRef?
它不仅仅是用来管理 DOM ref 的，它还相当于 this , 可以存放任何变量，很好的解决闭包带来的不方便性。
<a name="6Mz2f"></a>
### 怎么使用useRef?
```
const [count, setCount] = useState<number>(0)
const countRef = useRef<number>(count)
复制代码
```
<a name="sp4Se"></a>
### 场景举例
<a name="wl3x8"></a>
##### 1.闭包问题：
想想看，我们先点击 **加** 按钮 3 次，再点 **弹框显示** 1次，再点 **加** 按钮 2 次，最终 `alert` 会是什么结果？
```
import React, { useState, useEffect, useRef } from 'react'
const Counter = () => {
  const [count, setCount] = useState<number>(0)
  const handleCount = () => {
    setTimeout(() => {
      alert('current count: ' + count)
    }, 3000);
  }
  return (
    <div>
      <p>current count: { count }</p>
      <button onClick={() => setCount(count + 1)}>加</button>
      <button onClick={() => handleCount()}>弹框显示</button>
    </div>
  )
}
export default Counter
复制代码
```
结果是弹框内容为 **current count: 3** ，为什么？
> 当我们更新状态的时候, **React 会重新渲染组件, 每一次渲染都会拿到独立的 count 状态,  并重新渲染一个  handleCount 函数.  每一个 handleCount 里面都有它自己的 count 。**

** 那如何显示最新的当前 count 呢？
```
const Counter = () => {
  const [count, setCount] = useState<number>(0)
  const countRef = useRef<number>(count)
  useEffect(() => {
    countRef.current = count
  })
  const handleCount = () => {
    setTimeout(() => {
      alert('current count: ' + countRef.current)
    }, 3000);
  }
  //...
}
export default Counter
复制代码
```
<a name="Fhl8b"></a>
##### 2.因为变更 `.current` 属性不会引发组件重新渲染，根据这个特性可以获取状态的前一个值：
```
const Counter = () => {
  const [count, setCount] = useState<number>(0)
  const preCountRef = useRef<number>(count)
  useEffect(() => {
    preCountRef.current = count
  })
  return (
    <div>
      <p>pre count: { preCountRef.current }</p>
      <p>current count: { count }</p>
      <button onClick={() => setCount(count + 1)}>加</button>
    </div>
  )
}
复制代码
```
我们可以看到，显示的总是状态的前一个值：<br />![](https://cdn.nlark.com/yuque/0/2020/webp/206259/1602836948895-4537e142-aa02-4c5f-be00-0a899ee3cf16.webp#align=left&display=inline&height=212&margin=%5Bobject%20Object%5D&originHeight=212&originWidth=344&size=0&status=done&style=none&width=344)
<a name="Xvb5c"></a>
##### 3.操作 Dom 节点，类似 createRef()：
```
import React, { useRef } from 'react'
const TextInput = () => {
  const inputEl = useRef<HTMLInputElement>(null)
  const onFocusClick = () => {
    if(inputEl && inputEl.current) {
      inputEl.current.focus()
    } 
  }
  return (
    <div>
      <input type="text" ref={inputEl}/>
      <button onClick={onFocusClick}>Focus the input</button>
    </div>
  )
}
export default TextInput
复制代码
```
<a name="WOf6t"></a>
## useMemo
<a name="efknj"></a>
### 为啥使用useMemo?
从 **useEffect** 可以知道，可以通过向其传递一些参数来影响某些函数的执行。 React 检查这些参数是否已更改，并且只有在存在差异的情况下才会执行此。<br />**useMemo** 做类似的事情，假设有大量方法，并且只想在其参数更改时运行它们，而不是每次组件更新时都运行它们，那就可以使用 **useMemo** 来进行性能优化。
> 记住，传入 `useMemo` 的函数会在**渲染期间执行**。请不要在这个函数内部执行与渲染无关的操作，诸如副作用这类的操作属于 `useEffect` 的适用范畴，而不是 `useMemo` 。

<a name="WCw2S"></a>
### 怎么使用useMemo?
```
function changeName(name) {
  return name + '给name做点操作返回新name'
}
const newName = useMemo(() => {
	return changeName(name)
}, [name])
复制代码
```
<a name="OVvUh"></a>
### 场景举例
<a name="wDl3N"></a>
##### 1.常规使用，避免重复执行没必要的方法：
我们先来看一个很简单的例子，以下是还未使用 `useMemo` 的代码：
```
import React, { useState, useMemo } from 'react'
// 父组件
const Example = () => {
  const [time, setTime] = useState<number>(0)
  const [random, setRandom] = useState<number>(0)
  return (
    <div>
      <button onClick={() => setTime(new Date().getTime())}>获取当前时间</button>
      <button onClick={() => setRandom(Math.random())}>获取当前随机数</button>
      <Show time={time}>{random}</Show>
    </div>
  )
}
type Data = {
  time: number
}
// 子组件
const Show:React.FC<Data> = ({ time, children }) => {
  function changeTime(time: number): string {
    console.log('changeTime excuted...')
    return new Date(time).toISOString()
  }
  return (
    <div>
      <p>Time is: { changeTime(time) }</p>
      <p>Random is: { children }</p>
    </div>
  )
}
export default Example
复制代码
```
在这个例子中，无论你点击的是 **获取当前时间** 按钮还是 **获取当前随机数** 按钮， `<Show />` 这个组件中的方法 `changeTime` 都会执行。<br />但事实上，点击 **获取当前随机数** 按钮改变的只会是 `children` 这个参数，但我们的 `changeTime` 也会因为子组件的重新渲染而重新执行，这个操作是很没必要的，消耗了无关的性能。<br />使用 `useMemo` 改造我们的 `<Show />` 子组件：
```
const Show:React.FC<Data> = ({ time, children }) => {
  function changeTime(time: number): string {
    console.log('changeTime excuted...')
    return new Date(time).toISOString()
  }
  const newTime: string = useMemo(() => {
    return changeTime(time)
  }, [time])
  return (
    <div>
      <p>Time is: { newTime }</p>
      <p>Random is: { children }</p>
    </div>
  )
}
复制代码
```
这个时候只有点击 **获取当前时间** 才会执行 `changeTime` 这个函数，而点击 **获取当前随机数** 已经不会触发该函数执行了。
<a name="16VwH"></a>
##### 2.你可能会好奇， `useMemo` 能做的难道不能用 `useEffect` 来做吗？
答案是否定的！如果你在子组件中加入以下代码：
```
const Show:React.FC<Data> = ({ time, children }) => {
	//...
  
  useEffect(() => {
    console.log('effect function here...')
  }, [time])
  const newTime: string = useMemo(() => {
    return changeTime(time)
  }, [time])
  
	//...
}
复制代码
```
你会发现，控制台会打印如下信息：
```
> changeTime excuted...
> effect function here...
复制代码
```
正如我们一开始说的：传入 `useMemo` 的函数会在**渲染期间执行**。 在此不得不提 `React.memo` ，它的作用是实现整个组件的 `Pure` 功能：
```
const Show:React.FC<Data> = React.memo(({ time, children }) => {...}
复制代码
```
所以简单用一句话来概括 `useMemo` 和 `React.memo` 的区别就是：前者在某些情况下不希望组件对所有 `props` 做浅比较，只想实现局部 `Pure` 功能，即只想对特定的 `props` 做比较，并决定是否局部更新。
<a name="tFpIu"></a>
## useCallback
<a name="fkNyV"></a>
### 为啥使用useCallback?
`useMemo` 和 `useCallback` 接收的参数都是一样，都是在其依赖项发生变化后才执行，都是返回缓存的值，区别在于 `useMemo` 返回的是函数运行的结果， `useCallback` 返回的是函数。
> useCallback(fn, deps) 相当于 useMemo(() => fn, deps)

<a name="TZOSP"></a>
### 怎么使用useCallback?
```
function changeName(name) {
  return name + '给name做点操作返回新name'
}
const getNewName = useMemo(() => {
  return changeName(name)
}, [name])
复制代码
```
<a name="J1yKA"></a>
### 场景举例
将之前 `useMemo` 的例子，改一下子组件以下地方就OK了：
```
const Show:React.FC<Data> = ({ time, children }) => {
  //...
  const getNewTime = useCallback(() => changeTime(time), [time])
  return (
    <div>
      <p>Time is: { getNewTime() }</p>
      <p>Random is: { children }</p>
    </div>
  )
}
复制代码
```
<a name="nW3xY"></a>
## useReducer
<a name="LTBBo"></a>
### 为什么使用useReducer?
有没有想过你在某个组件里写了很多很多的 `useState` 是什么观感？比如以下：
```
const [name, setName] = useState<string>('')
const [islogin, setIsLogin] = useState<boolean>(false)
const [avatar, setAvatar] = useState<string>('')
const [age, setAge] = useState<number>(0)
//...
复制代码
```
<a name="6etYW"></a>
### 怎么使用useReducer?
```
import React, { useState, useReducer } from 'react'
type StateType = {
  count: number
}
type ActionType = {
  type: 'reset' | 'decrement' | 'increment'
}
const initialState = { count: 0 }
function reducer(state: StateType, action: ActionType) {
  switch (action.type) {
    case 'reset':
      return initialState
    case 'increment':
      return { count: state.count + 1 }
    case 'decrement':
      return { count: state.count - 1 }
    default:
      return state
  }
}
function Counter({ initialCount = 0}) {
  const [state, dispatch] = useReducer(reducer, { count: initialCount })
  return (
    <div>
      Count: {state.count}
      <button onClick={() => dispatch({ type: 'reset' })}>Reset</button>
      <button onClick={() => dispatch({ type: 'increment' })}>+</button>
      <button onClick={() => dispatch({ type: 'decrement' })}>-</button>
    </div>
  )
}
export default Counter
复制代码
```
<a name="V7CtP"></a>
### 场景举例：
与 `useContext` 结合代替 Redux 方案，往下阅读。
<a name="nzCzR"></a>
## useContext
<a name="ovovY"></a>
### 为啥使用useContext?
简单来说 `Context` 的作用就是对它所包含的组件树提供全局共享数据的一种技术。
<a name="vpfrh"></a>
### 怎么使用useContext？
```
export const ColorContext = React.createContext({ color: '#1890ff' })
const { color } = useContext(ColorContext)
// 或
export const ColorContext = React.createContext(null)
<ColorContext.Provider value='#1890ff'>
  <App />
</ColorContext.Provider>
// App 或以下的所有子组件都可拿到 value
const color = useContext(ColorContext) // '#1890ff'
复制代码
```
<a name="Dknz0"></a>
### 场景举例
<a name="eaUTS"></a>
##### 1.根组件注册，所有子组件都可拿到注册的值：
```
import React, { useContext } from 'react'
const ColorContext = React.createContext<string>('')
const App = () => {
  return (
    <ColorContext.Provider value='#1890ff'>
      <Father />
    </ColorContext.Provider>
  )
}
const Father = () => {
  return (
    <Child />
  )
}
const Child = () => {
  const color = useContext(ColorContext)
  return (
    <div style={{ backgroundColor: color }}>Background color is: { color }</div>
  )
}
export default App
复制代码
```
<a name="Lz4av"></a>
##### 2.配合 `useReducer` 实现 Redux 的代替方案：
```
import React, { useReducer, useContext } from 'react'
const UPDATE_COLOR = 'UPDATE_COLOR'
type StateType = {
  color: string
}
type ActionType = {
  type: string,
  color: string
}
type MixStateAndDispatch = {
  state: StateType,
  dispatch?: React.Dispatch<ActionType>
}
const reducer = (state: StateType, action: ActionType) => {
  switch(action.type) {
    case UPDATE_COLOR:
      return { color: action.color }
    default:
      return state  
  }
}
const ColorContext = React.createContext<MixStateAndDispatch>({
  state: { color: 'black' },
})
const Show = () => {
  const { state, dispatch } = useContext(ColorContext)
  return (
    <div style={{ color: state.color }}>
      当前字体颜色为: {state.color}
      <button onClick={() => dispatch && dispatch({type: UPDATE_COLOR, color: 'red'})}>红色</button>
      <button onClick={() => dispatch && dispatch({type: UPDATE_COLOR, color: 'green'})}>绿色</button>
    </div>
  )
}
const Example = ({ initialColor = '#000000' }) => {
  const [state, dispatch] = useReducer(reducer, { color: initialColor })
  return (
    <ColorContext.Provider value={{state, dispatch}}>
      <div>
        <Show />
        <button onClick={() => dispatch && dispatch({type: UPDATE_COLOR, color: 'blue'})}>蓝色</button>
        <button onClick={() => dispatch && dispatch({type: UPDATE_COLOR, color: 'lightblue'})}>轻绿色</button>
      </div>
    </ColorContext.Provider>
  )
}
export default Example
```




