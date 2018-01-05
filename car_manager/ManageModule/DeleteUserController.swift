//
//  DeleteUserController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/28.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class DeleteUserController: UITableViewController {
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var partLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet weak var UserInput: UITextField!
    
    @IBOutlet var deleteButton: UIButton!
    
    var currntType = "deleteUser"
    let SearchUrl = "https://car.wuruoye.com/user/query_staff_detail"
    let DeleteUrl = "https://car.wuruoye.com/user/delete_user"
    var issearch:Bool = false
    var Deleteid:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        switch currntType{
        case "deleteUser":
            title = "删除用户"
            infoLabel.text = "用户信息"
            break
        case "deleteStaff":
            title = "删除教职工"
            infoLabel.text = "教职工信息"
            break
        default:
            break
        }
        
        deleteButton.layer.cornerRadius = 20
        deleteButton.tintColor = UIColor.red
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.layer.borderWidth = 1.5
        deleteButton.clipsToBounds = true
        
        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func query(){
        view.endEditing(true)
        SVProgressHUD.show()
        let userinput = UserInput.text!
        
        if userinput == "" {
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "提示", message: "输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self
            .present(notice, animated: true, completion: nil)
        }else{
            SVProgressHUD.dismiss()
            let url = URL(string: SearchUrl)
            let parameter = ["id":userinput]
            
            Alamofire.request(url!, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                switch responsedata.result {
                case .success(let data):
                    SVProgressHUD.dismiss()
                    let jsondata = JSON(data)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        self.issearch = true
                        self.Deleteid = userinput
                        let queryuser = QueryStaff.init(fromDictionary: jsondata.dictionaryObject!)
                        self.nameLabel.text = queryuser.info.staff.name
                        self.idLabel.text = queryuser.info.staff.id
                        self.partLabel.text = queryuser.info.unit.name
                    }else{
                        let errordata = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: errordata, preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
                        break
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
            })
        }
    }
    
    @IBAction func delete(){
        view.endEditing(true)
        SVProgressHUD.show()
        if issearch {
            let detelepeople = UserInput.text!
            let url = URL(string: DeleteUrl)
            let parameter = ["id":detelepeople]
            
            Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                switch responsedata.result {
                case .success(let data):
                    SVProgressHUD.dismiss()
                    let jsondata = JSON(data)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        let successdata = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
                    }else{
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
            })
        }else{
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "提示", message: "请先进行查询确认信息后再进行删除", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }
    }

    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
