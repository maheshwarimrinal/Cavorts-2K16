//
//  Register.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 23/07/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class Register: BaseMenuViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, SSASideMenuDelegate{
    
    var batchText = UITextField()
    var clubName = UITextField()
    var capName = UITextField()
    var sportName = UITextField()
    var eventImageView = UIImageView()
    var scroll = UIScrollView()
    var eventLabel = UILabel()
    var name = UITextField()
    var mail = UITextField()
    var branch = UITextField()
    var rollno = UITextField()
    var contact = UITextField()
    var button = UIButton()
    var activeTextField = UITextField()
    var batchDetails = UITextField()
    
    var textFieldTag = Int()
    
    var dataName = NSMutableArray()
    var imageName = NSMutableArray()
    var branchName = NSMutableArray()
    var branchNumber = NSMutableArray()
    var branchYear = NSMutableArray()
    var batchName = NSMutableArray()
    var pickerArray = NSMutableArray()
    
    var picker = UIPickerView()
    var width = CGFloat()
    var height = CGFloat()
    var kbHeight = CGFloat()
    var contentSize = CGFloat()
    var imgname = String()
    
    var success = Success()
    var defaults = UserDefaults.standard
    
    var menuButton = UIButton()
//    var wait = SCLAlertView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Register.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Register.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let cap1 = defaults.object(forKey: "cap") as? String
        let club1 = defaults.object(forKey: "club") as? String
        let name1 = defaults.object(forKey: "name") as? String
        let mail1 = defaults.object(forKey: "mail") as? String
        let branch1 = defaults.object(forKey: "branch") as? String
        let det = defaults.object(forKey: "det") as? String
        let rollno1 = defaults.object(forKey: "rollno") as? String
        let contact1 = defaults.object(forKey: "contact") as? String
        
        if (cap1 != "")||(club1 != "")||(name1 != "")||(mail1 != "")||(branch1 != "")||(rollno1 != "")||(contact1 != ""){
            capName.text = cap1
            clubName.text = club1
            name.text = name1
            mail.text = mail1
            batchDetails.text = det
            branch.text = branch1
            rollno.text = rollno1
            contact.text = contact1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isTranslucent = false
        
        branchName = [""]

        
        if SD.createTable("database", withColumnNamesAndTypes: ["name" : .stringVal, "sportname": .stringVal, "imagename": .stringVal]) != nil{
            print("Table exist")
        }
        else{
            print("Table Created")
        }
        
        
        defaults.set(false, forKey: "value")
        
        height = self.view.frame.height
        width = self.view.frame.width
        
        picker.delegate = self
        picker.dataSource = self
        
        if eventImageView.image == nil && eventLabel.text == nil{
            eventImageView.image = UIImage(named: "race")
            sportName.text = "Running"
            imgname = "race"
        }
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Register"
        
        imageName = ["race","Badminton","Basketball","Carrom","Chess","Cricket","GullyCricket","HandBall","HighJump","Kabaddi","KhoKho","LongJump","RopeClimbing","StreetSoccer","TableTennis","TugOfWar","VolleyBall","ShotPut"]
        dataName = ["Running","Badminton","Basketball","Carrom","Chess","Cricket","GullyCricket","HandBall","HighJump","Kabaddi","KhoKho","LongJump","RopeClimbing" ,"StreetSoccer","TableTennis","TugOfWar","VolleyBall","ShotPut"]
        batchName = ["BCA","BBA","BE-CSE","BE-ECE","BE-EEE","MBA","IMBA","MCA","IMCA","BAM","MSc"]
        branchYear = ["1","3","5","7","9"]
        
        //SCROLL VIEW
        scroll.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scroll.backgroundColor = UIColor.white
        self.view.addSubview(scroll)
        
        //IMAGE VIEW
        eventImageView.frame = CGRect(x: width/2-75, y: 10, width: 150, height: 150)
        eventImageView.backgroundColor = UIColor.white
        self.scroll.addSubview(eventImageView)
        
        //SPORTS NAME
        sportName.frame = CGRect(x: 10, y: eventImageView.frame.origin.y + eventImageView.frame.size.height + 5, width: self.view.frame.width - 20, height: 30)
        sportName.backgroundColor = UIColor.white
        sportName.inputView = picker
        sportName.textAlignment = .center
        let borderColor: UIColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
        sportName.layer.borderColor = borderColor.cgColor
        sportName.layer.borderWidth = 1.0
        sportName.layer.cornerRadius = 5.0
        sportName.isUserInteractionEnabled = true
        sportName.addTarget(self, action: #selector(Register.textDidBeginEditing(_:)), for: .editingDidBegin)
        sportName.tag = 1
        self.scroll.addSubview(sportName)
        
        //CLUB NAME
        clubName.delegate = self
        clubName.frame = CGRect(x: 10, y: sportName.frame.origin.y + sportName.frame.size.height + 10, width: self.view.frame.width - 20, height: 30)
        clubName.placeholder = " Club Name"
        clubName.backgroundColor = UIColor.white
        clubName.layer.borderColor = borderColor.cgColor
        clubName.layer.borderWidth = 1.0
        self.scroll.addSubview(clubName)
        
        //CAPTAIN NAME
        capName.delegate = self
        capName.frame = CGRect(x: 10, y: clubName.frame.origin.y + clubName.frame.size.height + 10, width: self.view.frame.width - 20, height: 30)
        capName.placeholder = " Captain Name"
        capName.backgroundColor = UIColor.white
        capName.layer.borderColor = borderColor.cgColor
        capName.layer.borderWidth = 1.0
        self.scroll.addSubview(capName)
        
        //NAME TEXTFIELD
        name.delegate = self
        name.frame = CGRect(x: 10, y: capName.frame.origin.y + capName.frame.size.height + 10, width: self.view.frame.width - 20, height: 30)
        name.placeholder = " Full name"
        name.backgroundColor = UIColor.white
        name.layer.borderColor = borderColor.cgColor
        name.layer.borderWidth = 1.0
        self.scroll.addSubview(name)
        
        //"name", "email","branch","rollno","game","phone"
        mail.delegate = self
        mail.frame = CGRect(x: 10, y: name.frame.origin.y + name.frame.size.height + 10, width: self.view.frame.width - 20, height: 30)
        mail.placeholder = " E-Mail address"
        mail.layer.borderColor = borderColor.cgColor
        mail.layer.borderWidth = 1.0
        mail.keyboardType = .emailAddress
        mail.autocapitalizationType = .none
        mail.addTarget(self, action: #selector(Register.textDidBeginEditing(_:)), for: UIControlEvents.editingDidBegin)
        self.scroll.addSubview(mail)
        
        //BRANCH SELECT
        branch.delegate = self
        branch.frame = CGRect(x: 10, y: mail.frame.origin.y + mail.frame.size.height + 10, width: (width-20) / 2.0, height: 30)
        branch.placeholder = "Branch"
        branch.layer.borderColor = borderColor.cgColor
        branch.layer.borderWidth = 1.0
        branch.inputView = picker
        branch.addTarget(self, action: #selector(Register.textDidBeginEditing(_:)), for: .editingDidBegin)
        branch.tag = 2
        self.scroll.addSubview(branch)
        
        batchDetails.delegate = self
        batchDetails.frame = CGRect(x: branch.frame.origin.x + branch.frame.width + 5, y: branch.frame.origin.y, width: branch.frame.width - 5, height: 30)
        batchDetails.placeholder = " Semester"
        batchDetails.layer.borderColor = borderColor.cgColor
        batchDetails.layer.borderWidth = 1.0
        batchDetails.keyboardType = .numberPad
        batchDetails.inputView = picker
        batchDetails.addTarget(self, action: #selector(Register.textDidBeginEditing(_:)), for: .editingDidBegin)
        self.scroll.addSubview(batchDetails)
        batchDetails.tag = 3
//        print(batchDetails.frame.origin.x + batchDetails.frame.width)
        
        //ROLL NUMBER SELECT
        rollno.delegate = self
        rollno.frame = CGRect(x: 10, y: branch.frame.origin.y + branch.frame.size.height + 10, width: width-20, height: 30)
        rollno.placeholder = " Roll Number"
        rollno.layer.borderColor = borderColor.cgColor
        rollno.layer.borderWidth = 1.0
        self.scroll.addSubview(rollno)
        
        //PHONE NUMBER
        contact.delegate = self
        contact.frame = CGRect(x: 10, y: rollno.frame.origin.y + rollno.frame.size.height + 10, width: width-20, height: 30)
        contact.placeholder = " Contact Number"
        contact.layer.borderColor = borderColor.cgColor
        contact.layer.borderWidth = 1.0
        contact.keyboardType = .numberPad
        self.scroll.addSubview(contact)
        
        //REGISTER BUTTON
        button.setTitle("Register", for:  UIControlState())
        button.setTitleColor(UIColor.black, for:  UIControlState())
        button.frame = CGRect(x: width/2-60, y: contact.frame.origin.y + contact.frame.size.height + 10, width: 120, height: 30)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(Register.register(_:)), for: .touchUpInside)
        self.scroll.addSubview(button)
        
     //   self.view.addSubview(adLabel)
        
        
        //CLOSE KEYBOARD AND PICKER
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Register.dismissKeyboard))
        scroll.addGestureRecognizer(tap)
        
        scroll.contentSize = CGSize(width: width, height: height + 15)
        scroll.showsVerticalScrollIndicator = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    

    func games(){
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: Games()), rightMenuViewController: RightMenuViewController())
        sideMenu.backgroundImage = UIImage(named: "Background.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        self.view.window?.rootViewController = sideMenu
    }
    @objc func register(_ sender: AnyObject){
        if capName.text! == "" || clubName.text! == "" || name.text! == "" || mail.text! == "" || branch.text! == "" || batchDetails.text! == "" || rollno.text! == "" || contact.text! == ""{
            
            _ = SweetAlert().showAlert("Warning", subTitle: "Please fill all details to proceed", style: .warning)
            
//            SCLAlertView().showWarning("DATA", subTitle: "Please fill all fields and proceed.")
            clubName.attributedPlaceholder = NSAttributedString(string: "Club Name !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            capName.attributedPlaceholder = NSAttributedString(string: "Captain Name !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            name.attributedPlaceholder = NSAttributedString(string: "Full Name !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            mail.attributedPlaceholder = NSAttributedString(string: "E-Mail Address !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            batchDetails.attributedPlaceholder = NSAttributedString(string: "Semester !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            branch.attributedPlaceholder = NSAttributedString(string: "Branch !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            rollno.attributedPlaceholder = NSAttributedString(string: "Roll Number !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            contact.attributedPlaceholder = NSAttributedString(string: "Contact Number !!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        }else{
            if Reachability.isConnectedToNetwork(){
                if !isValidEmail(mail.text!){
                    mail.textColor = UIColor.red
                }else{
                    
                    SwiftOverlays.showBlockingWaitOverlayWithText("Registring")
                    let url: URL = URL(string: "http://www.cavortsbit.in/register.php")!
                    let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
                    
                    let bodyData = "club="+clubName.text!+"&captain="+capName.text!+"&name="+name.text!+"&email="+mail.text!+"&phone="+contact.text!+"&branch="+branch.text!+" "+batchDetails.text!+"&rollno="+rollno.text!+"&game="+sportName.text!
                    
                    request.httpMethod = "POST"
                    
                    request.httpBody = bodyData.data(using: String.Encoding.utf8)
//                    URLSession.shared.dataTask(with: request as URLRequest){
//                        
//                    }
                    let task = URLSession.shared.dataTask(with: request as URLRequest)
                    { data, response, error in
                        guard error == nil && data != nil else {                                                          // check for fundamental networking error
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                            DispatchQueue.main.async{
                                _ = SweetAlert().showAlert("Error", subTitle: "Error try again after some time", style: .error)
//                                SCLAlertView().showError("ERROR", subTitle: "Error try after some time")
                                self.navigationController?.popViewController(animated: true)
                                SwiftOverlays.removeAllBlockingOverlays()
                            }
                        }else{
                            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("responseString = \(String(describing: responseString))")
                        
                        if(responseString == "2"){
                            DispatchQueue.main.async{
                                _ = SweetAlert().showAlert("Closed", subTitle: "Registrations has been closed", style: .warning)
//                                SCLAlertView().showNotice("Closed", subTitle: "Registrations has been closed contact Coordinators.\nThank You")
                                SwiftOverlays.removeAllBlockingOverlays()
                            }
                        }else 
                        
                        if (responseString == "1") {
                            DispatchQueue.main.async{
                                _ = SweetAlert().showAlert("Congrats", subTitle: "Successfully registered for \(self.sportName.text! as String)", style: .success)
//                                SCLAlertView().showSuccess("Congrats", subTitle: "Successfully Registered in \(self.sportName.text! as String) 👍🏻")
                                self.database()
                                SweetAlert().showAlert("Would you like to save your data?", subTitle: "", style: .warning, buttonTitle:"Yes", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes, Save it!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                                    if isOtherButton == true {
                                        self.defaults.setValue(self.capName.text, forKey: "cap")
                                        self.defaults.setValue(self.clubName.text, forKey: "club")
                                        self.defaults.setValue(self.name.text, forKeyPath: "name")
                                        self.defaults.setValue(self.mail.text, forKeyPath: "mail")
                                        self.defaults.setValue(self.branch.text, forKeyPath: "branch")
                                        self.defaults.setValue(self.batchDetails.text, forKeyPath: "det")
                                        self.defaults.setValue(self.rollno.text, forKeyPath: "rollno")
                                        self.defaults.setValue(self.contact.text, forKeyPath: "contact")
                                    }
                                    else {
                                        _ = SweetAlert().showAlert("Not Saved!", subTitle: "Your data is not saved", style: .success)
                                    }
                                }
//                                alert.showInfo("Save data ?", subTitle: "Would you like to save your data ?")
                                SwiftOverlays.removeAllBlockingOverlays()
                            }
                        }else{
                            DispatchQueue.main.async{
                                _ = SweetAlert().showAlert("Error", subTitle: "Error try again after some time", style: .error)
//                                SCLAlertView().showError("ERROR", subTitle: "Error try after some time")
                                self.navigationController?.popViewController(animated: true)
                                SwiftOverlays.removeAllBlockingOverlays()
                            }
                        }
                    }
                        
//                        print(bodyData)
                        
                    }
                    task.resume()
                }
            }else{
                DispatchQueue.main.async{
                    _ = SweetAlert().showAlert("Internet", subTitle: "Not connected to internet", style: .error)
//                    SCLAlertView().showError("Internet", subTitle: "Not connected to internet kindly connect")
                }
            }
            
        }
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        scroll.endEditing(true)
    }
    @objc func textDidBeginEditing(_ sender:UITextField) -> Void
    {
        textFieldTag = sender.tag
        pickerArray = []
        if sender == sportName{
            pickerArray = dataName
            picker.reloadAllComponents()
        }
        if sender == batchDetails{
            pickerArray = branchYear
            picker.reloadAllComponents()
        }
        if sender == branch{
            pickerArray = batchName
            picker.reloadAllComponents()
        }
        if sender == mail{
            mail.textColor = UIColor.black
        }
        print(pickerArray.count)
    }
    
    
    
    func database(){
        _ = SD.executeChange("INSERT INTO database (name, sportname, imagename) VALUES (?,?,?)" , withArgs: [name.text! as AnyObject, sportName.text! as AnyObject, imgname as AnyObject])
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if textFieldTag == 1{
            sportName.text = pickerArray[row] as? String
            imgname = imageName[row] as! String
            eventImageView.image = UIImage(named: imageName[row] as! String)
        }
        if textFieldTag == 2{
            branch.text = pickerArray[row] as? String
        }
        if textFieldTag == 3{
            batchDetails.text = pickerArray[row] as? String
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.cgRectValue
        let keyboardFrameConvertedToViewFrame = view.convert(keyboardFrame!, from: nil)
        let options = UIViewAnimationOptions.beginFromCurrentState
        UIView.animate(withDuration: animationDuration, delay: 0, options:options, animations: { () -> Void in
            let insetHeight = (self.scroll.frame.height + self.scroll.frame.origin.y) - keyboardFrameConvertedToViewFrame.origin.y
            self.scroll.contentInset = UIEdgeInsetsMake(0, 0, insetHeight, 0)
            self.scroll.scrollIndicatorInsets  = UIEdgeInsetsMake(0, 0, insetHeight, 0)
        }) { (complete) -> Void in
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let options = UIViewAnimationOptions.beginFromCurrentState
        UIView.animate(withDuration: animationDuration, delay: 0, options:options, animations: { () -> Void in
            self.scroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.scroll.scrollIndicatorInsets  = UIEdgeInsetsMake(0, 0, 0, 0)
        }) { (complete) -> Void in
        }
    }

    override func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
