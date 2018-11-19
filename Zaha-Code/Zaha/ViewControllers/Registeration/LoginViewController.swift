

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: BaseViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue , nil)
    
    @IBOutlet weak var btnForgotPwd: BaseUIButton!
    @IBOutlet weak var txtEmail: BaseUITextField!
    @IBOutlet weak var txtPwd: BaseUITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewSignup: UIView!
    @IBOutlet weak var btnLogin: CustomButton!
    @IBOutlet weak var btnGuestLogin: BaseUIButton!
    
    @IBOutlet weak var lblDontHaveAccount: UILabel!
    let manager = RegisterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
        txtEmail.text = "rrrr@rrrr.com"
        txtPwd.text = "qwerty12"
        // Do any additional setup after loading the view.
        //           txtEmail.delegate = self
        //           txtPwd.delegate = self
        //
        //       // txtEmail.text = "user@user.com" //"w@w.com"
        //       // txtPwd.text = "123123" //"123456"
        //        self.navigationController?.isNavigationBarHidden = true
        //        txtEmail.keyboardType = .emailAddress
        //        setupForAnimation()
        //        setTextAsPerLanguage()
        //      perform(#selector(animate), with: nil, afterDelay: 0.2)
        //          Navigation.currentNavigation = self.navigationController
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    func setNavBar()
    {
        self.title = "LOGIN"
        self.navigationController?.isNavigationBarHidden = false
        
        //        let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
        //self.addBarButtonItemWithImage(img!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        //  animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //setupForAnimation()
        
    }
    
    func setTextAsPerLanguage() {
        
        btnForgotPwd.setTitle(GlobalStatic.getLocalizedString("forget_pwd"), for: .normal)
        txtEmail.placeholder = GlobalStatic.getLocalizedString("email_address")
        txtPwd.placeholder = GlobalStatic.getLocalizedString("pwd")
        btnLogin.setTitle(GlobalStatic.getLocalizedString("login"), for: .normal)
        btnGuestLogin.setTitle(GlobalStatic.getLocalizedString("login_guest"), for: .normal)
        lblDontHaveAccount.colorString(text: GlobalStatic.getLocalizedString("signup_text"), coloredText: GlobalStatic.getLocalizedString("signup"), color: Constants.selectedColor)
    }
    
    func setupForAnimation() {
        
        btnForgotPwd.isHidden = true
        imgLogo.isHidden = true
        txtEmail.isHidden = true
        txtPwd.isHidden = true
        btnLogin.isHidden = true
        viewSignup.isHidden = true
        btnGuestLogin.isHidden = true
    }
    
    
    @objc func animate(){
        
        // var t = 0.1
        //  var diff = 0.5
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipEmail), with: nil, afterDelay: 0.1)
        perform(#selector(flipPwd), with: nil, afterDelay: 0.2)
        perform(#selector(flipLogin), with: nil, afterDelay: 0.3)
        perform(#selector(flipLabel), with: nil, afterDelay: 0.4)
        perform(#selector(flipGuest), with: nil, afterDelay: 0.5)
        // perform(#selector(imgLogo.flipFromRight), with: nil, afterDelay: 0.17)
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
        btnForgotPwd.flipFromRight()
        
    }
    
    @objc func flipEmail() {
        txtEmail.flipFromRight()
    }
    
    @objc func flipPwd() {
        txtPwd.flipFromRight()
    }
    @objc func flipLogin(){
        btnLogin.flipFromRight()
    }
    
    @objc func flipLabel() {
        viewSignup.flipFromRight()
    }
    
    @objc func flipGuest(){
        btnGuestLogin.flipFromRight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func gotoHomeController(_ sender: UIButton) {
        router.goToHomeAsRoot(from: self)
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        
        show(viewcontrollerInstance: ForgetContainerViewController.loadVC())
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        
        show(viewcontrollerInstance: RegisterViewController.loadVC())
    }
    
    @IBAction func loginAsGuestBtnTapped(_ sender: Any) {
        
        show(viewcontrollerInstance: HomeViewController.loadVC())
        return
            
            // -- ww getClassFromString()
            
            CurrentUser.userType = .guest
        router.goToSettingsVC(from: self)
    }
    
    
    @IBAction func facebookLoginClicked(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    fbLoginManager.logOut()
                }
            }
        })
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    let fbDic = result as! NSDictionary
                    let paramDictionary = ["email":fbDic["email"],
                                           "socialmedia_type":"facebook",
                                           "socialmedia_id":fbDic["id"],
                                           "device_type":"iOS",
                                           "device_token":"asdasdaad",
                                           "first_name":fbDic["name"],
                                           "last_name":""]
                    
                    self.callSocialLoginService(paramDictionary: paramDictionary as! [String : String?])
                }
            })
        }
    }
    
    @IBAction func googleLoginClicked(_ sender: Any) {
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        
        let status = validateForm()
        
        if status.0 == false {
            Alert.showMsg(msg: status.1)
            
        }else {
            let parameters = [
                "email" : txtEmail.text!,
                "password" :txtPwd.text!,
                "device_type" : "ios",
                "device_token" :"212123"// CurrentUser.deviceToken,
                ] as [String : String]
            
            
            doLogin(params: parameters)
        }
    }
    
    
    func validateForm() -> (Bool , String)  {
        
        let emailText = txtEmail.text
        let pwdTExt = txtPwd.text
        
        
        if (emailText?.isEmptyStr())!{
            return (false, "Enter email")
            //return (false, GlobalStatic.getLocalizedString("email_needed"))
        }else if !(emailText?.isValidEmail())!{
            return (false, "Enter valid email")
            //return (false, GlobalStatic.getLocalizedString("valid_email_needed"))
        }else if (pwdTExt?.isEmptyStr())! {
            return (false, "Enter password")
            //return (false, GlobalStatic.getLocalizedString("pwd_needed"))
        }
        
        return (true, "")
    }
    
    func getClassFromString() {
        let className = "Test.SettingsTableViewCell"
        let aClass = NSClassFromString(className) as! UITableViewCell.Type
        let cell = aClass.init()
        
        print(String(describing: cell))
    }
    
    
}
extension LoginViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "nothinng")
    }
}


