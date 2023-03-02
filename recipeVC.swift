//
//  recipeVC.swift
//  Mama
//
//  Created by AA101 on 2020/11/19.
//

import UIKit

class recipeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let re = WebService()
    var list = [String]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var lblPregnantWeek: UILabel!
    @IBOutlet weak var textPregnantWeek: UITextField!
    var number:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "F229419527"

        // Do any additional setup after loading the view.
        list.append("第一孕期\t第0週～第17週")
        list.append("第二孕期\t第17週～第29週")
        list.append("第三孕期\t第29週～")
        
        
        //PargnantWeek
        textPregnantWeek.text = re.PregnantWeek(id: label.text!)
        lblPregnantWeek.text = "您目前懷孕第" + textPregnantWeek.text! + "週"
        
        //tableview cell Color
        number = Int(textPregnantWeek.text!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath)
        cell.textLabel?.text = list[indexPath.row]
        
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        
        return cell
    }

    @IBAction func cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        let indexPath = tableview.indexPathForSelectedRow
        let Str = list[indexPath!.row]
        let vc = segue.destination as? DeTailVC
            vc?.Str = Str
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
