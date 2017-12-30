//
//  RecordingController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SVProgressHUD

class RecordingController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var location = "余区"
    var current = "添加出校记录"
    @IBOutlet var tableView: UITableView!
    var num = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return num
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recording", for: indexPath) as! RecordingCell

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if current == "添加出校记录" {
            let action = UITableViewRowAction(style: .default, title: "出校") { (action, indexPath) in
                self.num = self.num - 1
                
                //发起出校网络请求
                let gateno = Int(arc4random()%11)+1    //随机生成出校门口号
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            action.backgroundColor = UIColor.green
            return [action]
        }else{
            let action = UITableViewRowAction(style: .default, title: "违章", handler: { (action, indexPath) in
                
                //发起违章网络请求
                SVProgressHUD.showInfo(withStatus: "添加违章成功")
                SVProgressHUD.dismiss(withDelay: 0.5)
            })
            action.backgroundColor = UIColor.red
            return [action]
        }
    }

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            num = num - 1
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    

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
