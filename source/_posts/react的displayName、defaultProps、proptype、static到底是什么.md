---
title: react的displayName、defaultProps、proptype、static到底是什么?
date: 2019-09-08 15:50:55
tags: [displayName, defaultProps, prototype, static]
---

### displayName:

> `displayName` 字符串多用于调试消息。通常，你不需要设置它，因为它可以根据函数组件或 class 组件的名称推断出来。如果调试时需要显示不同的名称或创建高阶组件，请参阅[使用 displayname 轻松进行调试](https://zh-hans.reactjs.org/docs/higher-order-components.html#convention-wrap-the-display-name-for-easy-debugging)了解更多。

### defaultProps:

   deaultProps用的时候需要添加static 也就是需要添加到class的静态属性里面,当此组件的父级没有传入props属性时, 此组件会用defaultProps里面的属性; defaultProps 会添加到组件的this.props里面,跟从父级传递过来一样



```js
// Resolve default props react 源码
  if (type && type.defaultProps) {
    const defaultProps = type.defaultProps;
    for (propName in defaultProps) {
      if (props[propName] === undefined) {
        props[propName] = defaultProps[propName];
      }
    }
  }
```

### static:

> ### 类就是实例的原型，以前我们一般会new一个test(),有在类中(test)定义的方法，都会被实例继承。如果在一个方法前，加上static关键字，就表示该方法不会被实例继承，而是直接通过类来调用，这就称为“静态方法”

父类中的静态方法和属性 不能通过new() 实例化的child继承,

但是 通过extend 继承的child是可以继承父类的静态方法和属性的

### proptype:

类似typescript的react自带的类型检查



```js
// 数组、布尔、函数、数字、对象、字符串、symbol
MyComponent.propTypes = {
  optionalArray: PropTypes.array,
  optionalBool: PropTypes.bool,
  optionalFunc: PropTypes.func,
  optionalNumber: PropTypes.number,
  optionalObject: PropTypes.object,
  optionalString: PropTypes.string,
  optionalSymbol: PropTypes.symbol,

  // 任何东西都可以被渲染:numbers, strings, elements,或者是包含这些类型的数组(或者是片段)。
  optionalNode: PropTypes.node,

  // 一个 React 元素。
  optionalElement: PropTypes.element,

  // 你也可以声明一个 prop 是类的一个实例。
  // 使用 JS 的 instanceof 运算符。
  optionalMessage: PropTypes.instanceOf(Message),

  // 你可以声明 prop 是特定的值，类似于枚举
  optionalEnum: PropTypes.oneOf(['News', 'Photos']),

  // 一个对象可以是多种类型其中之一
  optionalUnion: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
    PropTypes.instanceOf(Message)
  ]),

  // 一个某种类型的数组
  optionalArrayOf: PropTypes.arrayOf(PropTypes.number),

  // 属性值为某种类型的对象
  optionalObjectOf: PropTypes.objectOf(PropTypes.number),

  // 一个特定形式的对象
  optionalObjectWithShape: PropTypes.shape({
    color: PropTypes.string,
    fontSize: PropTypes.number
  }),

  // 你可以使用 `isRequired' 链接上述任何一个，以确保在没有提供 prop 的情况下显示警告。
  requiredFunc: PropTypes.func.isRequired,

  // 任何数据类型的值
  requiredAny: PropTypes.any.isRequired,

  // 你也可以声明自定义的验证器。如果验证失败返回 Error 对象。不要使用 `console.warn` 或者 throw ，
  // 因为这不会在 `oneOfType` 类型的验证器中起作用。
  customProp: function(props, propName, componentName) {
    if (!/matchme/.test(props[propName])) {
      return new Error(
        'Invalid prop `' + propName + '` supplied to' +
        ' `' + componentName + '`. Validation failed.'
      );
    }
  },

  // 也可以声明`arrayOf`和`objectOf`类型的验证器，如果验证失败需要返回Error对象。
  // 会在数组或者对象的每一个元素上调用验证器。验证器的前两个参数分别是数组或者对象本身，
  // 以及当前元素的键值。
  customArrayProp: PropTypes.arrayOf(function(propValue, key, componentName, location, propFullName) {
    if (!/matchme/.test(propValue[key])) {
      return new Error(
        'Invalid prop `' + propFullName + '` supplied to' +
        ' `' + componentName + '`. Validation failed.'
      );
    }
  })
};
```

### 限制单个子代

```jsx
// 组件
const OnlyOneChild = props => {
  const children = props.children
  return <div>{children}</div>
}
OnlyOneChild.propTypes = {
  children: PropTypes.element.isRequired
}

// 容器
<OnlyOneChild>
  <h3>第一个子节点</h3>
  <h3>第二个子节点</h3>
</OnlyOneChild>
```