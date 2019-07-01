//
//  userManagerTableViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/24.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class userManagerTableViewController: UITableViewController,UISearchBarDelegate{
    
    //@IBOutlet weak var countrySearchController: UISearchController!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    struct allocate {
        var uname : String
        var post_name : String
        var department_name : String
    }
    var alloc :[allocate] = []
    //匹配结果
    var allocnew :[allocate] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"3.jpg")!)
        self.view.layer.contents = UIImage(named: "3.jpg")?.cgImage
        let url = URL(string:"http://localhost:8080/allocates")
        //创建请求对象
        var request = URLRequest(url: url!)
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
                                                            if let pname = json[i]["a"].string  {
                                                                if let uname = json[i]["b"].string{
                                                                    if let dname = json[i]["c"].string{
                                                                        let pe = allocate(uname: uname, post_name: pname, department_name: dname)
                                                                        self.alloc.append(pe)
                                                                        self.allocnew.append(pe)
                                                                        print(pe.uname)
                                                                    }
                                                                }
                                                            }
                                                            i = i+1
                                                        }
                                                        self.tableView.reloadData()
//                                                        print(1000000)
                                                    }
        }) as URLSessionTask
        //使用resume方法启动任务
        dataTask.resume()
        searchBar.delegate = self
    }
    /*func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOf: NSURL(string: url)! as URL)
        var error: NSError?
        var jsonArray: NSArray = try! JSONSerialization.jsonObject(with: data! as Data, options: .mutableContainers) as! NSArray
        return jsonArray
    }*/

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        //if self.countrySearchController.isActive {return self.allocnew.count}
        //else {
            return self.allocnew.count
            
        //}
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        self.tableView.rowHeight = 120
        
            cell.uNameLabel?.text = allocnew[indexPath.row].uname
            //        cell.detailTextLabel?.text = String(allo.department_id)
            cell.postidLabel?.text = String(allocnew[indexPath.row].post_name)
            cell.departidLabel?.text = String(allocnew[indexPath.row].department_name)
        
        return cell
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            self.allocnew = self.alloc
        }else{
            self.allocnew = []
            for alloc1 in self.alloc {
                if alloc1.uname.contains(searchText) || String(alloc1.post_name).contains(searchText) || String(alloc1.department_name).contains(searchText){
                    self.allocnew.append(alloc1)
                }
            }
        }
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
//extension userManagerTableViewController: UISearchResultsUpdating
//{
//    //实时进行搜索
//    func updateSearchResults(for searchController: UISearchController) {
//        self.allocnew = self.alloc.filter { (allocate) -> Bool in
//            return allocate.uname.contains(searchController.searchBar.text!)
//        }
//    }
//}
