//
//  regiester.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/30.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import Foundation
import UIKit

class regiesterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailConfirmedTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBAction func regiButton(_ sender: Any) {
        postrequest()
        showMsgbox(_message: "注册成功")
        
    }
    @IBAction func deleteButton(_ sender: Any) {
        deleterequest()
    }
    func showMsgbox(_message: String,_title: String = "提示"){
        let alert = UIAlertController(title: _title,message: _message,preferredStyle: UIAlertController.Style.alert)
        let btn1 = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btn1)
        self.present(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        postrequest()
    }
    func postrequest(){
        let url = URL(string:"http://localhost:8080/users")
        var request = URLRequest(url: url!)
        let parameters = ["Id": idTextField.text!,"Email":emailTextField.text!,"EmailConfirmed":Int(emailConfirmedTextField.text!),"PasswordHash":passwordTextField.text!,"UserName":userNameTextField.text!] as [String : Any]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "post"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        let json = try! JSON(data: httpBody)
        print(json)
        
        request.httpBody = httpBody
        let dataTask = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error)
                                                    }else{
                                                        let json = try! JSON(data: data!)
                                                        print("xiangying")
                                                    }
        }) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
    }
    func deleterequest(){
        let url = URL(string:"http://localhost:8080/users")
        var request = URLRequest(url: url!)
        let parameters = ["Id": idTextField.text!,"Email":emailTextField.text!,"EmailConfirmed":Int(emailConfirmedTextField.text!),"PasswordHash":passwordTextField.text!,"UserName":userNameTextField.text!] as [String : Any]
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "delete"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        let json = try! JSON(data: httpBody)
        print(json)
        
        request.httpBody = httpBody
        let dataTask = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error)
                                                    }else{
                                                        let json = try! JSON(data: data!)
                                                        print("xiangying")
                                                    }
        }) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
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
    
}
