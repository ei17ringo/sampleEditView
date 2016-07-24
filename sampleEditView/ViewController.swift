//
//  ViewController.swift
//  sampleEditView
//
//  Created by Eriko Ichinohe on 2016/07/21.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var editTextView: UITextView!
    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //キーボード上部分に配置されるView
        var accessoryView = UIView(frame: CGRectMake(0, 0, myBoundsize.width, 40))
        
        let button = UIButton()
        //表示されるテキスト
        button.setTitle("Done", forState: .Normal)
        
        //テキストの色
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        
        //サイズ
        button.frame = CGRectMake(myBoundsize.width - 70, 0, 70, 40)
        
        //アクション
        button.addTarget(self, action: "Done:", forControlEvents: .TouchUpInside)
        
        accessoryView.backgroundColor = UIColor.grayColor()
        
        accessoryView.addSubview(button)
        
        editTextView.inputAccessoryView = accessoryView

        
    }
    
    func Done(sender:UIButton){
        editTextView.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillChangeFrame:",
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillHide:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyBoardValue : NSValue = userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue
            var keyBoardFrame : CGRect = keyBoardValue.CGRectValue()
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
           
            
            
            self.textViewBottom.constant = keyBoardFrame.height + 8
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
            self.textViewBottom.constant = 8
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

