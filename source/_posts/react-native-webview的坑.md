---
title: react-native webview的坑及(RNCWKWebView" was not found in the UIManager)错误
date: 2019-09-08 10:47:27
tags: [react-native, webview, RNCWKWebView" was not found in the UIManager]
---

首先 webview已经从 react-native 移到单独模块 react-native-webview;

### 使用:

1. 安装 yarn add react-native-webview;
2. 运行 react-native link react-native-webview(native0.6以后会自动link 不知道可不可以 )

### 如果报错:

> ```
> Invariant Violation: requireNativeComponent: "RNCWKWebView" was not found in the UIManager.
> ```

1. cd  ios
2. 运行 pod install
3. 重新运行 react-native run-ios

