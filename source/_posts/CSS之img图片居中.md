---
title: CSS之img图片居中
date: 2019-09-08 15:26:12
tags: [css, img, 居中]
---



原文链接：http://caibaojian.com/img-vertical-middle.html



在[前端开发](http://caibaojian.com/)制作中，图片[垂直居中](http://caibaojian.com/t/垂直居中)对齐是很常见的，有些是固定高度，有些没有固定高度，本文分享我用的四种方法，希望对你有所启发。



以下说的做法暂不考虑IE浏览器的兼容性，适用于移动端，对兼容性感兴趣的可以看之前的文章：[图片垂直居中对齐的3种方法](http://caibaojian.com/vertical-centering-with-css.html)



以下的做法中假定外层的高度和宽度已经固定。通用[HTML](http://caibaojian.com/t/html)和[CSS](http://caibaojian.com/css3/)代码：



```html
<div class="img">
<img src="http://dummyimage.com/200x200/f66/"/>
</div>
```



```css
.img {
  width:300px;
  height:300px;
  margin:20px auto;
  background:#00f;
}
```



### 1.绝对定位+margin:auto



利用图片相对于外层浮动，加上margin:auto.



```html
<div class="img img1">
<img src="http://dummyimage.com/200x200/f66/"/>
</div>
```



```css
//code from http://caibaojian.com/img-vertical-middle.html
.img1 {
  position:relative;
}
.img1 img {
  position:absolute;
  top:0;
  bottom:0;
  left:0;
  right:0;
  margin:auto;
}
```



[演示1](http://caibaojian.com/demo/2017/07/img1.html#demo1)



### 2.flexbox



利用flexbox里面的[垂直居中](http://caibaojian.com/t/垂直居中)属性：align-items:center(垂直居中)和justify-content:center(水平居中);[·](http://caibaojian.com/img-vertical-middle.html)



```html
<div class="img img2">
  <img src="http://dummyimage.com/200x200/f66/"/>
</div>
```



```css
.img2 {
  display:-webkit-box;
  display:-ms-flexbox;
  display:flex-box;
  display:flex;
  -webkit-box-align:center;
  -ms-flex-align:center;
  align-items:center;
  -webkit-box-pack:center;
  -ms-flex-pack:center;
  justify-content:center;
  text-align:center;
}
```



[演示2](http://caibaojian.com/demo/2017/07/img1.html#demo2)



### 3.table-cell



利用display:table-cell+图片vertical-align:middle



```html
<div class="img img3">
  <span class="icenter"><img src="http://dummyimage.com/200x200/f66/"/></span>
</div>
```



```css
.img3 .icenter {
  display:table-cell;
  vertical-align:middle;
  text-align:center;
  height:300px;
  width:300px
}
.img3 img {
  vertical-align:middle;
  display:inline-block
}
```



[演示3](http://caibaojian.com/demo/2017/07/img1.html#demo3)



### 4.增加一个空白标签



兼容性较好，支持IE浏览器



```html
<div class="img img4">
  <img src="http://dummyimage.com/200x200/f66/"/>
  <i class="iblock"></i>
</div>
```



```css
.img4 {
  text-align:center
}
.img4 img {
  vertical-align:middle
}
.img4 .iblock {
  display:inline-block;
  height:100%;
  width:0;
  vertical-align:middle
}
```

