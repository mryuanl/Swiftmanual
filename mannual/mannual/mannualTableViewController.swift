//
//  mannualTableViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/26.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class mannualTableViewController: UITableViewController {

      var manual :[String] = []
     var newman1 = [ToDo]()
  
    let url = URL(string:"http://localhost:8080/manuals")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        //创建请求对象
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error)
                                                    }else{
                                                        print(2)
                                                        let json = try! JSON(data: data!)
                                                        var i: Int = 0
                                                        var j: Int = json.count
                                                        while(i<j){
                                                            if let mname = json[i]["Mname"].string  {
                                                                self.manual.append(mname)
                                                                        //print(pe.uname)
                                                                
                                                            }
                                                            i = i+1
                                                        }
                                                        self.tableView.reloadData()
                                                        print(1000000)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return manual.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "manualCellIdentifier") as? manualCell else {
            fatalError("Could not dequeue a cell")
        }
        // Configure the cell...
        self.tableView.rowHeight = 100
        let manual1 = manual[indexPath.row]
        cell.manualNameLabel?.text = manual1
        return cell
    }
    

//
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!newManualTableViewController
        if let todo = sourceViewController.todo{
                let newIndexPath = IndexPath(row: manual.count,section: 0)
            //print("zhelixians")
                newman1.append(todo)
            manual.append(newman1[newman1.count-1].name)
                tableView.insertRows(at: [newIndexPath],with: .automatic)
            //新建
//            var request1 = URLRequest(url: url!)
//             request1.httpMethod = "post"
//            var param:NSString = NSString(format:"Mname=%@",newman1[newman1.count-1].name)
//            //把拼接后的字符串转换为data，设置请求体
//            request1.httpBody = param.data(using: <#T##UInt#>, allowLossyConversion: true)
//            
//            
//            //(3) 发送请求
//            NSURLConnection.sendAsynchronousRequest(request1, queue:OperationQueue()) { (res, data, error)in
//                
//                //服务器返回：请求方式 = GET，返回数据格式 = JSON，用户名 = 123，密码 = 1233
//                
//                let  str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
//                
//                print(str)
//                
//                
//                
//            }
//            
       }
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
