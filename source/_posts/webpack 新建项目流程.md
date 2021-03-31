---
title: webpack 新建项目流程
date: 2021-04-01 12:06:07
tags: []
---
### 1. 始化项目


```javascript
npm init -y
```
### 2. 创建项目结构


```shell
.
├── dist // 生成目录
├── dll_script // 生成的dll的js和manifest.json
│   ├── commons.dll.js
│   ├── commons.manifest.json
│   ├── react.dll.js
│   └── react.manifest.json
├── package.json
├── public // html 模板和ico
│   ├── favicon.ico
│   └── index.html
├── script // webpack 配置脚本
│   ├── webpack.build.js
│   ├── webpack.common.js
│   ├── webpack.dev.js
│   └── webpack.dll.js
├── src // 项目文件
│   ├── history
│   │   └── index.js
│   ├── index.js
│   ├── page
│   │   ├── Home
│   │   │   ├── index.jsx
│   │   │   └── index.less
│   │   └── index.js
│   └── store
│       └── index.js
└── yarn.lock
```


### 3.安装webpack及插件


```javascript
yarn add webpack webpack-cli html-webpack-plugin webpack-dev-server clean-webpack-plugin -D
// 	html-webpack-plugin 将生成的javascript文件打到模板 index.html上
// clean-webpack-plugin 清除生成的文件
// webpack-dev-server 	本地服务器
```
### 4. 安装babel和loader


```javascript
yarn add @babel/core @babel/preset-env @babel/preset-react -D
// babel-loader和@babel/core是核心模块
// @babel/preset-env是一个智能预设，允许您使用最新的JavaScript
// @babel/preset-react 转换JSX
yarn add babel-loader less-loader css-loader style-loader -D
// less-loader css loader style-loader less文件loader 顺序是 style => css => less 执行过程是相反的
yarn add less -D
yarn add file-loader -D
yarn add url-loader -D
// file-loader和url-loader 基本差不多区别在与 url会把图片转成base64

yarn add babel-plugin-import -D // 按需引入
yarn add  @babel/preset-typescript -D // ts
```


### 5.配置babel .babelrc


```javascript
{
	"presets": [
  	"@babel/preset-env", "@babel/preset-react", "@babel/preset-typescript" // 最后一个为ts
  ],
  "plugins": [
    [
    	"import", { // 需要安装babel-plugin-import
      	"libraryName": 'antd',
        "style": true, // 支持antd 按需引入less 当值为 "css"则引入antd css文件
      }
    ]
  ]
}
```


### 6. 配置webpack.config.js

- webpack.common.js // webpack 共用配置



```javascript
const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: { // 入口
    main: path.resolve(__dirname, '../src/index.js')
  },
  output: { // 出口
    filename: '[name].js',
    chunkFilename: '[name].js',
    path: path.resolve(__dirname, '../dist'),
    publicPath: '/' // 上cdn的需要配置此项
  },
  resolve: {
    extensions: ['.js', '.jsx'], // 配置此项后就可以通过index直接引入不需要写后缀
    alias: { // 别名
    	"@src": path.resolve(__dirname, '../src')
    }
  },
  module: {
    rules: [
      {
      	test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        // use: ["babel-loader"], // 两种方式都可以
        use: [
          {
          	loader: "babel-loader"
          }
        ]
      },
      {
      	test: /\.less$/,
        use: [
          {
          	loader: "style-loader"
          },
          {
          	loader: "css-loader"
          },
          {
          	loader: "less-loader",
            options: {
            	javascriptEnabled: true
            }
          }
        ]
      },
      {
        test: /\.css$/,
        use: [
          {
          	loader: "style.loader"
          },
          {
          	loader: "css-loader"
          }
        ]
      },
      {
      	test: /\.(jpg|jepg|png|gif)$/,
        use: [
          {
          	loader: "file-loader",
            options: {
            	name: '[name].[ext]',
              outputPath: 'images/'
            }
          }
        ]
      },
      {
      	test: /\.(eot|woff2|ttf|svg)$/,
        use: [
          {
          	loader: "file-loader",
            options: {
            	name: '[name].[ext]',
              outputPath: "fonts/"
            }
          }
        ]
      }
    ]
  },
  // 拆分打包
  optimization: {
  	splitChunks: {
    	chunks: 'all',// 只对异步引入代码起作用，设置all时并同时配置vendors才对两者起作用
      automaticNameDelimiter: '~',  // 生成文件名的文件链接符
      name: true, // 开启自定义名称效果，
      cacheGroups: {
    		vendors: {
        	test: /[\\/]node_modules[\\/]/,
          priority: -10, // 优先级
          filename: "vendors.js"
        },
        // default: false // false为禁止default及最后打包为vendors和入口的main
        default: { // 打包为chunk.js vendors.js 及入口的main.js
        	priority: -20, 
          reuseExistingChunk: true,
          filename: 'chunk.js'
        }
    	}
    }
  },
  plugins: [ // manifest 的地址和名称对应webpack.dll.js里面的配置 提升打包速度优化
  	new webpack.DllReferencePlugin({
      manifest: require('../dll_script/commons.manifest.json')
    }),
    new webpack.DllReferencePlugin({
    	manifest: require('../dll_script/react.manifest.json')
    })
  ]
}
```


