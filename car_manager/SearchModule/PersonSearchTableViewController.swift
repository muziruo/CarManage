//
//  PersonSearchTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/15.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  查询人员信息

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PersonSearchTableViewController: UITableViewController ,UITextFieldDelegate{

    @IBOutlet weak var PersonName: UILabel!
    @IBOutlet weak var PersonNum: UILabel!
    @IBOutlet weak var PersonCompany: UILabel!
    @IBOutlet weak var Info: UILabel!
    @IBOutlet weak var InputNum: UITextField!
    
    let SearchUrl = "https://car.wuruoye.com/user/query_staff_detail"
    
    //进行查询操作
    @IBAction func SearchActivity(_ sender: UIButton) {
        view.endEditing(true)
        
        SVProgressHUD.show()
        let userinput = InputNum.text!
        
        if userinput == "" {
            let notice = UIAlertController(title: "提示", message: "输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }else{
            let url = URL(string: SearchUrl)
            let parameter = ["id":userinput]
            Alamofire.request(url!, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                switch responsedata.result {
                case .success(let data):
                    let jsondata = JSON(data)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        SVProgressHUD.dismiss()
                        let querystaff = QueryStaff.init(fromDictionary: jsondata.dictionaryObject!)
                        self.PersonNum.text = querystaff.info.staff.id
                        self.PersonName.text = querystaff.info.staff.name
                        self.PersonCompany.text = querystaff.info.unit.name
                        if querystaff.info.car.count == 0 {
                            self.Info.text = "该人员无车辆"
                        }else{
                            self.Info.text = querystaff.info.car[0].id
                        }
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
                    let notice = UIAlertController(title: "警告", message: "网络请求出错", preferredStyle: .alert)
                    let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    notice.addAction(noticeaction)
                    self.present(notice, animated: true, completion: nil)
                    break
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        PersonNum.text = "无"
        PersonName.text = "无"
        PersonCompany.text = "无"
        Info.text = "无"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //点击输入框其他区域输入停止
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
