//
//  WebService.swift
//  Mama
//
//  Created by AA101 on 2020/12/2.
//

import Foundation
public class WebService{
    public var Url:String = "http://120.125.78.69:8080/WebService.asmx"
    public var Host:String = "120.125.78.69"
    public func dataToBase64(data:NSData)->String{
            
            let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            return result;
        }
        public func dataToBase64(data: Data)->String {
            let result = data.base64EncodedString()
            return result
        }
        public func byteArrayToBase64(data:[UInt])->String{
            let nsdata = NSData(bytes: data, length: data.count)
            let data  = Data.init(referencing: nsdata)
            if let str = String.init(data: data, encoding: String.Encoding.utf8){
                return str
            }
            return "";
        }
        public func timeToString(date:Date)->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        public func dateToString(date:Date)->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
        public func base64ToByteArray(base64String: String) -> [UInt8] {
            let data = Data.init(base64Encoded: base64String)
            let dataCount = data!.count
            var bytes = [UInt8].init(repeating: 0, count: dataCount)
            data!.copyBytes(to: &bytes, count: dataCount)
            return bytes
        }
        func stringFromXMLString(xmlToParse:String)->String {
            do
            {
                let xml = SWXMLHash.lazy(xmlToParse)
                let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
                let xmlResult: XMLIndexer?  = xmlResponse?.children.last
                
                let xmlElement = xmlResult?.element
                let str = xmlElement?.text
                let xmlElementFirst = xmlElement?.children [0] as!TextElement
                return xmlElementFirst.text
            }
            catch
            {
            }
            //NOT IMPLETEMENTED!
            var returnValue:String!
            return returnValue
        }
        func stringFromXML(data:Data)-> String
        {
            
            let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
            if xmlToParse == nil {
                return ""
            }
            if xmlToParse!.count == 0 {
                return ""
            }
            let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
            return stringVal
            
        }
        func stringArrFromXMLString(xmlToParse :String)->[String?]{
            let xml  = SWXMLHash.lazy(xmlToParse)
            let xmlRoot  = xml.children.first
            let xmlBody = xmlRoot?.children.last
            let xmlResponse : XMLIndexer? =  xmlBody?.children.first
            let xmlResult : XMLIndexer?  = xmlResponse?.children.last
            
            var strList = [String?]()
            let childs = xmlResult!.children
            for child in childs {
                let text = child.element?.text
                strList.append(text)
            }
            
            return strList
        }
        func stringArrFromXML(data:Data)->[String?]{
            let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
            if xmlToParse == nil {
                return [String?]()
            }
            if xmlToParse!.count == 0 {
                return [String?]()
            }
            
            let  stringVal = stringArrFromXMLString(xmlToParse:  xmlToParse!)
            return stringVal
        }
        
        func byteArrayToBase64(bytes: [UInt8]) -> String {
            
            let data = Data.init(bytes: bytes)
            let base64Encoded = data.base64EncodedString()
            return base64Encoded
           
        }
        
        func base64ToByteArray(base64String: String) -> [UInt8]? {
            if let data = Data.init(base64Encoded: base64String){
                var bytes = [UInt8](repeating: 0, count: data.count)
                data.copyBytes(to: &bytes, count: data.count)
                return bytes
            }
            return nil // Invalid input
        }
    
