---
title: 通过Form.create创建的form域
date: 2021-04-01 12:07:21
tags: [form]
---
详细看官网文档:

被getFieldDecorator包装的组件 想要设置默认值 只能设置initialValue 如果属性名称不为vlaue, 可以通过valuePropName属相来声明 例如switch:
const options = {
valuePropName: 'checked',
initalValue: true

}

getFieldDecorator(id, options)


经过 `Form.create` 包装的组件将会自带 `this.props.form` 属性，`this.props.form` 提供的 API 如下：
> 注意：使用 `getFieldsValue` `getFieldValue` `setFieldsValue` 等时，应确保对应的 field 已经用 `getFieldDecorator` 注册过了。

![图片.png](https://cdn.nlark.com/yuque/0/2019/png/206259/1571898869834-ea0bf83a-21e4-48b2-8098-3337dc757f35.png#align=left&display=inline&height=829&name=%E5%9B%BE%E7%89%87.png&originHeight=829&originWidth=1367&size=413939&status=done&width=1367)

### this.props.form.getFieldDecorator(id, options)[#](https://ant.design/components/form-cn/#thispropsformgetFieldDecorator(id,-options))
经过 `getFieldDecorator` 包装的控件，表单控件会自动添加 `value`（或 `valuePropName` 指定的其他属性） `onChange`（或 `trigger` 指定的其他属性），数据同步将被 Form 接管，这会导致以下结果：

1. 你**不再需要也不应该**用 `onChange` 来做同步，但还是可以继续监听 `onChange` 等事件。

1. 你不能用控件的 `value` `defaultValue` 等属性来设置表单域的值，默认值可以用 `getFieldDecorator` 里的 `initialValue`。

1. 你不应该用 `setState`，可以使用 `this.props.form.setFieldsValue` 来动态改变表单值。


![图片.png](https://cdn.nlark.com/yuque/0/2019/png/206259/1571898916290-ba8f21cf-fbdc-42f2-b92e-186a778e7ab0.png#align=left&display=inline&height=650&name=%E5%9B%BE%E7%89%87.png&originHeight=650&originWidth=1394&size=277016&status=done&width=1394)
