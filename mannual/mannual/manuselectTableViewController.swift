//
//  manuselectTableViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/26.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class manuselectTableViewController: UITableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var countResultLabel: UILabel!
    @IBOutlet weak var searchOBar: UISearchBar!
    struct finder {
        var prgm_id : String
        var prgm_name : String
        var version : String
    }
    var find :[finder] = []
    //结果
    var select:[finder] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        let url = URL(string:"http://localhost:8080/finder")
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
                                                            if let fname = json[i]["Fname"].string  {
                                                                if let prgm_id = json[i]["code"].string  {
                                                                    if let version = json[i]["version"].string  {
                                                                        let fin = finder(prgm_id: prgm_id, prgm_name:fname ,version: version)
                                                                self.find.append(fin)
                                                                self.select.append(fin)
                                                                //print(pe.uname)
                                                                    }
                                                                }
                                                            }
                                                            i = i+1
                                                        }
                                                        self.tableView.reloadData()
                                                        print(1000000)
                                                    }
        }) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
        searchOBar.delegate = self
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.select.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "manuselectCellIdentifier") as? manuselectCell else {
            fatalError("Could not dequeue a cell")
        }
        // Configure the cell...
        self.tableView.rowHeight = 100
        //cell.textLabel?.text = find1.prgm_id+"   "+find1.prgm_name+"   "+find1.version
        cell.prgmidLabel?.text = select[indexPath.row].prgm_id
        cell.selectNameLabel?.text = select[indexPath.row].prgm_name
        cell.identifierNameLabel?.text = select[indexPath.row].version
        return cell
    }
    
    func searchBar(_ searchOBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            self.select = self.find
        }else{
            self.select = []
            for find1 in self.find {
                if find1.prgm_id.contains(searchText) || find1.prgm_name.contains(searchText) || find1.version.contains(searchText) {
                self.select.append(find1)
                
            }
        }
    }
          countResultLabel.text = "搜索到 \(select.count)条符合查询条件的记录！"
          self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
