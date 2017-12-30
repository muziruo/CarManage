//
//  AddUserTableViewController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/22.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class AddUserTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource ,UITextFieldDelegate{

    var currentType = "user"

    var titles = ["staff":[],
                  "user":["用户编号（职工号）","密码","权限"],
                  "post":["编号","名称","电话"],
                  "car":["车牌号","类型","车辆型号","颜色","座位数"],
                  "passcard":["车牌号","类型","开始时间","结束时间","费用","车主"],
                  "blacklist":["车牌号"]]
    var pickViewItem = ["user":["普通用户","管理员"],
                        "car":["小型车","大型车"],
                        "passcard":["校车","教职工车","社会车"]]
    let AddBlackListUrl = "https://car.wuruoye.com/car/add_no_car"
    let AddPostUrl = "https://car.wuruoye.com/user/add_unit"
    let AddUserUrl = "https://car.wuruoye.com/user/add_user"
    let AddCarUrl = "https://car.wuruoye.com/car/add_car"
    let AddPassUrl = "https://car.wuruoye.com/car/add_pass"
    
    var pickerView = UIPickerView()
    var datePickerView = UIDatePicker()
    let toolBar = UIToolbar()
    
    var StartDate:Date!
    var EndDate:Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.separatorStyle = .none
        
        switch currentType {
        case "user":
            title = "添加用户"
            break
        case "staff":
            title = "添加教职工"
            break
        case "car":
            title = "添加车辆"
            break
        case "passcard":
            title = "添加通行证"
            break
        case "blacklist":
            title = "添加黑名单"
            break
        case "post":
            title = "添加单位"
            break
        default:
            break
        }
        
        
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale(identifier: "Chinese")
        datePickerView.addTarget(self, action: #selector(chooseDate), for: .valueChanged)
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
    }
    
    func back() {
        for i in 1...3 {
            view.viewWithTag(i)?.resignFirstResponder()
        }
    }
    
    @IBAction func AddInfo(_ sender: Any) {
        SVProgressHUD.show()
        view.endEditing(true)
        switch currentType {
        case "user":
            AddUserInfo()
            break
        case "post":
            AddPostInfo()
            break
        case "car":
            AddCarInfo()
            break
        case "passcard":
            AddPassCard()
            break
        case "blacklist":
            AddBlackList()
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AddPassCard() {
        let carnumtextfield = view.viewWithTag(101) as! UITextField
        let cartypetextfield = view.viewWithTag(1) as! UITextField
        let startdatetextfield = view.viewWithTag(2) as! UITextField
        let enddatetextfield = view.viewWithTag(3) as! UITextField
        let feetextfield = view.viewWithTag(105) as! UITextField
        let ownertextfield = view.viewWithTag(106) as! UITextField
        let carnum = carnumtextfield.text!
        var cartype = cartypetextfield.text!
        let startdate = startdatetextfield.text!
        let enddate = enddatetextfield.text!
        let fee = feetextfield.text!
        let owner = ownertextfield.text!
        
        let isnum = isPurnInt(string: fee)
        if carnum != "" && cartype != "" && startdate != "" && enddate != "" && fee != "" && owner != "" {
            if isnum {
                if carnum.characters.count <= 8 {
                    var starttime = Int(StartDate.timeIntervalSince1970)
                    starttime *= 1000
                    print(starttime)
                    var endtime = Int(EndDate.timeIntervalSince1970)
                    endtime *= 1000
                    print(endtime)
                    let feenum = Float(fee)!
                    switch cartype {
                    case "校车":
                        cartype = "1"
                        break
                    case "教职工车":
                        cartype = "2"
                        break
                    case "社会车":
                        cartype = "3"
                        break
                    default:
                        cartype = "0"
                        break
                    }
                    
                    let url = URL(string: AddPassUrl)
                    let parameter = ["car":carnum,"type":cartype,"from":starttime,"to":endtime,"fee":feenum,"owner":owner] as [String : Any]
                    
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
                    let notice = UIAlertController(title: "提示", message: "车辆编号不能超过8位", preferredStyle: .alert)
                    let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    notice.addAction(noticeaction)
                    self.present(notice, animated: true, completion: nil)
                }
            }else{
                SVProgressHUD.dismiss()
                let notice = UIAlertController(title: "提示", message: "输入不能为空", preferredStyle: .alert)
                let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeaction)
                self.present(notice, animated: true, completion: nil)
            }
        }else{
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "提示", message: "输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }
    }
    
    func AddCarInfo() {
        let carnumtextfield = view.viewWithTag(101) as! UITextField
        let cartypetextfield = view.viewWithTag(1) as! UITextField
        let carmodeltextfield = view.viewWithTag(103) as! UITextField
        let carcolortextfield = view.viewWithTag(104) as! UITextField
        let carseatstextfield = view.viewWithTag(105) as! UITextField
        let carnum = carnumtextfield.text!
        var cartype = "0"
        switch cartypetextfield.text! {
        case "小型车":
            cartype = "1"
            break
        case "大型车":
            cartype = "2"
            break
        default:
            break
        }
        let carmodel = carmodeltextfield.text!
        let carcolor = carcolortextfield.text!
        let carseats = carseatstextfield.text!
        let seatnum = Int(carseats)!
        
        
        if carnum != "" && cartype != "" && carmodel != "" && carcolor != "" && carseats != "" {
            let url = URL(string: AddCarUrl)
            let parameter = ["id":carnum,"type":cartype,"model":carmodel,"color":carcolor,"seat":seatnum] as [String : Any]
            
            Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                switch responsedata.result {
                case .success(let data):
                    let jsondata = JSON(data)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        SVProgressHUD.dismiss()
                        let successdata = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
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
                    print("网络请求出错：\(error)")
                    break
                }
            })
        }else{
            let notice = UIAlertController(title: "提示", message: "输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }
    }
    
    //添加用户
    func AddUserInfo() {
        let usernumtextfield = view.viewWithTag(101) as! UITextField
        let userpasswordtextfield = view.viewWithTag(102) as! UITextField
        let usertypetextfield = view.viewWithTag(1) as! UITextField
        let usernum = usernumtextfield.text!
        let userpassword = userpasswordtextfield.text!
        let usertype = usertypetextfield.text!
        
        if usernum != "" && userpassword != "" && usertype != "" {
            let url = URL(string: AddUserUrl)
            let parmeters = ["id":usernum,"password":userpassword,"type":usertype]
            
            Alamofire.request(url!, method: .post, parameters: parmeters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                switch responsedata.result {
                case .success(let data):
                    let jsondata = JSON(data)
                    let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                    if issuccess {
                        SVProgressHUD.dismiss()
                        let successdata = jsondata.dictionaryObject?["info"] as! String
                        let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        notice.addAction(noticeaction)
                        self.present(notice, animated: true, completion: nil)
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
                    print("网络请求出错：\(error)")
                    break
                }
            })
        }
    }
    
    //添加单位
    func AddPostInfo() {
        let postnumtextfield = view.viewWithTag(101) as! UITextField
        let postnametextfield = view.viewWithTag(102) as! UITextField
        let postphonetextfield = view.viewWithTag(103) as! UITextField
        
        let postnum = postnumtextfield.text!
        let postname = postnametextfield.text!
        let postphone = postphonetextfield.text!
        if postphone != "" && postnum != "" && postname != "" {
            if postphone.characters.count != 11 {
                SVProgressHUD.dismiss()
                let notice = UIAlertController(title: "警告", message: "请输入正确的电话号码格式", preferredStyle: .alert)
                let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeaction)
                self.present(notice, animated: true, completion: nil)
            }else{
                let url = URL(string: AddPostUrl)
                let parmeters = ["id":postnum,"name":postname,"phone":postphone]
                
                Alamofire.request(url!, method: .post, parameters: parmeters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    switch responsedata.result {
                    case .success(let data):
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        if issuccess {
                            SVProgressHUD.dismiss()
                            let successdata = jsondata.dictionaryObject?["info"] as! String
                            let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                            notice.addAction(noticeaction)
                            self.present(notice, animated: true, completion: nil)
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
                        print("网络请求出错：\(error)")
                        break
                    }
                })
            }
        }else{
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "警告", message: "输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }
    }
    
    //添加黑名单
    func AddBlackList() {
        let carnumtextfield = view.viewWithTag(101) as! UITextField
        let carnum = carnumtextfield.text!
        
        if carnum != "" {
            if carnum.characters.count <= 8 {
                let url = URL(string: AddBlackListUrl)
                let prameters = ["car":carnum]
                Alamofire.request(url!, method: .post, parameters: prameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                    switch responsedata.result {
                    case .success(let data):
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        if issuccess {
                            SVProgressHUD.dismiss()
                            let successdata = jsondata.dictionaryObject?["info"] as! String
                            let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                            notice.addAction(noticeaction)
                            self.present(notice, animated: true, completion: nil)
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
                        print("网络请求出错：\(error)")
                        break
                    }
                })
            }else{
                SVProgressHUD.dismiss()
                let notice = UIAlertController(title: "提示", message: "车辆编号应小于8位", preferredStyle: .alert)
                let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                notice.addAction(noticeaction)
                self.present(notice, animated: true, completion: nil)
            }
        }else{
            SVProgressHUD.dismiss()
            let notice = UIAlertController(title: "提示", message: "车辆编号输入不能为空", preferredStyle: .alert)
            let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
            notice.addAction(noticeaction)
            self.present(notice, animated: true, completion: nil)
        }
    }
    
    /*
    func NetworkRequest(parameter:Parameters,url:URL) {
        Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseString(completionHandler: { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                let jsondata = JSON(data)
                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                if issuccess {
                    SVProgressHUD.dismiss()
                    let successdata = jsondata.dictionaryObject?["info"] as! String
                    let notice = UIAlertController(title: "提示", message: successdata, preferredStyle: .alert)
                    let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    notice.addAction(noticeaction)
                    self.present(notice, animated: true, completion: nil)
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
                print("网络请求出错：\(error)")
                break
            }
        })
    }
    */
    
    func goback() {
        performSegue(withIdentifier: "goback", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
        return titles[currentType]!.count
        }else{
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddButtonCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basisCell", for: indexPath) as! BasisCell
        
        let tagnum = 101 + indexPath.row
        
        switch currentType {
        case "user":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            if indexPath.row == 2{
                cell.textField.placeholder = "请选择权限"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
                cell.textField.inputAccessoryView = toolBar
            }else{
                cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
                cell.textField.tag = tagnum
            }
        case "car":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            if indexPath.row == 1{
                cell.textField.placeholder = "请选择类型"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
                cell.textField.inputAccessoryView = toolBar
            }else{
                cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
                cell.textField.tag = tagnum
            }
        case "passcard":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            switch indexPath.row{
            case 1:
                cell.textField.placeholder = "请选择类型"
                cell.textField.tag = 1
                pickerView.translatesAutoresizingMaskIntoConstraints = true
                pickerView.delegate = self
                pickerView.dataSource = self
                cell.textField.inputView = pickerView
                cell.textField.inputAccessoryView = toolBar
            case 2:
                cell.textField.placeholder = "请选择通行证开始日期"
                cell.textField.tag = 2
                datePickerView.translatesAutoresizingMaskIntoConstraints = true
                cell.textField.inputView = datePickerView
                cell.textField.inputAccessoryView = toolBar
            case 3:
                cell.textField.placeholder = "请选择通行证结束日期"
                cell.textField.tag = 3
                datePickerView.translatesAutoresizingMaskIntoConstraints = true
                cell.textField.inputView = datePickerView
                cell.textField.inputAccessoryView = toolBar
            default:
                cell.textField.tag = tagnum
                break
            }
        case "post":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
            cell.textField.tag = tagnum
            break
        case "blacklist":
            cell.titleLable.text = titles[currentType]![indexPath.row]
            cell.textField.placeholder = "请输入"+titles[currentType]![indexPath.row]
            cell.textField.tag = tagnum
            break
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let label = view.viewWithTag(1) as! UITextField
        label.text = pickViewItem[currentType]![row]
    }
    
    func chooseDate() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = " YYYY-MM-dd"
        if (view.viewWithTag(2)?.isFirstResponder)!{
            let label = view.viewWithTag(2) as! UITextField
            label.text = dateformatter.string(from: datePickerView.date)
            StartDate = datePickerView.date
        }else{
            let label = view.viewWithTag(3) as! UITextField
            label.text = dateformatter.string(from: datePickerView.date)
            EndDate = datePickerView.date
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewItem[currentType]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewItem[currentType]![row]
    }
    
    //点击输入框之外的地方停止输入
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //判断输入是否为数字
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
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
