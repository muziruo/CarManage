//
//  PostListTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PostListTableViewController: UITableViewController {

    let SearchUrl = "https://car.wuruoye.com/user/query_unit"
    var GetList:[QueryPostList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "单位信息"
        
    tableView.tableFooterView = UIView(frame: .zero)
        
        SVProgressHUD.show()
        let url = URL(string: SearchUrl)
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                SVProgressHUD.dismiss()
                let jsondata = JSON(data)
                let jsonarray = jsondata.arrayObject
                for item in jsonarray! {
                    let listitem = QueryPostList.init(fromDictionary: item as! [String : Any])
                    self.GetList.append(listitem)
                }
                self.tableView.reloadData()
                break
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                break
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GetList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostListTableViewCell
        if GetList[indexPath.row].id != nil {
            cell.PostNum.text = "编号：" + GetList[indexPath.row].id
        }else{
            cell.PostNum.text = "编号：" + "未知"
        }
        //为了更好的显示信息，以下两项进行交换
        if GetList[indexPath.row].name != nil {
            cell.PostName.text = "电话：" + GetList[indexPath.row].phone
        }else{
            cell.PostName.text = "电话：" + "未知"
        }
        if GetList[indexPath.row].phone != nil {
            cell.PostPhone.text = "名称：" + GetList[indexPath.row].name
        }else{
            cell.PostPhone.text = "名称：" + "未知"
        }
        return cell
    }

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
