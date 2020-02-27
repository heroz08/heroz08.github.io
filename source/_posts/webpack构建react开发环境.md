---
title: webpack构建react开发环境
date: 2019-09-08 15:29:18
tags: [webpack, react, 开发环境]
---



### 创建项目

```
npm init -y
```



### 安装依赖



- 安装react



```
npm i react react-dom --save
```





- 安装babel



```
npm i babel-loader @babel/core @babel/preset-env @babel/preset-react babel-plugin-import --D
```





- 安装webpack



```
npm i webpack webpack-cli webpack-dev-server --D
```





### 创建webpack和babel配置文件



- 创建 .babelrc文件



```js
"presets": ["@babel/preset-env", "@babel/preset-react"],
  "plugins": [
    ["import", { //按需加载antd样式
       "libraryName": "antd",
      "libraryDirectory": "es",
      "style": "css"
     }]
  ]
}
```



- 创建webpack,config.js 文件



```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development', // 开发环境
  devtool: 'eval-source-map', // 报错映射
  entry: './index.js', //入口
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            plugins: [
              ['import',{libraryName: 'antd',style: 'css'}]
            ]
          }
        }
      },
      {
        test: /\.css$/,
        use: ['style-loader','css-loader']
      },
      {
        test: /\.less$/,
        use: ['style-loader','css-loader','less-loader'], // 顺序从右往左写
        exclude: /node_modules/ //  排除antd的less样式
      },
      {
        test: /\.(gif|jpg|png|woff|svg|eot|ttf)\??.*$/,
        use:['url-loader']
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({ // 设置html模板
      title: 'test',
      template: './public/index.html'
    })
  ],
  resolve: {
    alias: { // 创建别名
      '@src': path.resolve(__dirname,'src'),
      'components': path.resolve(__dirname,"src/componts/")
    }
  }
}
```



### package.json 文件里面添加快捷命令



```js
"build": "webpack",
"start": "webpack-dev-server --open --mode development --history-api-fallback"
```

