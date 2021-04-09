---
title: react-native-ios保存图片到相册
date: 2019-11-23 10:41:17
tags: [ios, react-native, 保存到相册]
---

1. 现在CameraRoll 已经独立到一个库中了,需要单独安装:



```js
npm install @react-native-community/cameraroll --save
```

- react-native 目前已经可以自动link 一般不需要再手动link

- 如果此时不行的化,需要pod install 一下:



```shell
cd ios
pod install
```

2. xcode 需要设置下权限, 在info.plist 里面通过➕按钮添加一个键

![图片.png](https://cdn.nlark.com/yuque/0/2019/png/206259/1569742057752-d6a70aba-815c-45b1-bbcf-f9f3c4a1d9ed.png)



3. 选择 Privacy - Photo Library Additions Usage Description

![图片.png](https://cdn.nlark.com/yuque/0/2019/png/206259/1569742149363-9275c09a-b7aa-445b-83ea-80e11ab2c160.png)

4. 重启项目