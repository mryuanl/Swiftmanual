//
//  SettingViewController.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/27.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    // Do any additional setup after loading the view.
    @IBOutlet weak var tableView: UITableView!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    struct allocate {
        var uname : String
        var post_id : Int
        var department_id : Int
    }
    var alloc :[allocate] = []
    //展示列表
    //var tableView: UITableView!
    //搜索控制器
    var countrySearchController = UISearchController()
    //原始数据集
    //搜索过滤后的结果集
    var searchArray:[allocate] = [allocate]()
    {didSet  {self.tableView.reloadData()}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //创建表视图
//        let tableViewFrame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height-20)
//        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
//        self.tableView!.delegate = self
//        self.tableView!.dataSource = self
//        //创建一个重用的单元格
//        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        self.view.addSubview(self.tableView!)
//        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self   //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        getJson()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getJson()
    {
        let url = URL(string:"http://localhost:8080/departs")
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
                                                            if let uname = json[i]["Uname"].string  {
                                                                if let pid = json[i]["post_id"].int{
                                                                    if let did = json[i]["department_id"].int{
                                                                        let pe = allocate(uname: uname, post_id: pid,department_id: did)
                                                                        self.alloc.append(pe)
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
    }
    
}


extension SettingViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {return self.searchArray.count}
        else {return self.alloc.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        
        if self.countrySearchController.isActive
        {
            cell.uNameLabel?.text = searchArray[indexPath.row].uname
            //        cell.detailTextLabel?.text = String(allo.department_id)
            cell.postidLabel?.text = String(searchArray[indexPath.row].post_id)
            cell.departidLabel?.text = String(searchArray[indexPath.row].department_id)
        }
        else
        {
            cell.uNameLabel?.text = alloc[indexPath.row].uname
            //        cell.detailTextLabel?.text = String(allo.department_id)
            cell.postidLabel?.text = String(alloc[indexPath.row].post_id)
            cell.departidLabel?.text = String(alloc[indexPath.row].department_id)
        }
        return cell
    }
}

extension SettingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.alloc.filter { (allocate) -> Bool in
            return allocate.uname.contains(searchController.searchBar.text!)
        }
    }
}
