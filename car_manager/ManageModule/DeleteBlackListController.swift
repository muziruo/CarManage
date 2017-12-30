//
//  DeleteBlackListController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class DeleteBlackListController: UITableViewController {
    
    @IBOutlet var textfield: UITextField!
    
    let DeteleUrl = "https://car.wuruoye.com/car/delete_no_car"
    
    @IBAction func remove(){
        view.endEditing(true)
        SVProgressHUD.show()
        
        let deleteid = textfield.text!
        let url = URL(string: DeteleUrl)
        
        if deleteid != "" {
            if deleteid.characters.count <= 8 {
                let parameter = ["car":deleteid]
                
                Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    switch responsedata.result {
                    case .success(let data):
                        SVProgressHUD.dismiss()
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        if issuccess {
                            let successdata = jsondata.dictionaryObject?["info"] as! String
                            self.shownotice(info: successdata)
                            self.textfield.text = ""
                        }else{
                            let errordata = jsondata.dictionaryObject?["info"] as! String
                            self.shownotice(info: errordata)
                        }
                        break
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        print(error.localizedDescription)
                        self.shownotice(info: "网络请求出错")
                        break
                    }
                })
            }else{
                SVProgressHUD.dismiss()
                shownotice(info: "车辆编号最多8位")
            }
        }else{
            SVProgressHUD.dismiss()
            shownotice(info: "输入不能为空")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        title = "移除黑名单"
        textfield.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shownotice(info:String) {
        let notice = UIAlertController(title: "提示", message: info, preferredStyle: .alert)
        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
        notice.addAction(noticeaction)
        present(notice, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
