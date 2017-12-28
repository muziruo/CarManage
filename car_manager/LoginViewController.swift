//
//  LoginViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/8.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  登录页面

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    //登录操作
    @IBAction func LoginActivity(_ sender: UIButton) {
        //调试用，正式版请删除
        let nameinput:String = "20170001"
        let passwordinput:String = "342188"
        /*
        let nameinput:String = UserName.text!
        let passwordinput:String = UserPassword.text!
        */
        
        if nameinput == "" || passwordinput == "" {
            let notice = UIAlertController(title: "警告", message: "账号或密码不能为空!", preferredStyle: .alert)
            let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeactivity)
            self.present(notice, animated: true, completion: nil)
        }else{
            SVProgressHUD.show()
            
            //进行网络请求，检查密码和账号的正确性
            let url = URL(string: "https://car.wuruoye.com/user/login_user")!
            let parameters = ["id":nameinput,"password":passwordinput]
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                if responsedata.result.isSuccess {
                    let jsondata = JSON.init(data: responsedata.data!)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
                    }else{
                        SVProgressHUD.dismiss()
                        let jsonstr = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: jsonstr, preferredStyle: .alert)
                        let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeactivity)
                        self.present(notice, animated: true, completion: nil)
                    }
                }else{
                    SVProgressHUD.dismiss()
                    let notice = UIAlertController(title: "提示", message: "网络请求错误", preferredStyle: .alert)
                    let noticeactivity = UIAlertAction(title: "确定", style: .default, handler: nil)
                    notice.addAction(noticeactivity)
                    self.present(notice, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LoginButton.layer.borderColor = UIColor.blue.cgColor
        LoginButton.layer.borderWidth = 1.5
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
