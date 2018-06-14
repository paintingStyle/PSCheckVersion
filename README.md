# PSCheckVersion
支持App一键更新，并附带UI可直接使用

## Requirements 要求
* iOS 8+
* Xcode 8+

## Installation 安装
### 1.手动安装:
`下载Demo后,将子文件夹PSCheckVersion拖入到项目中, 导入头文件PSCheckVersion.h开始使用,注意: 项目中需要有Masonry.1.1.0!`
### 2.CocoaPods安装:
`pod 'PSCheckVersion'`
如果发现pod search PPNetworkHelper 不是最新版本，可在终端执行 pod repo update 更新本地仓库，更新完成重新搜索即可。

## Usage 使用方法

## 使用方法

导入头文件 #import "PSCheckVersion.h"

### 1.1 检测版本更新,自带UI
```objc
[PSCheckVersion checkVersion];
```
### 1.2 检测版本更新,自带UI（强制更新）
```objc
[PSCheckVersion checkVersionCompulsoryUpdate];
```
### 1.3 检测版本更新,需要自定义UI
```objc
[PSCheckVersion checkVersionCompleteBlock:^(PSAppInfo *info, NSError *error) {

}];
```

## 更新日志
```
• 2018.06.14(tag:0.1.0): 提交0.1.0版本
```
