---
layout: react-native
title: ios环境搭建 关于pod的坑
date: 2019-09-08 09:56:12
tags: iOS react-native 环境搭建 pod
---

https://reactnative.cn/docs/getting-started/

## 坑



ios 在init项目的时候,第一次安装会遇见安装到info Installing required CocoaPods dependencies这个地方就卡住了不动了,这应该是网路原因导致的,解决办法:



1. 安装cocoapods 这个安装需要ruby ,mac自带ruby 所以只需要用sudo gem update —system 更新下

```
sudo gem install cocoapods
```

1. 进入到项目里的ios目录下有个文件podfile,看到此文件后,执行 pod install 然后会提示你用pod install —repo-update
2. 如果还是报错就再输入他提示的命令
3. 基本上就可以了,然后可以重新init项目就不会卡在那里了



## 安装依赖(以下来自react-native文档)

必须安装的依赖有：Node、Watchman 和 React Native 命令行工具以及 Xcode。

虽然你可以使用`任何编辑器`来开发应用（编写 js 代码），但你仍然必须安装 Xcode 来获得编译 iOS 应用所需的工具和环境。

### Node, Watchman

我们推荐使用[Homebrew](http://brew.sh/)来安装 Node 和 Watchman。在命令行中执行下列命令安装：

```
brew install node
brew install watchman
```

如果你已经安装了 Node，请检查其版本是否在 v10 以上。安装完 Node 后建议设置 npm 镜像以加速后面的过程（或使用科学上网工具）。

> 注意：不要使用 cnpm！cnpm 安装的模块路径比较奇怪，packager 不能正常识别！

```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```

[Watchman](https://facebook.github.io/watchman)则是由 Facebook 提供的监视文件系统变更的工具。安装此工具可以提高开发时的性能（packager 可以快速捕捉文件的变化从而实现实时刷新）。

### Yarn、React Native 的命令行工具（react-native-cli）

[Yarn](http://yarnpkg.com/)是 Facebook 提供的替代 npm 的工具，可以加速 node 模块的下载。React Native 的命令行工具用于执行创建、初始化、更新项目、运行打包服务（packager）等任务。

```
npm install -g yarn react-native-cli
```

安装完 yarn 后同理也要设置镜像源：

```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

安装完 yarn 之后就可以用 yarn 代替 npm 了，例如用`yarn`代替`npm install`命令，用`yarn add 某第三方库名`代替`npm install 某第三方库名`。

### Xcode

React Native 目前需要[Xcode](https://developer.apple.com/xcode/downloads/) 9.4 或更高版本。你可以通过 App Store 或是到[Apple 开发者官网](https://developer.apple.com/xcode/downloads/)上下载。这一步骤会同时安装 Xcode IDE、Xcode 的命令行工具和 iOS 模拟器。

#### Xcode 的命令行工具

启动 Xcode，并在`Xcode | Preferences | Locations`菜单中检查一下是否装有某个版本的`Command Line Tools`。Xcode 的命令行工具中包含一些必须的工具，比如`git`等。

![img](https://cdn.nlark.com/yuque/0/2019/png/206259/1565006397089-7a6e4285-8f48-4710-94dd-71a3d8bc3435.png)

## 创建新项目

使用 React Native 命令行工具来创建一个名为"AwesomeProject"的新项目：

**！！！注意！！！**：init 命令默认会创建最新的版本，而目前最新的 0.45 及以上版本需要下载 boost 等几个第三方库编译。这些库在国内即便翻墙也很难下载成功，导致很多人`无法运行iOS项目`！！！中文网在论坛中提供了这些库的[国内下载链接](http://bbs.reactnative.cn/topic/4301/)。如果你嫌麻烦，又没有对新版本的需求，那么可以暂时创建`0.44.3`的版本。

```
react-native init AwesomeProject
```

> 提示：你可以使用`--version`参数（注意是`两`个杠）创建指定版本的项目。例如`react-native init MyApp --version 0.44.3`。注意版本号必须精确到两个小数点。

如果你是想把 React Native 集成到现有的原生项目中，则步骤完全不同，请参考[集成到现有原生应用](https://reactnative.cn/docs/integration-with-existing-apps)。

## 编译并运行 React Native 应用

在你的项目目录中运行`react-native run-ios`：

```
cd AwesomeProject
react-native run-ios
```

> 提示：如果 run-ios 无法正常运行，请使用 Xcode 运行来查看具体错误（run-ios 的报错没有任何具体信息）。

很快就应该能看到 iOS 模拟器自动启动并运行你的项目。

![img](https://cdn.nlark.com/yuque/0/2019/png/206259/1565006397051-56e1d04c-a7be-456d-bca8-320b5ba28775.png)

`react-native run-ios`只是运行应用的方式之一。你也可以在 Xcode 或是[Nuclide](https://nuclide.io/)中直接运行应用。

> 如果你无法正常运行，先回头`仔细对照文档检查`，然后可以看看论坛的[求助专区](http://bbs.reactnative.cn/category/4)。

### 在真机上运行

上面的命令会自动在 iOS 模拟器上运行应用，如果你想在真机上运行，则请阅读[在设备上运行](https://reactnative.cn/docs/running-on-device)这篇文档。

### 修改项目

现在你已经成功运行了项目，我们可以开始尝试动手改一改了：

- 使用你喜欢的编辑器打开`App.js`并随便改上几行。
- 在 iOS 模拟器中按下`⌘-R`就可以刷新 APP 并看到你的最新修改！（如果没有反应，请检查模拟器的 Hardware 菜单中，connect hardware keyboard 选项是否选中开启）

### 完成了！

恭喜！你已经成功运行并修改了你的第一个 React Native 应用。