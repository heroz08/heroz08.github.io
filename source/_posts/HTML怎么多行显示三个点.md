---
title: HTML怎么多行显示三个点
date: 2019-09-08 15:05:44
tags: [html, 多行, 三个点, ...]
---

限制在一个块元素显示的文本的行数。



-webkit-line-clamp 是一个 不规范的属性（unsupported WebKit property），它没有出现在 CSS 规范草案中。



为了实现该效果，它需要组合其他外来的WebKit属性。常见结合属性：



display: -webkit-box; 必须结合的属性 ，将对象作为弹性伸缩盒子模型显示 。



-webkit-box-orient 必须结合的属性 ，设置或检索伸缩盒对象的子元素的排列方式 。



text-overflow，可以用来多行文本的情况下，用省略号“...”隐藏超出范围的文本 。

#### css属性： **块元素**

```css
display: -webkit-box;
-webkit-line-clamp: 2;//限制文本的行数，只显示两行
-webkit-box-orient: vertical;
overflow: hidden;
```

#### 如果遇到 webpack 编译或打包后属性消失 可以用下面的解决：

```css
/* autoprefixer: off */
  -webkit-box-orient: vertical;        // 参考 https://github.com/postcss/autoprefixer/issues/776
/* autoprefixer: on */	
```

#### 例子：

```css
p{
    /* autoprefixer: off */
    -webkit-box-orient: vertical;
    /* autoprefixer: on */
    display: -webkit-box;
    -webkit-line-clamp: 3;
    overflow: hidden;
}
```