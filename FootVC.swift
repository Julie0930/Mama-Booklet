//
//  FootVC.swift
//  Mama
//
//  Created by AA101 on 2021/1/18.
//

import UIKit
import MapKit
import CoreMotion
import UserNotifications

//https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services/requesting_always_authorization?language=objc

class FootVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var a:Int?

    //用於顯示實際資訊
    @IBOutlet weak var step: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var up: UITextField!
    @IBOutlet weak var down: UITextField!
    
    //Map
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var address: UILabel!
    
    
        //計步器對象
        let pedometer = CMPedometer()
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //開始計步器更新
        startPedometerUpdates()
        
        //map
        locationManager.delegate = self  //委派給ViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //設定為最佳精度
        locationManager.requestWhenInUseAuthorization()  //user授權
        locationManager.startUpdatingLocation()  //開始update位置
        
        map.delegate = self
        map.showsUserLocation = true   //顯示user位置
        map.userTrackingMode = .follow  //隨著user移動
    }
         
        // 開始獲取計步器數據
    func startPedometerUpdates() {
        //判断设备支持情况
        guard CMPedometer.isStepCountingAvailable() else {
            self.step.text = "當前設備不支持獲取步數\n"
            return
        }
             
        //獲取今天凌晨時間
        let cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let midnightOfToday = cal.date(from: comps)!
             
        //初始化並開始收集數據
        self.pedometer.startUpdates (from: midnightOfToday, withHandler: { [self] pedometerData, error in
            //错误处理
            guard error == nil else {
                print(error!)
                return
            }
                 
            //獲取各種數據
            //var text = "---今日運動數據---\n\n"
            if let numberOfSteps = pedometerData?.numberOfSteps {
                self.step.text = "\(numberOfSteps)"
                self.a = Int((numberOfSteps))
                if(self.a! < 6000)
                {
                    let content = self.GetNotificationContent()
                
                    // time interval must be at least 60 if repeating
                    var components = DateComponents()
                    //components.weekday = 2 //周一
                    components.hour = 16 //下午2点
                    components.minute = 30 //30分
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                    //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                    let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
                        
                    // send request right now
                    //let request2 = UNNotificationRequest(identifier: "notification1", content: content, trigger: nil)
                        
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            }
            if let distance = pedometerData?.distance {
                self.distance.text = "\(distance)"
            }
            if let floorsAscended = pedometerData?.floorsAscended {
                self.up.text = "\(floorsAscended)"
            }
            if let floorsDescended = pedometerData?.floorsDescended {
                self.down.text = "\(floorsDescended)"
            }
            /*if let currentPace = pedometerData?.currentPace{
                text += "速度: \(currentPace)m/s\n\n"
            }
            if let currentCadence = pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n\n"
            }*/
                
            //在線中更新畫面數據
            DispatchQueue.main.async{
                //self.textView.text = text
                self.step.text = self.step.text
                self.distance.text = self.distance.text
                self.up.text = self.up.text
                self.down.text = self.down.text
            }
        })
    }
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func GetNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "健康提醒"
        content.subtitle = "您今天的步數少於6000步哦!!!"
        content.body = """
        您今日的步數為: \(String(a!))步
        是不是該起來運動運動一下呢？
        每天至少要運動而且走路要超過6000步
        這樣孕婦及寶寶會擁有健康的身體哦！
        """
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "HealthMessage"
        
        //let imageURL = Bundle.main.url(forResource: "Cat2", withExtension: "jpg")
        //let attchment = try! UNNotificationAttachment(identifier: "catNotification1", url: imageURL!, options: nil)
        //content.attachments = [attchment]
        //content.userInfo =   ["link":"https://img5.cna.com.tw/www/WebPhotos/1024/20190828/960x960_268359289092.jpg"]
        
        return content
    }
    //開啟update位置後 startUpdatingLocation()，觸發func locationManager, [CLLocation]會取得所有定位點，[0]為最新點
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        let userLocation: CLLocation = locations[0]

        //CLGeocoder地理編碼 經緯度轉換地址位置
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                //the geocoder actually returns CLPlacemark objects, which contain both the coordinate and the original information that you provided.
                if let placemark = placemark?[0] {
                    
                    //print(placemark)
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\t"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\t"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\t"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\t"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country!
                        
                    }
                    
                    self.address.text = String(address)
                }
                
            }
 
        }
    }
}
