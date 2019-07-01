//
//  newManualTableViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/27.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class newManualTableViewController: UITableViewController {
      var todo: ToDo?
    @IBOutlet weak var manualNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var idSaveTextField: UITextField!
    func updateSaveButtonState() {
        let text = manualNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func postrequest(){
        let mid = idSaveTextField.text
        let mname = manualNameTextField.text
        let url = URL(string:"http://localhost:8080/manuals")
        var request = URLRequest(url: url!)
        let parameters = ["Id": Int(mid!),"Mname":mname!] as [String : Any]
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
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let save1 = manualNameTextField.text!
        todo = ToDo(name:save1)
        postrequest()
        print("xy2")
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
