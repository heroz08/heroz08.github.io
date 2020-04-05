---
title: mac去除系统更新小红点
date: 2020-04-05 16:18:36
tags: ['mac', '小红点', '更新']
---

### 屏蔽和去除mac系统的设置图标的系统更新提示小红点!
  - 先设置取消系统自动更新
  - 打开终端运行:
```shell
  defaults write com.apple.systempreferences AttentionPrefBundleIDs 0
```
  - 一般就会解决如果没有解决可以试试以下操作:
```shell
  killall Dock
```


