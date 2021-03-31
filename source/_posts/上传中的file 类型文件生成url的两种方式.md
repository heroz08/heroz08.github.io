---
title: 上传中的file 类型文件生成url的两种方式
date: 2021-04-01 12:07:21
tags: []
---
## 1.  URL.createObjectURL()


> **`URL.createObjectURL()`** 静态方法会创建一个 [`DOMString`](https://developer.mozilla.org/zh-CN/docs/Web/API/DOMString)，其中包含一个表示参数中给出的对象的URL。这个 URL 的生命周期和创建它的窗口中的 [`document`](https://developer.mozilla.org/zh-CN/docs/Web/API/Document) 绑定。这个新的URL 对象表示指定的 [`File`](https://developer.mozilla.org/zh-CN/docs/Web/API/File) 对象或 [`Blob`](https://developer.mozilla.org/zh-CN/docs/Web/API/Blob) 对象。




- 语法

参数object 用于创建url的File对象、Blob对象或者MediaSource对象。
```javascript
objectURL = URL.createObjectURL(object);
```


- 注意



> 在每次调用 `createObjectURL()` 方法时，都会创建一个新的 URL 对象，即使你已经用相同的对象作为参数创建过。当不再需要这些 URL 对象时，每个对象必须通过调用 [`URL.revokeObjectURL()`](https://developer.mozilla.org/zh-CN/docs/Web/API/URL/revokeObjectURL) 方法来释放。
> 浏览器在 document 卸载的时候，会自动释放它们，但是为了获得最佳性能和内存使用状况，你应该在安全的时机主动释放掉它们。



## 2. FileReader.readAsDataURL()


> `**FileReader**` 对象允许Web应用程序异步读取存储在用户计算机上的文件（或原始数据缓冲区）的内容，使用 [`File`](https://developer.mozilla.org/zh-CN/docs/Web/API/File) 或 [`Blob`](https://developer.mozilla.org/zh-CN/docs/Web/API/Blob) 对象指定要读取的文件或数据。
> 其中File对象可以是来自用户在一个[`<input>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input)元素上选择文件后返回的[`FileList`](https://developer.mozilla.org/zh-CN/docs/Web/API/FileList)对象,也可以来自拖放操作生成的 [`DataTransfer`](https://developer.mozilla.org/zh-CN/docs/Web/API/DataTransfer)对象,还可以是来自在一个[`HTMLCanvasElement`](https://developer.mozilla.org/zh-CN/docs/Web/API/HTMLCanvasElement)上执行`mozGetAsFile()`方法后返回结果。



- 属性
   1. FileReader.error  只读  表示读取文件时发生的错误。
   1. FileReader.readyState 只读 表示FileReader状态的数字
      1. 常量名    值    描述
      1. EMPTY    0    还没有加载任何数据。
      1. LOADING    1    数据正在被加载。
      1. DONE    2    已完成全部的读取请求。
   3. FileReader.result 只读 此属性仅在读取操作完成后才有效 表示文件的内容。
- 事件
   - onabort    该事件在读取操作发生错误的时候触发。
   - onerror    读取发生错误的时候触发。
   - onload    读取完成时触发。
   - onloadstart    读取开始时触发。
   - onloadend    读取结束时 触发 要么成功 要么失败。
   - onprogress    读取Blob时触发。
- 方法
   - FileReader.abort() 中止读取操作 再返回时 readyState 属性为DONE。
   - FileReader.readAsArrayBuffer() 开始读取Blob 或file 中的内容，一旦完成result属性中为读取文件的ArrayBuffer数据对象。
   - FileReader.readAsBinaryString（） 开始读取指定的Blob或file的内容的， 一旦完成 result属性为读取文件的二进制数据。
   - FileReader.readAsDataURL() 开始读取指定Blob或file的内容，一旦完成result属性为一个data：URL格式的Base64字符串。
   - FileReader.readAsText() 开始读取指定Blob或file的内容，一旦完成result属性为一个字符串已表示文件内容。



> 当 FileReader 读取文件的方式为  readAsArrayBuffer, readAsBinaryString, readAsDataURL 或者 readAsText 的时候，会触发一个 load 事件。从而可以使用  FileReader.onload 属性对该事件进行处理。



```javascript
const rederFile = new FileReader();
        rederFile.onload = (event) => {
          dataURL = event.target.result; // 得到的url
        }
rederFile.readAsDataURL(file);
```




