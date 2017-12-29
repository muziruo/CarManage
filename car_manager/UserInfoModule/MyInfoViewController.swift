//
//  MyInfoViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/27.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MyInfoViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserNum: UILabel!
    @IBOutlet weak var UserPost: UILabel!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var FunctionTable: UITableView!
    
    let functionlist = [["开发者网站"],["使用反馈"],["电话本"]]
    let ImageUrl = "https://car.wuruoye.com/user/photo/unit/"
    let SearchUrl = "https://car.wuruoye.com/user/query_staff_detail"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LogoutButton.layer.borderColor = UIColor.red.cgColor
        LogoutButton.layer.borderWidth = 1.5
        
        FunctionTable.tableFooterView = UIView(frame: .zero)
        
        let userinfo = UserDefaults.standard
        let imagename = userinfo.value(forKey: "userid") as! String
        let imageurltext = ImageUrl + imagename + ".jpg"
        let imageurl = URL(string: imageurltext)
        
        let session = URLSession.shared
        let datadask = session.dataTask(with: imageurl!, completionHandler: { (dataimg, respone, error) in
            let imagedata = UIImage(data: dataimg!)
            //得到图片之后在主线程中更新UI
            OperationQueue.main.addOperation {
                self.UserImage.image = imagedata
            }
        }) as URLSessionTask
        datadask.resume()
        
        searchuser()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchuser() {
        let userinfo = UserDefaults.standard
        let userid = userinfo.value(forKey: "userid") as! String
        
        let url = URL(string: SearchUrl)
        let parameter = ["id":userid]
        Alamofire.request(url!, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                let jsondata = JSON(data)
                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                if issuccess {
                    SVProgressHUD.dismiss()
                    let querystaff = QueryStaff.init(fromDictionary: jsondata.dictionaryObject!)
                    self.UserName.text = querystaff.info.staff.name + " "
                    self.UserNum.text = querystaff.info.staff.id
                    self.UserPost.text = querystaff.info.unit.name
                }else{
                    SVProgressHUD.dismiss()
                    let errordata = jsondata.dictionaryObject?["info"] as! String
                    let notice = UIAlertController(title: "提示", message: errordata, preferredStyle: .alert)
                    let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    notice.addAction(noticeaction)
                    self.present(notice, animated: true, completion: nil)
                }
                break
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                let notice = UIAlertController(title: "提示", message: "网络请求出错", preferredStyle: .alert)
                let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeaction)
                self.present(notice, animated: true, completion: nil)
                break
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FunctionCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Avenir-Light", size: 15)
        cell.textLabel?.text = functionlist[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            performSegue(withIdentifier: "GoToPostList", sender: nil)
            break
        default:
            break
        }
        FunctionTable.deselectRow(at: indexPath, animated: true)
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
