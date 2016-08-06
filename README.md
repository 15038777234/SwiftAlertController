# SwiftAlertController
This is the Swift support UIAlertView and UIAlertController version of third-party libraries(这是支持UIAlertView和UIAlertController 的Swift 版本的第三方库)

支持 Cocoapods(Support Cocoapods)
```swift
pod 'SwiftAlertController'
```

使用(use)

```swift
var alertStyle = SwiftAlertControllerStyle.alertView
// 设置为actionSheet
alertStyle = SwiftAlertControllerStyle.actionSheet
let alert:SwiftAlertController = SwiftAlertController(style: alertStyle, title: nil, message: "alert", otherButtons: ["Other"])
 alert.showAlertController(self, complete: nil)
```

备注:因为Cocoapods 推送里面的API必须在IOS8以上 所以改成了IOS8以上 如果想要支持IOS8之前的请下载[relase1.0.0](https://github.com/15038777234/SwiftAlertController/releases/tag/1.0.0)版本

Note: because Cocoapods push the API must be above IOS8 inside So changed to IOS8 above If you want to support before IOS8 relase1.0.0 version, please download
