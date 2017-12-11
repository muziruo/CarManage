//
//  LoginViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/8.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  登录页面

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    //登录操作
    @IBAction func LoginActivity(_ sender: UIButton) {
        let nameinput:String = UserName.text!
        let passwordinput:String = UserPassword.text!
        
        if nameinput == "" || passwordinput == "" {
            let notice = UIAlertController(title: "警告", message: "账号或密码不能为空!", preferredStyle: .alert)
            let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeactivity)
            self.present(notice, animated: true, completion: nil)
        }else{
            SVProgressHUD.show()
            /*
             登录操作
            */
            SVProgressHUD.dismiss()
            performSegue(withIdentifier: "LoginSuccess", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LoginButton.layer.borderColor = UIColor.blue.cgColor
        LoginButton.layer.borderWidth = 1.5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //点击输入框外部隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
