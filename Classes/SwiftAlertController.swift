//
//  SwiftAlertController.swift
//  SwiftAlertController
//
//  Created by 张行 on 16/8/6.
//  Copyright © 2016年 张行. All rights reserved.
//

import UIKit

/// 样式(style)
enum  SwiftAlertControllerStyle{
    // 弹出框(AlertView)
    case alertView
    // 选择框(ActionSheet)
    case actionSheet
}

// 按钮的类型(The type of button)
enum SwiftAlertControllerButtonIndexType:Int {
    case cannel = 0
}

// 点击按钮的回掉(Click on the button back off)
typealias SwiftAlertControllerComplete = (alertController:SwiftAlertController) -> Void

// 管理 托管SwiftAlertController类 防止局部变量被释放(Management managed SwiftAlertController class To prevent local variables is released)
var SwiftAlertControllerMangers:[SwiftAlertController] = [SwiftAlertController]()

@available(iOS 8.0, * )
class SwiftAlertController:NSObject,UIActionSheetDelegate,UIAlertViewDelegate {

//    /// 只能内部初始化 支持iOS8之前的UIAlertView(Only internal initialized before support iOS8 UIAlertView)
//    private(set) var alertView:UIAlertView?
//    /// 只能内部初始化 支持iOS8之前的UIActionSheet(Only internal initialized before support iOS8 UIActionSheet)
//    private(set) var actionSheet:UIActionSheet?

    @available(iOS 8.0, *)
    /// 只能内部初始化 支持iOS8之后的UIAlertController(After initialization only internal support iOS8 UIAlertController)
    var alertController:UIAlertController? {
        get{
            return _alertController as? UIAlertController
        }set {
            _alertController = newValue
        }
    }
    // 为了解决高版本属性在低版本抱错的BUG 详情->https://openradar.appspot.com/22020542 (In order to solve the high version attribute in the low version error of bugs - > https://openradar.appspot.com/22020542 for details)
    private var _alertController:AnyObject?
    // 当前点击按钮的tag(The tag of the current click on the button)
    private(set) var currentClickButtonIndex:Int = 0
    // 点击的回掉(Click on the back off)
    private var clickComplete:SwiftAlertControllerComplete?
    // 储存按钮的标题(The title of the store button)
    private var buttonTitles:[String] = [String]()
    // 当前弹出的样式(The style of the current popup)
    private var alertControllerStyle:SwiftAlertControllerStyle = .alertView
    /*
     唯一的初始化方法(The only method of initialization)
     style:初始化的样式(Style: the style of the initialization)
     title:标题(Title: the title)
     message:提示语(Message: the clues)
     cannelButton:取消按钮 没有默认为Cannel(CannelButton: cancel button There is no default for the Cannel)
     otherButtons:其他按钮的数组(An array of otherButtons: other buttons)
     */
   convenience init(style:SwiftAlertControllerStyle, title:String?, message:String?, cannelButton:String? = "Cannel", otherButtons:[String]?) {
        self.init()
        self.alertControllerStyle = style
//        if #available(iOS 8.0, *) {
            // 支持8.0以上
            var _style:UIAlertControllerStyle?
            switch style {
            case .actionSheet:
                _style = UIAlertControllerStyle.ActionSheet
            case .alertView:
                _style = UIAlertControllerStyle.Alert
            }
            self.alertController = UIAlertController(title: title, message: message, preferredStyle: _style!)
            let cannelAlertAction:UIAlertAction = UIAlertAction(title: cannelButton, style: .Cancel, handler: { (action:UIAlertAction) in
                self.dismissButtonTitle(action.title)
            })
            self.alertController!.addAction(cannelAlertAction)

            if otherButtons != nil {
                for buttonTitle in otherButtons! {
                    let otherAlertAction:UIAlertAction = UIAlertAction(title: buttonTitle, style: .Default, handler: { (action:UIAlertAction) in
                        self.dismissButtonTitle(action.title)
                    })
                    self.alertController!.addAction(otherAlertAction)
                }
            }


//        }else {
//
//            switch style {
//            case .actionSheet:
//                self.actionSheet = UIActionSheet()
//                self.actionSheet!.delegate = self
//                if title != nil {
//                    self.actionSheet!.title = title!
//                }
//                self.actionSheet!.addButtonWithTitle(cannelButton!)
//                self.actionSheet!.cancelButtonIndex = 0
//                if otherButtons != nil {
//                    for buttonTitle in otherButtons! {
//                        self.actionSheet!.addButtonWithTitle(buttonTitle)
//                    }
//                }
//
//            case .alertView:
//                self.alertView = UIAlertView()
//                self.alertView?.delegate = self
//                if title != nil {
//                    self.alertView!.title = title!
//                }
//                if message != nil {
//                    self.alertView!.message = message!
//                }
//
//                self.alertView!.addButtonWithTitle(cannelButton!)
//                self.alertView!.cancelButtonIndex = 0
//                if otherButtons != nil {
//                    for buttonTitle in otherButtons! {
//                        self.alertView!.addButtonWithTitle(buttonTitle)
//                    }
//                }
//            }
//
//        }
    }
    /*
     展示弹出框(Show pop-up)
     controller:展示在哪个试图上面(Controller: show in which attempt to the above)
     complete:完成的回掉(Complete: back off)
    */
    func showAlertController(controller:UIViewController?,complete:SwiftAlertControllerComplete?){
        self.clickComplete = complete
        SwiftAlertControllerMangers.append(self)
        var showController:UIViewController? = controller
        if showController == nil {
            showController = UIApplication.sharedApplication().keyWindow?.rootViewController
        }
        assert(showController != nil, "showAlertController 之前请确保KeyWindow.rootViewController有值(Please ensure before showAlertController KeyWindow. RootViewController has value)")
//        if #available(iOS 8.0, *) {
            showController!.presentViewController(self.alertController!, animated: true, completion: nil)
//        }else {
//            switch self.alertControllerStyle {
//            case .alertView:
//                self.alertView!.show()
//            case .actionSheet:
//                self.actionSheet!.showInView(showController!.view)
//            }
//        }
    }


    //MARK:UIActionSheetDelegate
    @objc func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        actionSheet.dismissWithClickedButtonIndex(buttonIndex, animated: true)
        self.dismiss(buttonIndex)
    }

    //MARK:UIActionSheetDelegate
    @objc func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        alertView.dismissWithClickedButtonIndex(buttonIndex, animated: true)
        self.dismiss(buttonIndex)
    }

    private func dismissButtonTitle(buttonTitle:String?) {
        if buttonTitle == nil {
            return
        }
        let buttonIndex:Int? = self.buttonTitles.indexOf(buttonTitle!)
        if buttonIndex != nil {
            self.dismiss(buttonIndex!)
        }
    }

    private func dismiss(buttonIndex:Int) {
        self.currentClickButtonIndex = buttonIndex
        if self.clickComplete != nil {
            self.clickComplete!(alertController: self)
        }
        SwiftAlertControllerMangers.removeObject(self)
    }

}


extension Array where Element:Equatable {
    mutating func removeObject(object:Element)-> Int?{
        let objectIndex:Int? = self.indexOf(object)
        if objectIndex != nil {
            self.removeAtIndex(objectIndex!)
        }
        return objectIndex!
    }
}




