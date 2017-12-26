//
//  UserInfoViewController.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/26.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    
    let functionlist = [["开发者官网"],["使用反馈"],["电话本"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
        //self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myinfo", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Avenir-Light", size: 15)
        cell.textLabel?.text = functionlist[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
