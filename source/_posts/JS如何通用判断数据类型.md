---
title: JS如何通用判断数据类型
date: 2021-03-24 20:55:32
tags: 数据类型
---
typeof对于原始类型（除了Null)是可以检测到的，但是引用类型就统一返回object
instance of 用于检测构造函数的原型是否出现在某个实例函数的原型链上
最好的方法是使用 Object.prototype.toString方法，它可以检测到任何类型，
返回的结果是[object Type]的形式,基本可以实现所有类型的检测
```
function type(data){
  const toString = Object.prototype.toString;
  const objType = toString.call(data);
  const arr = objType.slice(1, -1).split(' ');
  const type = arr[1].toLowerCase();
    // const type = .call(data).slice(1,-1).split(' ')[1].toLowerCase()
  return type;
}
type([])
"array"
type(123)
"number"
type('123')
"string"
type({})
"object"
type(type)
"function"
type(null)
"null"
type(undefined)
"undefined"
type(Symbol())
"symbol"
```
