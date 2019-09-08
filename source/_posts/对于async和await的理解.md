---
title: 对于async和await的理解
date: 2019-09-08 15:37:30
tags: [async, await]
---

**await 只能出现在 async 函数中(每个await外面肯定有一个async);**

**async 声明一个异步函数, await等待一个异步函数**

#### 在await里面return 一个结果,其实返回的是个Promise对象

- 可以通过then的方式获取值;

- await可以获取返回的promise里的值



**await 可以等待promise也可以为常量 (个人理解为异步或同步)**

---
await 等到了它要等的东西，一个 Promise 对象，或者其它值，然后呢？我不得不先说，`await` 是个运算符，用于组成表达式，await 表达式的运算结果取决于它等的东西。

---
如果它等到的不是一个 Promise 对象，那 await 表达式的运算结果就是它等到的东西。

---
如果它等到的是一个 Promise 对象，await 就忙起来了，它会阻塞后面的代码，等着 Promise 对象 resolve，然后得到 resolve 的值，作为 await 表达式的运算结果。


> 看到上面的阻塞一词，心慌了吧……放心，这就是 await 必须用在 async 函数中的原因。async 函数调用不会造成阻塞，它内部所有的阻塞都被封装在一个 Promise 对象中异步执行。