- webpack.dev.js // dev 配置



```javascript
const webpackCommon = require('./webpack.common.js');
const htmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

webpackCommon.plugins.push(
  new htmlWebpackPlugin({
  	template: path.resolve(__dirname, '../public/index.html');
  })
)
webpackCommon.plugins.push(new CleanWebpackPlugin())

const webpackDevConfig = {
  mode: 'development',
	devtool: "cheap-source-map", // 映射
  devServer: {
    port: 8090, // 端口号
  	open: true, // 自动打开浏览器
    historyApiFallback: true, // 404时返回首页
  }
}

module.exports = Object.assgin(webpackDevConfig, webpackCommon);
```


- webpack.build.js // 打包配置



```javascript
const webpackCommon = require('./webpackCommon.js');
const webpackBuildConfig = {
	mode: 'production'
}

module.exports = Object.assgin(webpackCommon, webpackBuildConfig);

```


- webpack.dll.js // 生成dll.js和json配置



```javascript
const path = require('path');
const webpack = require('webpack');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const webpackDllConfig = {
	mode: 'production',
  entry: {
  	react: ['react', 'react-dom', 'react-router', 'react-router-dom', 'mobx-react'],
    //	mobx-react 应该是和react有依赖关系所以要和react放到一起
    commons: ['mobx']
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../dll_script'),
    library: '[name]' // 目前理解为将dll打包后暴露出来一个对应的变量，以便导入import
    // 更多 https://webpack.docschina.org/guides/author-libraries/#%E6%9A%B4%E9%9C%B2-library
  },
  plugins: [
    new CleanWebpackPlugin({
    	path: path.resolve(__dirname, '../dll_script')
    }),
    new webpack.DllPlugin({
    	name: '[name]',
      path: path.resolve(__dirname, '../dll_script/[name].manifest.json')
    })
  ]
}
```
### 7. package.json 里面添加脚本命令


```javascript
{
  "name": "webpackDemo",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "webpack serve --config ./script/webpack.dev.js",
    "build": "webpack --config ./script/webpack.build.js",
    "dll": "webpack --config ./script/webpack.dll.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "@babel/core": "^7.7.7",
    "@babel/plugin-proposal-class-properties": "^7.7.4",
    "@babel/plugin-proposal-decorators": "^7.7.4",
    "@babel/preset-env": "^7.7.7",
    "@babel/preset-react": "^7.7.4",
    "babel-loader": "^8.0.6",
    "babel-plugin-import": "^1.13.0",
    "clean-webpack-plugin": "^3.0.0",
    "css-loader": "^3.4.0",
    "file-loader": "^5.0.2",
    "html-webpack-plugin": "^3.2.0",
    "less": "^3.10.3",
    "less-loader": "^5.0.0",
    "style-loader": "^1.1.1",
    "url-loader": "^3.0.0",
    "webpack": "^4.41.4",
    "webpack-cli": "^3.3.10",
    "webpack-dev-server": "^3.10.1"
  },
  "dependencies": {
    "antd": "^3.26.4",
    "mobx": "^5.15.1",
    "mobx-react": "^6.1.4",
    "react": "^16.12.0",
    "react-dom": "^16.12.0",
    "react-router": "^5.1.2",
    "react-router-dom": "^5.1.2"
  }
}

```
### 8. 配置项目babel支持@修饰符

- 安装babel插件@babel/plugin-proposal-class-properties， @babel/plugin-proposal-decorators



- 修改.babelrc

```javascript
{
	"presets": [
  	"@babel/preset-env", "@babel/preset-react"
  ],
  "plugins": [
    [
    	"@babel/plugin-proposal-decorators",
      // 装饰器插件 要放到"@babel/plugin-proposal-class-properties"之前
      {
      	"legacy": true
      }
    ],
    [
    	"@babel/plugin-proposal-class-properties"
      // 是类中定义实例属性的新方法,以前定义实例的属性只能写在constructor中，现在可以直接写在外面
    ]
    [
    	"import", {
      	"libraryName": 'antd',
        "style": true, // 支持antd 按需引入less 当值为 "css"则引入antd css文件
      }
    ]
  ]
}
```

9. 别名
- webpack下设置别名
```javascript
resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx'],
    alias: {
      "@": path.resolve(__dirname, "../src")
    }
  },
```

- tsconfig.json
```javascript
{
	 "compilerOptions": {
     	"baseUrl": ".", // 必须有
    	"paths": {
      	"@src/*": ["./src/*"]
    	}
   }
}
```

