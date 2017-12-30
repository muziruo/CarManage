//
//  PersonCarTableViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/30.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class PersonCarTableViewController: UITableViewController {

    var PersonCar:[Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: .zero)
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
        return PersonCar.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCarCell", for: indexPath) as! PersonCarTableViewCell

        var firsttext = ""
        if PersonCar[indexPath.row].type != nil {
            firsttext = firsttext + PersonCar[indexPath.row].id + "   " + PersonCar[indexPath.row].type
        }else{
            firsttext = firsttext + PersonCar[indexPath.row].id + "   " + "未知类型"
        }
        var secondtext = ""
        if PersonCar[indexPath.row].model != nil {
            if PersonCar[indexPath.row].color != nil {
                secondtext = secondtext + PersonCar[indexPath.row].model + "   " + PersonCar[indexPath.row].color
            }else{
                secondtext = secondtext + PersonCar[indexPath.row].model + "   " + "未知颜色"
            }
        }else{
            if PersonCar[indexPath.row].color != nil {
                secondtext = secondtext + "未知车型" + "   " + PersonCar[indexPath.row].color
            }else{
                secondtext = secondtext + "未知车型" + "   " + "未知颜色"
            }
        }
        
        cell.FirstLabel.text = firsttext
        cell.SecondLabel.text = secondtext
        
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
