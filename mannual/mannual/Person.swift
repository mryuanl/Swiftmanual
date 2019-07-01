//
//  Person.swift
//  mannual
//
//  Created by jsj-10 on 2019/6/26.
//  Copyright © 2019 jsj-10. All rights reserved.
//

import Foundation
class Persontest :NSObject{
    var uname : String
    var post_id : String
    var department_id : String
    
    init(uname1: String, post_id1: String, department_id1: String) {
        
        self.uname = uname1
        self.post_id = post_id1
        self.department_id = department_id1
    }
    //static func loadSampleToDos() -> [Persontest] {
    //}
}