    //登入
    public func Login(Id:String, Pwd:String)-> String{
        var soapReqXml:String = """
              <?xml version="1.0" encoding="utf-8"?>
              <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
              <soap:Body>
              <Login xmlns="http://tempuri.org/">
              <UserId>
              """+Id+"""
              </UserId>
              <Pwd>
              """+Pwd+"""
          </Pwd>
             </Login>
             </soap:Body>
            </soap:Envelope>
          """
        let soapAction :String = "http://tempuri.org/Login"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    //註冊
    public func Insertregistered2(id:String, pwd:String, name:String, telephone:String, birthday:String, emergencyContact1:String, emergencyTelephone1:String, emergencyContact2:String, emergencyTelephone2:String)-> Void{
            var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <InsertUserRegister xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Pwd>
                """+pwd+"""
                </Pwd>
                <Name>
                """+name+"""
                </Name>
                <Birthday>
                """+birthday+"""
                </Birthday>
                <Phone>
                """+telephone+"""
                </Phone>
                <emergencyContact1>
                """+emergencyContact1+"""
                </emergencyContact1>
                <emergencyTelephone1>
                """+emergencyTelephone1+"""
                </emergencyTelephone1>
                <emergencyContact2>
                """+emergencyContact2+"""
                </emergencyContact2>
                <emergencyTelephone2>
                """+emergencyTelephone2+"""
                </emergencyTelephone2>
              </InsertUserRegister>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/InsertUserRegister"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    
    //修改基本資料
    //更新註冊的資料
    public func Updateregistered2(id:String, pwd:String, name:String, telephone:String, birthday:String, emergencyContact1:String, emergencyTelephone1:String, emergencyContact2:String, emergencyTelephone2:String)-> Void{
            var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <UpdateUserRegister xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Pwd>
                """+pwd+"""
                </Pwd>
                <Name>
                """+name+"""
                </Name>
                <Birthday>
                """+birthday+"""
                </Birthday>
                <Phone>
                """+telephone+"""
                </Phone>
                <emergencyContact1>
                """+emergencyContact1+"""
                </emergencyContact1>
                <emergencyTelephone1>
                """+emergencyTelephone1+"""
                </emergencyTelephone1>
                <emergencyContact2>
                """+emergencyContact2+"""
                </emergencyContact2>
                <emergencyTelephone2>
                """+emergencyTelephone2+"""
                </emergencyTelephone2>
              </UpdateUserRegister>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/UpdateUserRegister"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    //觀看註冊資料_Json
    public func MaMaModify(id:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <ISelectUserRegister xmlns="http://tempuri.org/">
                    <UserId>
                    """+id+"""
              </UserId>
              </ISelectUserRegister>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/ISelectUserRegister"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //觀看註冊資料_XML
    public func Modifyname(id:String)-> String{
            var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <MomName xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                </MomName>
                </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/MomName"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func ModifyEC1(id:String)-> String{
            var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <MomEmergencyContact1 xmlns="http://tempuri.org/">
                    <UserId>
                    """+id+"""
                </UserId>
                </MomEmergencyContact1>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/MomEmergencyContact1"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func ModifyEC2(id:String)-> String{
            var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <MomEmergencyContact2 xmlns="http://tempuri.org/">
                    <UserId>
                    """+id+"""
                </UserId>
                </MomEmergencyContact2>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/MomEmergencyContact2"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    //寶寶生產紀錄
    public func BabyRecord(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                  <soap:Body>
                    <ISelectBaby xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
              </Parity>
                 </ISelectBaby>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/ISelectBaby"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func Babygender(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <BabyGender xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
              </Parity>
                </BabyGender>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/BabyGender"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func BabyName(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                 <soap:Body>
                <BabyName xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
              </Parity>
                </BabyName>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/BabyName"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func BabyWeekHospital(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                  <soap:Body>
                    <BabyHospital xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
              </Parity>
                </BabyHospital>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/BabyHospital"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func Babyway(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <BabyBornWay xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
                </Parity>
                </BabyBornWay>
                </soap:Body>
                </soap:Envelope>
                """
        let soapAction :String = "http://tempuri.org/BabyBornWay"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func UpdateBaby(id:String, parity:String, babyname:String)-> Void{
            var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <UpdateBaby xmlns="http://tempuri.org/">
                    <UserId>
                    """+id+"""
                    </UserId>
                    <Parity>
                    """+parity+"""
                    </Parity>
                    <BabyName>
                    """+babyname+"""
                    </BabyName>
                    </UpdateBaby>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/UpdateBaby"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    public func BabyImage(id:String, parity:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <DownLoadImageBaby xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
                </Parity>
                </DownLoadImageBaby>
                </soap:Body>
                </soap:Envelope>
                """
        let soapAction :String = "http://tempuri.org/DownLoadImageBaby"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }

    //產檢紀錄
    public func MaMaRecordParity1(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <ISelectUserRecord1 xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </ISelectUserRecord1>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/ISelectUserRecord1"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func MaMaRecordParity2(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <ISelectUserRecord2 xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </ISelectUserRecord2>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/ISelectUserRecord2"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func MaMaRecordOther(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <RecordOther xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </RecordOther>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/RecordOther"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func MaMaRecordResult(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <RecordResult xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </RecordResult>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/RecordResult"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func MaMaRecordWarn(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <RecordResultWarning xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </RecordResultWarning>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/RecordResultWarning"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func InertUltra(crl:String, bpd:String, ac:String, fl:String, efw:String, parity:String, times:String, id:String)-> Void{
            var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <InsertUltra xmlns="http://tempuri.org/">
                <CRL>
                """+crl+"""
                </CRL>
                <BPD>
                """+bpd+"""
                </BPD>
                <AC>
                """+ac+"""
                </AC>
                <FL>
                """+fl+"""
                </FL>
                <EFW>
                """+efw+"""
                </EFW>
                <Parity>
                """+parity+"""
                </Parity>
                <Times>
                """+times+"""
                </Times>
                <UserId>
                """+id+"""
                </UserId>
              </InsertUltra>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/InsertUltra"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
    }
    public func boolUlt(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <TodayUltra xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                    </Times>
                    </TodayUltra>
                  </soap:Body>
                </soap:Envelope>
                """
        let soapAction :String = "http://tempuri.org/TodayUltra"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //UpLoad Image
    public func InertPhotoUlt(stringBuffer:String, id:String, parity:String, time:String)-> Void{
            var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <FileUploadBase64Ultra xmlns="http://tempuri.org/">
                    <stringBuffer>
                    """+stringBuffer+"""
                    </stringBuffer>
                    <UserId>
                    """+id+"""
                    </UserId>
                    <Parity>
                    """+parity+"""
                    </Parity>
                    <Times>
                    """+time+"""
                    </Times>
                    </FileUploadBase64Ultra>
                    </soap:Body>
                    </soap:Envelope>
                """
           let soapAction :String = "http://tempuri.org/FileUploadBase64Ultra"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    public func MaMaImage(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <DownLoadImageUltra xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Parity>
                    """+parity+"""
                    </Parity>
                      <Times>
                    """+time+"""
                </Times>
                </DownLoadImageUltra>
                </soap:Body>
                </soap:Envelope>
                """
        let soapAction :String = "http://tempuri.org/DownLoadImageUltra"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func MaMarecordDetail(id:String, parity:String, time:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <SelectUltra xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Parity>
                """+parity+"""
                </Parity>
                <Times>
                """+time+"""
                </Times>
                </SelectUltra>
                </soap:Body>
                </soap:Envelope>
                """
        let soapAction :String = "http://tempuri.org/SelectUltra"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //飲食紀錄
    public func FoodBool(id:String, time:String, date:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <TodayFood xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <time>
                    """+time+"""
                    </time>
                      <date>
                    """+date+"""
              </date>
                    </TodayFood>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/TodayFood"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func FoodContent(id:String, time:String, date:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <SelectFood xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <EatTime>
                """+time+"""
            </EatTime>
            <EatDate>
            """+date+"""
              </EatDate>
              </SelectFood>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/SelectFood"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func InertFood(id:String, time:String, date:String, food:String)-> Void{
            var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <InsertFood xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <time>
                """+time+"""
                </time>
                <date>
                """+date+"""
                </date>
                <food>
                """+food+"""
                </food>
              </InsertFood>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/InsertFood"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
    }
    public func FoodRecipe(topic:String)-> String{
        var soapReqXml:String = """
            <?xml version="1.0" encoding="utf-8"?>
            <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
            <iOSSelectReceipt xmlns="http://tempuri.org/">
            <Topic>
            """+topic+"""
              </Topic>
              </iOSSelectReceipt>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/iOSSelectReceipt"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func FoodPicture(topic:String)-> String{
        var soapReqXml:String = """
            <?xml version="1.0" encoding="utf-8"?>
            <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
            <SelectReceiptPicture xmlns="http://tempuri.org/">
            <Topic>
            """+topic+"""
              </Topic>
              </SelectReceiptPicture>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/SelectReceiptPicture"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func PregnantWeek(id:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <PregnantWeek xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
              </UserId>
                </PregnantWeek>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/PregnantWeek"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //日記-心情
    public func Diarybool(id:String, date:String, type:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <TodayDairy xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                    <Date>
                """+date+"""
                </Date>
                <Type>
                """+type+"""
              </Type>
              </TodayDairy>
              </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/TodayDairy"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func DiaryMood(id:String, date:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <DiaryMood xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Date>
                    """+date+"""
                    </Date>
                    </DiaryMood>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/DiaryMood"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func DiaryMoodDes(id:String, date:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <DiaryMoodDes xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Date>
                    """+date+"""
                    </Date>
                    </DiaryMoodDes>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/DiaryMoodDes"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //日記-身體
    public func DiaryBody(id:String, date:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <DiaryBody xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Date>
                    """+date+"""
                    </Date>
                    </DiaryBody>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/DiaryBody"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func DiaryBodyDes(id:String, date:String)-> String{
        var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <DiaryBodyDes xmlns="http://tempuri.org/">
                      <UserId>
                    """+id+"""
                    </UserId>
                      <Date>
                    """+date+"""
                    </Date>
                    </DiaryBodyDes>
                  </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/DiaryBodyDes"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    //日記insert
    public func InertDiary(id:String, date:String, mood:String, mooddes:String, body:String, bodydes:String)-> Void{
            var soapReqXml:String = """
            <?xml version="1.0" encoding="utf-8"?>
            <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
            <InsertDiary xmlns="http://tempuri.org/">
            <UserId>
            """+id+"""
                    </UserId>
                    <date>
                    """+date+"""
                    </date>
                    <mood>
                    """+mood+"""
                    </mood>
                    <moodDes>
                    """+mooddes+"""
                    </moodDes>
                    <body>
                    """+body+"""
                    </body>
                    <bodyDes>
                    """+bodydes+"""
                </bodyDes>
                 </InsertDiary>
               </soap:Body>
              </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/InsertDiary"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    //UpLoad Image
    public func InertDiaryPhoto(stringBuffer:String, id:String, date:String)-> Void{
            var soapReqXml:String = """
                    <?xml version="1.0" encoding="utf-8"?>
                    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                    <FileUploadBase64Diary xmlns="http://tempuri.org/">
                    <stringBuffer>
                    """+stringBuffer+"""
                    </stringBuffer>
                    <UserId>
                    """+id+"""
                    </UserId>
                    <date>
                    """+date+"""
                    </date>
                    </FileUploadBase64Diary>
                    </soap:Body>
                    </soap:Envelope>
                """
           let soapAction :String = "http://tempuri.org/FileUploadBase64Diary"
            let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        }
    public func DiaryImage(id:String, date:String)-> String{
        var soapReqXml:String = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                <DownLoadImageDairy xmlns="http://tempuri.org/">
                <UserId>
                """+id+"""
                </UserId>
                <Date>
                """+date+"""
                </Date>
                </DownLoadImageDairy>
                </soap:Body>
                </soap:Envelope>
              """
           let soapAction :String = "http://tempuri.org/DownLoadImageDairy"
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXml)
        let strVal :String? = stringFromXML( data : responseData)
        if strVal == nil {

            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
}
   
