//
//  RecordInspecTableVC.swift
//  Mama
//
//  Created by AA101 on 2020/12/29.
//

import UIKit

class RecordInspecTableVC: UITableViewController {
    
    var list = [String]()
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        list.append("第1次產檢紀錄")
        list.append("第2次產檢紀錄")
        list.append("第3次產檢紀錄")
        list.append("第4次產檢紀錄")
        list.append("第5次產檢紀錄")
        list.append("第6次產檢紀錄")
        list.append("第7次產檢紀錄")
        list.append("第8次產檢紀錄")
        list.append("第9次產檢紀錄")
        list.append("第10次產檢紀錄")
        list.append("第11次產檢紀錄")
        list.append("第12次產檢紀錄")
        list.append("第13次產檢紀錄")
        list.append("第14次產檢紀錄")
        list.append("第15次產檢紀錄")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableview.indexPathForSelectedRow
        let str = list[indexPath!.row]
        let vc = segue.destination as? Record_DetailVC
        vc?.str = str
    }
}
