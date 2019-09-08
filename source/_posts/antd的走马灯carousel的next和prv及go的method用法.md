---
title: antd的走马灯carousel的next和prv及go的method用法
date: 2019-09-08 14:57:10
tags: [走马灯, carousel, next, pro, go, antd]
---



> https://react-slick.neostack.com/docs/api#onReInit
>
> 更多的属性和方法以上网址查看

如果页面需要手动render的时候用的手动更新的方式

carousel的下标index为非受控的值,重新render的时候 initialSlide默认为0；

此时可以同过initialSlide这个属性将其设成受控属性，在重新render的时候就可以了

#### antd的carousel里面提供了method：

- goTo()
- next()
- prev()

但是没详细说明怎么用
这个主要用到ref={node => (this.slider = node)}
这样就可以通过使用:

- this.slider.next()
- this.slider.prev()