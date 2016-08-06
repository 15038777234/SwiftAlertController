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