// MARK: - Networking
extension LoginViewController {
    
    func doLogin(params : [String : String]) {
        let requestParam = self.manager.paramsLogin(parameters: params as [String : AnyObject])
        
        self.manager.apiLogin(requestParam, completion: {
            
            if self.manager.isSuccess {
                CurrentUser.data =  self.manager.userData
                CurrentUser.token = self.manager.userData?.token ?? ""
                CurrentUser.userType = .registered
                print(CurrentUser.data?.email)
                print(CurrentUser.data?.id)
                print(CurrentUser.data?.firstName)
                
                let userDefault = UserDefaults.standard
                userDefault.set(true, forKey: Login.isLoggedIn)
                userDefault.set(self.manager.userData?.token, forKey: Login.token)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.manager.userData), forKey:Login.userData)
                
                router.goToHomeAsRoot(from: self)
                //self.checkIfUserIsVerified(isVerified : (self.manager.userData?.isVerified)!)
            }
            else {
                
                print("failed")
            }
        })
    }
    
    func checkIfUserIsVerified(isVerified : String) {
        
        if Int(isVerified) == 1 {
            //        CurrentUser.data =  self.manager.userData
            //        CurrentUser.token = self.manager.userData?.token ?? ""
            CurrentUser.userType = .registered
            
            
            let userDefault = UserDefaults.standard
            userDefault.set(true, forKey: Login.isLoggedIn)
            //            userDefault.set(self.manager.userData?.token, forKey: Login.token)
            //   UserDefaults.standard.set(try? PropertyListEncoder().encode(self.manager.userData), forKey:Login.userData)
            if FP.loginGuest == true && CartData.cartDict.count > 0{
                
            }else{
                
            }
        }else{
            
            router.goToEnterCodeVC(from: self, codeType : .signup)
        }
    }
}



extension LoginViewController : GIDSignInUIDelegate, GIDSignInDelegate{
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        let paramDictionary = ["email":user.profile.email,
                               "socialmedia_type":"google",
                               "socialmedia_id":user.userID,
                               "device_type":"iOS",
                               "device_token":"asdasdaad",
                               "first_name":user.profile.name,
                               "last_name":""]
        self.callSocialLoginService(paramDictionary: paramDictionary)
    }
}


extension LoginViewController{
    
    func callSocialLoginService(paramDictionary: [String : String?]){
        let requestParam = self.manager.paramsWithImage(parameters: paramDictionary as [String : AnyObject], img: UIImage(), isSocialLogin: true)
        
        self.manager.apiSocial(requestParam, completion: {
            
            if self.manager.isSuccess {
                CurrentUser.data =  self.manager.userData
                CurrentUser.token = self.manager.userData?.token ?? ""
                CurrentUser.userType = .registered
                
                let userDefault = UserDefaults.standard
                userDefault.set(true, forKey: Login.isLoggedIn)
                userDefault.set(self.manager.userData?.token, forKey: Login.token)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.manager.userData), forKey:Login.userData)
                
                router.goToHomeAsRoot(from: self)
                
            }
            else {
                
                print("failed")
            }
        })
    }
}
