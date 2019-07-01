//
//  loginViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/23.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    struct Person1 {
        var name : String
        var password : String
    }

    
    var persons :[Person1] = []
    //var test = [Persontest]()
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        let jump : Bool = judge()
        if jump == true{
            self.performSegue(withIdentifier: "mainform", sender: nil)
        }else{
            showMsgbox(_message: "登录失败")
        
        }
        
    }
    @IBAction func regis(_ sender: Any) {
        self.performSegue(withIdentifier: "regi", sender: nil)
    }
    func showMsgbox(_message: String,_title: String = "提示"){
        let alert = UIAlertController(title: _title,message: _message,preferredStyle: UIAlertController.Style.alert)
        let btn1 = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btn1)
        self.present(alert, animated: true, completion: nil)
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        super.viewDidLoad()
        
        let url = URL(string:"http://localhost:8080/users")
        //创建请求对象
        let request = URLRequest(url: url!)
        
        let dataTask = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error)
                                                    }else{
                                                        let json = try! JSON(data: data!)
                                                        var i: Int = 0
                                                        var j: Int = json.count
                                                        while(i<j){
                                                            if let uname = json[i]["UserName"].string  {
                                                                if let upwd = json[i]["PasswordHash"].string{
                                                                let testperson = Person1(name:uname,password: upwd)
                                                                    self.persons.append(testperson)
                                                                }
                                                            }
                                                            i = i+1
                                                        }
                                                    }
                                                    
        }) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
        // Do any additional setup after loading the view.\
    }
    func judge () -> Bool {
        for person in persons{
            if nameTextField.text == person.name{
                if pwdTextField.text == person.password{
                    return true
                }
            }
        }
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
