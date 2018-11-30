//
//  SplashViewController.swift
//

import UIKit

class SplashViewController: UIViewController , StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.main.rawValue, nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        
        GlobalStatic.delay(delay: 3) { [weak self] in

            
            
            if let strongSelf = self{
               // router.goToViewController(from: strongSelf, withTitle: "My Form")
                strongSelf.checkLogin()
//                router.goToLoginScreen(from: strongSelf)
            }

        }
        
     
    }
    

    
    func checkLogin(){
        
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: Login.isLoggedIn) == true {
            if let data = UserDefaults.standard.value(forKey: Login.userData) as? Data {
                CurrentUser.data = try? PropertyListDecoder().decode(UserData.self, from: data)
            }
            CurrentUser.token = UserDefaults.standard.value(forKey: Login.token) as! String
            
            router.goToHomeAsRoot()
            // self.navigationController?.setViewControllers([HomeViewController.loadVC()], animated: true)
            
        }else{
                router.goToLoginScreen()
            // FP.loginGuest = false; self.navigationController?.setViewControllers([WalkThroughViewController.loadVC()], animated: true)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
