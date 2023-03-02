//
//  enviro_searchTableVC.swift
//  Mama
//
//  Created by AA101 on 2020/10/26.
//

import UIKit

class enviro_searchTableVC: UITableViewController {
    
    let selectedBackgroundView = UIView()
    var jsonObj: [[String: String]]!
    var number:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let url = URL(string: "http://opendata2.epa.gov.tw/AQI.json")
        let data = try! Data(contentsOf: url!)
        jsonObj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonObj.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text=(jsonObj[indexPath.row])["County"]!+(jsonObj[indexPath.row])["SiteName"]!
        cell.detailTextLabel?.text=(jsonObj[indexPath.row])["AQI"]
        
        number = Int((jsonObj[indexPath.row])["AQI"]!)
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(Int(number ?? 50) <= 50){
            
            cell.backgroundColor = UIColor.systemGreen
        }
        else if(Int(number ?? 50) > 50&&Int(number ?? 100) <= 100){
            
            cell.backgroundColor = UIColor.systemYellow
        }
        else if(Int(number ?? 100) > 100&&Int(number ?? 150) <= 150){
            
            cell.backgroundColor = UIColor.systemOrange
        }
        else if(Int(number ?? 150) > 150&&Int(number ?? 200) <= 200){
            
            cell.backgroundColor = UIColor.systemRed
        }
        else if(Int(number ?? 200) > 200&&Int(number ?? 300) <= 300){
            
            cell.backgroundColor = UIColor.systemPurple
        }
        else if(Int(number ?? 300) > 300&&Int(number ?? 500) <= 500){
            
            cell.backgroundColor = UIColor.brown
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Int(number ?? 50) <= 50){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：正常戶外活動。\n敏感性族群：正常戶外活動。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if(Int(number ?? 50) > 50&&Int(number ?? 100) <= 100){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：正常戶外活動。\n敏感性族群：極特殊敏感族群建議注意可能產生的咳嗽或呼吸急促症狀，但仍可正常戶外活動。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if(Int(number ?? 100) > 100&&Int(number ?? 150) <= 150){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。\n敏感性族群：有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議減少體力消耗活動及戶外活動，必要外出應配戴口罩。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if(Int(number ?? 150) > 150&&Int(number ?? 200) <= 200){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：如果有不適，如眼痛，咳嗽或喉嚨痛等，應減少體力消耗，特別是減少戶外活動。\n敏感性族群：有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議留在室內並減少體力消耗活動，必要外出應配戴口罩。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if(Int(number ?? 200) > 200&&Int(number ?? 300) <= 300){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：應減少戶外活動\n敏感性族群：有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並減少體力消耗活動，必要外出應配戴口罩。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if(Int(number ?? 300) > 300&&Int(number ?? 500) <= 500){
            
            let alert = UIAlertController(title: "AQI提醒", message: "一般民眾：應避免戶外活動，室內應緊閉門窗，必要外出應配戴口罩等防護用具。\n敏感性族群：有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並避免體力消耗活動，必要外出應配戴口罩。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