10. tsconfig
```javascript
{
  "compilerOptions": {
    "jsx": "react",
    "target": "es5",                          /* Specify ECMAScript target version: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', 'ES2018', 'ES2019', 'ES2020', or 'ESNEXT'. */
    "module": "commonjs",                     /* Specify module code generation: 'none', 'commonjs', 'amd', 'system', 'umd', 'es2015', 'es2020', or 'ESNext'. */
    "skipLibCheck": true,                     /* Skip type checking of declaration files. */
    "strict": true,                           /* Enable all strict type-checking options. */
    "allowSyntheticDefaultImports": true,     /* Allow default imports from modules with no default export. This does not affect code emit, just typechecking. */
    "esModuleInterop": true,                  /* Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for all imports. Implies 'allowSyntheticDefaultImports'. */
    "forceConsistentCasingInFileNames": true, /* Disallow inconsistently-cased references to the same file. */
    "baseUrl": ".",
    "paths": {
      "@src/*": ["./src/*"]
    }
    /* Visit https://aka.ms/tsconfig.json to read more about this file */

    /* Basic Options */
    // "incremental": true,                   /* Enable incremental compilation */
    
    // "lib": [],                             /* Specify library files to be included in the compilation. */
    // "allowJs": true,                       /* Allow javascript files to be compiled. */
    // "checkJs": true,                       /* Report errors in .js files. */
    // "jsx": "preserve",                     /* Specify JSX code generation: 'preserve', 'react-native', or 'react'. */
    // "declaration": true,                   /* Generates corresponding '.d.ts' file. */
    // "declarationMap": true,                /* Generates a sourcemap for each corresponding '.d.ts' file. */
    // "sourceMap": true,                     /* Generates corresponding '.map' file. */
    // "outFile": "./",                       /* Concatenate and emit output to single file. */
    // "outDir": "./",                        /* Redirect output structure to the directory. */
    // "rootDir": "./",                       /* Specify the root directory of input files. Use to control the output directory structure with --outDir. */
    // "composite": true,                     /* Enable project compilation */
    // "tsBuildInfoFile": "./",               /* Specify file to store incremental compilation information */
    // "removeComments": true,                /* Do not emit comments to output. */
    // "noEmit": true,                        /* Do not emit outputs. */
    // "importHelpers": true,                 /* Import emit helpers from 'tslib'. */
    // "downlevelIteration": true,            /* Provide full support for iterables in 'for-of', spread, and destructuring when targeting 'ES5' or 'ES3'. */
    // "isolatedModules": true,               /* Transpile each file as a separate module (similar to 'ts.transpileModule'). */

    /* Strict Type-Checking Options */
    
    // "noImplicitAny": true,                 /* Raise error on expressions and declarations with an implied 'any' type. */
    // "strictNullChecks": true,              /* Enable strict null checks. */
    // "strictFunctionTypes": true,           /* Enable strict checking of function types. */
    // "strictBindCallApply": true,           /* Enable strict 'bind', 'call', and 'apply' methods on functions. */
    // "strictPropertyInitialization": true,  /* Enable strict checking of property initialization in classes. */
    // "noImplicitThis": true,                /* Raise error on 'this' expressions with an implied 'any' type. */
    // "alwaysStrict": true,                  /* Parse in strict mode and emit "use strict" for each source file. */

    /* Additional Checks */
    // "noUnusedLocals": true,                /* Report errors on unused locals. */
    // "noUnusedParameters": true,            /* Report errors on unused parameters. */
    // "noImplicitReturns": true,             /* Report error when not all code paths in function return a value. */
    // "noFallthroughCasesInSwitch": true,    /* Report errors for fallthrough cases in switch statement. */

    /* Module Resolution Options */
    // "moduleResolution": "node",            /* Specify module resolution strategy: 'node' (Node.js) or 'classic' (TypeScript pre-1.6). */
    // "baseUrl": "./",                       /* Base directory to resolve non-absolute module names. */
    // "paths": {},                           /* A series of entries which re-map imports to lookup locations relative to the 'baseUrl'. */
    // "rootDirs": [],                        /* List of root folders whose combined content represents the structure of the project at runtime. */
    // "typeRoots": [],                       /* List of folders to include type definitions from. */
    // "types": [],                           /* Type declaration files to be included in compilation. */
    
    // "preserveSymlinks": true,              /* Do not resolve the real path of symlinks. */
    // "allowUmdGlobalAccess": true,          /* Allow accessing UMD globals from modules. */

    /* Source Map Options */
    // "sourceRoot": "",                      /* Specify the location where debugger should locate TypeScript files instead of source locations. */
    // "mapRoot": "",                         /* Specify the location where debugger should locate map files instead of generated locations. */
    // "inlineSourceMap": true,               /* Emit a single file with source maps instead of having a separate file. */
    // "inlineSources": true,                 /* Emit the source alongside the sourcemaps within a single file; requires '--inlineSourceMap' or '--sourceMap' to be set. */

    /* Experimental Options */
    // "experimentalDecorators": true,        /* Enables experimental support for ES7 decorators. */
    // "emitDecoratorMetadata": true,         /* Enables experimental support for emitting type metadata for decorators. */

    /* Advanced Options */
  },
  "include": [
    "src"
  ],    
}

```
