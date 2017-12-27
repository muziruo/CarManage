//
//  SearchMenuViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/11.
//  Copyright © 2017年 李祎喆. All rights reserved.
//  查询菜单

import UIKit

class SearchMenuViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    @IBOutlet weak var SearchTableView: UITableView!
    
    let functionmenu:[String] = ["人员信息查询","车辆信息查询"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SearchTableView.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionmenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuTableViewCell
        cell.textLabel?.text = functionmenu[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir-Light", size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "GoToPersonSearch", sender: nil)
        case 1:
            performSegue(withIdentifier: "GoToCarSearch", sender: nil)
        default:
            print("进入车辆管理系统")
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
