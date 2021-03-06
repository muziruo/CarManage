//
//  AddStaffTableViewController.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/26.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class AddStaffTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,
UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var haveCarSwitch: UISwitch!
    @IBOutlet var button: UIButton!
    
    //教职工信息textfield
    @IBOutlet var nameTextfiled: UITextField!
    @IBOutlet var partTextfield: UITextField!
    @IBOutlet var idTextfield: UITextField!
    @IBOutlet var phoneTextfield: UITextField!
    //车辆信息textfield
    @IBOutlet var carIdTextfield: UITextField!
    @IBOutlet var carTypeTextfield: UITextField!
    @IBOutlet var carModelTextfield: UITextField!
    @IBOutlet var carColorTextfield: UITextField!
    @IBOutlet var carSeatTextfield: UITextField!
    
    var pickerView = UIPickerView()
    
    let carinfo = ["车牌号","类型","车辆型号","颜色","座位数"]
    let cartype = ["小型车","大型车"]
    var isselect:Bool = false
    
    let AddStaffUrl = "https://car.wuruoye.com/user/add_staff"
    let AddImageUrl = "https://car.wuruoye.com/user/upload_photo"
    let AddCarUrl = "https://car.wuruoye.com/car/add_car"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        haveCarSwitch.addTarget(self, action: #selector(reload), for: .valueChanged)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = true
        carTypeTextfield.inputView = pickerView
        
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.blue
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.5
        button.clipsToBounds = true
 
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        carTypeTextfield.inputView = pickerView
        carTypeTextfield.inputAccessoryView = toolBar
        
        haveCarSwitch.isOn = false
    }
    
    func back() {
        carTypeTextfield.resignFirstResponder()
    }
    
    func done() {
        carTypeTextfield.text = cartype[pickerView.selectedRow(inComponent: 0)]
        carTypeTextfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if haveCarSwitch.isOn {
            return 2
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    
    @IBAction func selectPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage]
        photoView.image = photo as? UIImage
        photoView.clipsToBounds = true
        isselect = true
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func AddStaff(_ sender: Any) {
        view.endEditing(true)
        
        SVProgressHUD.show()
        let staffname = nameTextfiled.text!
        let staffpost = partTextfield.text!
        let staffnum = idTextfield.text!
        let staffphone = phoneTextfield.text!
        if haveCarSwitch.isOn {
            let carid = carIdTextfield.text!
            let cartype = carTypeTextfield.text!
            let carmodel = carModelTextfield.text!
            let carcolor = carColorTextfield.text!
            let carseat = carSeatTextfield.text!
            if staffnum != "" && staffname != "" && staffpost != "" && carid != "" && cartype != "" && carmodel != "" && carcolor != "" && carseat != "" && staffphone != "" {
                if isselect {
                    if carid.characters.count <= 8 {
                        if staffphone.characters.count == 11 {
                            self.uploadimage(more: true)
                            /*
                            if imagesuccess {
                                var staffuploadsuccess = false
                                staffuploadsuccess = addstaffinfo(name: staffname, id: staffnum, post: staffpost, phone: staffphone)
                                /*
                                let url = URL(string: AddStaffUrl)
                                let parameter = ["id":staffnum,"name":staffname,"unit":staffpost,"phone":"15908665907"]
                                var errordata = ""
                                
                                Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                                    switch responsedata.result {
                                    case .success(let data):
                                        let jsondata = JSON(data)
                                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                                        if issuccess {
                                            staffuploadsuccess = true
                                        }else{
                                            staffuploadsuccess = false
                                            errordata = jsondata.dictionaryObject?["info"] as! String
                                        }
                                        break
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        staffuploadsuccess = false
                                        errordata = "上传职工信息网络请求出错"
                                        break
                                    }
                                })
                                */
                                
                                if staffuploadsuccess {
                                    addcarinfo(id: carid, type: cartype, model: carmodel, color: carcolor, seat: carseat)
                                    phoneTextfield.text = ""
                                    idTextfield.text = ""
                                    nameTextfiled.text = ""
                                    partTextfield.text = ""
                                    carIdTextfield.text = ""
                                    carSeatTextfield.text = ""
                                    carColorTextfield.text = ""
                                    carModelTextfield.text = ""
                                    carTypeTextfield.text = ""
                                    /*
                                    let carurl = URL(string: AddCarUrl)
                                    let carparameter = ["id":carid,"type":cartype,"model":carmodel,"color":carcolor,"seat":carseat]
                                    
                                    Alamofire.request(carurl!, method: .post, parameters: carparameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                                        switch responsedata.result {
                                        case .success(let data):
                                            let jsondata = JSON(data)
                                            let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                                            if issuccess {
                                                SVProgressHUD.dismiss()
                                                self.shownotice(info: "上传成功")
                                            }else{
                                                SVProgressHUD.dismiss()
                                                let errordata = jsondata.dictionaryObject?["info"] as! String
                                                self.shownotice(info: errordata)
                                            }
                                            break
                                        case .failure(let error):
                                            SVProgressHUD.dismiss()
                                            print(error.localizedDescription)
                                            self.shownotice(info: "网络请求失败,图片和教职工信息已添加，请额外进行车辆添加")
                                            break
                                        }
                                    })
                                    */
                                }else{
                                    phoneTextfield.text = ""
                                    idTextfield.text = ""
                                    nameTextfiled.text = ""
                                    partTextfield.text = ""
                                    SVProgressHUD.dismiss()
                                }
                            }else{
                                SVProgressHUD.dismiss()
                                shownotice(info: "图片上传失败")
                            }
                            */
                        }else{
                            SVProgressHUD.dismiss()
                            shownotice(info: "请输入正确格式的电话号码")
                        }
                    }else{
                        SVProgressHUD.dismiss()
                        shownotice(info: "车辆编号应小于8位")
                    }
                }else{
                    SVProgressHUD.dismiss()
                    shownotice(info: "请选择图片")
                }
            }else{
                SVProgressHUD.dismiss()
                shownotice(info: "输入不能为空")
            }
        }else{
            if staffnum != "" && staffname != "" && staffpost != "" && staffphone != "" {
                if isselect {
                    self.uploadimage(more: false)
                    //let imagesuccess:Bool = self.uploadimage()
                    /*
                    if imagesuccess {
                        let staffsuccess = addstaffinfo(name: staffname, id: staffnum, post: staffpost, phone: staffphone)
                        if staffsuccess {
                            SVProgressHUD.dismiss()
                            shownotice(info: "上传完成")
                        }else{
                            SVProgressHUD.dismiss()
                        }
                        
                        /*
                        let url = URL(string: AddStaffUrl)
                        let parameter = ["id":staffnum,"name":staffname,"unit":staffpost,"phone":"15908665907"]
                        
                        Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
                            switch responsedata.result {
                            case .success(let data):
                                let jsondata = JSON(data)
                                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                                if issuccess {
                                    SVProgressHUD.dismiss()
                                    var successdata = jsondata.dictionaryObject?["info"] as! String
                                    successdata += ",图片上传成功"
                                    self.shownotice(info: successdata)
                                }else{
                                    SVProgressHUD.dismiss()
                                    var errordata = jsondata.dictionaryObject?["info"] as! String
                                    errordata += ",图片上传成功"
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
                        */
                    }else{
                        SVProgressHUD.dismiss()
                        shownotice(info: "图片上传失败")
                    }
                    */
                }else{
                    SVProgressHUD.dismiss()
                    shownotice(info: "请选择图片")
                }
            }else{
                SVProgressHUD.dismiss()
                shownotice(info: "输入不能为空")
            }
            
        }
    }
    
    func addstaffinfo(more:Bool) {
        let staffname = nameTextfiled.text!
        let staffpost = partTextfield.text!
        let staffnum = idTextfield.text!
        let staffphone = phoneTextfield.text!
        
        var success = false
        let url = URL(string: AddStaffUrl)
        let parameter = ["id":staffnum,"name":staffname,"unit":staffpost,"phone":staffphone]
        
        Alamofire.request(url!, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                let jsondata = JSON(data)
                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                if issuccess {
                    success = true
                    if more {
                        self.addcarinfo()
                    }else{
                        SVProgressHUD.dismiss()
                        self.shownotice(info: "图片，教职工信息上传成功")
                    }
                }else{
                    SVProgressHUD.dismiss()
                    success = false
                    let errordata = jsondata.dictionaryObject?["info"] as! String
                    self.shownotice(info: errordata)
                }
                break
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                success = false
                let errordata = "，图片上传成功，上传职工信息网络请求出错"
                self.shownotice(info: errordata)
                break
            }
        })
    }
    
    func addcarinfo() {
        let carid = carIdTextfield.text!
        let cartype = carTypeTextfield.text!
        let carmodel = carModelTextfield.text!
        let carcolor = carColorTextfield.text!
        let carseat = carSeatTextfield.text!
        let carurl = URL(string: AddCarUrl)
        
        var cartypenum = "1"
        switch cartype {
        case "小型车":
            cartypenum = "1"
            break
        case "大型车":
            cartypenum = "2"
            break
        default:
            break
        }
        
        let carparameter = ["id":carid,"type":cartypenum,"model":carmodel,"color":carcolor,"seat":carseat]
        
        Alamofire.request(carurl!, method: .post, parameters: carparameter, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                let jsondata = JSON(data)
                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                if issuccess {
                    SVProgressHUD.dismiss()
                    self.shownotice(info: "图片，教职工，车辆信息上传成功")
                }else{
                    SVProgressHUD.dismiss()
                    var errordata = jsondata.dictionaryObject?["info"] as! String
                    errordata += "图片和教职工信息已添加，请额外进行车辆添加"
                    self.shownotice(info: errordata)
                }
                break
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                self.shownotice(info: "网络请求失败,图片和教职工信息已添加，请额外进行车辆添加")
                break
            }
        })
    }
    
    func shownotice(info:String) {
        let notice = UIAlertController(title: "提示", message: info, preferredStyle: .alert)
        let noticeaction = UIAlertAction(title: "确定", style: .default, handler: nil)
        notice.addAction(noticeaction)
        self.present(notice, animated: true, completion: nil)
    }
    
    func uploadimage(more:Bool){
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            let userimage = self.photoView.image!
            let imagedata = UIImageJPEGRepresentation(userimage, 0.8)
            
            let staffid = self.idTextfield.text!
            let imagename = staffid + ".jpg"
            print(imagename)
            
            //将图片数据进行转化并且加上属性
            MultipartFormData.append(imagedata!, withName: "photo", fileName: imagename, mimeType: "image/jpg")
            //添加其他数据
            let parameter = ["folder":"staff","name":imagename]
            
            for (key,value) in parameter {
                //将其他数据进行转化
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            //数据转化成功后进行网络请求
        }, to: AddImageUrl) { (encodingresult) in
            switch encodingresult {
                //转化成功，进行网络请求
            case .success(let upload, _ , _ ):
                upload.responseJSON(completionHandler: { (responsedata) in
                    print(responsedata)
                    switch responsedata.result {
                        //网络请求成功
                    case .success(let data):
                        //json解析
                        let jsondata = JSON(data)
                        let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                        let info = jsondata.dictionaryObject?["info"] as! String
                        print(info)
                        if issuccess {
                            self.addstaffinfo(more: more)
                        }else{
                            self.shownotice(info: info)
                        }
                        break
                        //网络请求失败
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        print("错误信息:\(error.localizedDescription)")
                        self.shownotice(info: "图片上传失败")
                        break
                    }
                })
                break
                //转化失败
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error)
                print(error.localizedDescription)
                //显示错误信息
                self.shownotice(info: "图片解析出错")
                break
            }
        }
        
 
        /*
        let userimage = self.photoView.image!
        let imagedata = UIImageJPEGRepresentation(userimage, 0.8)
        let staffid = self.idTextfield.text!
        let imagename = staffid + ".jpg"
        let multdata = MultipartFormData.init()
        multdata.append(imagedata!, withName: imagename)
        /*
         let parameter = ["folder":"staff","name":imagename]
         
         for (key,value) in parameter {
         MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
         }
         */
        let parameter = ["folder":"staff","name":imagename,"photo":multdata] as [String : Any]
        Alamofire.request(AddImageUrl, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (responsedata) in
            switch responsedata.result {
            case .success(let data):
                print(data)
                let jsondata = JSON(data)
                let issuccess = jsondata.dictionaryObject?["result"] as! Bool
                if issuccess {
                    success = true
                }else{
                    let errordata = jsondata.dictionaryObject?["info"] as! String
                    self.shownotice(info: errordata)
                    success = false
                }
                break
            case .failure(let error):
                print("1:")
                print(responsedata.data)
                print("2:")
                print(responsedata.value)
                print("错误：\(error)")
                print("错误信息:\(error.localizedDescription)")
                success = false
                break
            }
        }
        */
    }

    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if haveCarSwitch {
//            <#code#>
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if !haveCarSwitch.isOn{
//            if indexPath.section == 1{
//
//            }
//        }
//        return super.tableView(tableView, cellForRowAt: indexPath)
//    }
    
    
    
    //pickerview setting
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        carTypeTextfield.text = cartype[row]
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cartype.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cartype[row]
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
