//
//  ViewController.swift
//  Mama
//
//  Created by AA101 on 2020/10/8.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var lblname: UILabel!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        lblname.text = "F229419527"
    }

    @IBAction func signoutbtnClick(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func diet(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Dietpage") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    /*@IBAction func record(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "ReocrdPG") {
            present(controller, animated: true, completion: nil)
        }
    }*/
    @IBAction func Announcement(_ sender: Any) {
        if let url = URL(string: "http://120.125.78.69:8080/Login.aspx")
        {
            if #available(iOS 10.0, *)
            {
                UIApplication.shared.open(url, options: [:])
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func foot(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "FootPage") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func enviroment(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "enviromentPage") {
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func diary(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "diaryPage") {
            present(controller, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //透過button & viewController之間連線的segue
        if segue.identifier == "ModifyDetail"{
            let controller = segue.destination as! ModifyDetailVC
            controller.id = lblname.text
        }
        else if segue.identifier == "babyPage"{
            let controller = segue.destination as! babyVC
            controller.id = lblname.text
        }
        else if segue.identifier == "recordPage" {
            let controller = segue.destination as! RecordInspecVC
            controller.id = lblname.text!
        }
    }
}

