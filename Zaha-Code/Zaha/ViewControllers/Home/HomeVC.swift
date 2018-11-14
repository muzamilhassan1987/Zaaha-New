//
//  HomeVC.swift
//  Zaha
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeVC: BaseViewController,GIDSignInUIDelegate, GIDSignInDelegate, StoryBoardHandler {
 
    var manager = HomeManager()
    var storiesArray = [Stories]()
    var experienceArray = [Experiences]()
    var mergedArray = [AnyObject]()
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.home.rawValue , nil)
    
    @IBOutlet weak var homeTblView: UITableView!
    var detailType = BookingDetailEnum.none
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setInitialData()
        print(detailType)
        homeTblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        callHomeService()
        // Do any additional setup after loading the view.
        
    }
    func setNavBar()
    {
        self.title = "HOME"
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))

    }

    
    func setInitialData() {
        
        switch detailType {
        case .none:
            self.title = "Home".uppercased()
            break
        case .upcomingExperience:
            self.title = "Upcoming Experiences"
            break
        case .booking:
            self.title = "Booking".uppercased()
            break
        case .stories:
            self.title = "Stories".uppercased()
           
            let menuImg = UIImage.init(named: "storeis_plusIcon")?.flipIfNeeded()
            self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionRight, self, #selector(showCreateExpScreen))
            break
        case .myExperience:
            self.title = "My Experiences".uppercased()
            break
        case .pastExperience:
            self.title = "Past Experiences".uppercased()
            break
        default:
            print("")
        }
        
        
    }
    @objc func showCreateExpScreen()
    {
        router.goToCreateExperience(from: self)
        //sideMenuController?.showLeftViewAnimated()
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
    }
    
    //home_menuIcon
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func googleSignInButtonClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
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
        
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
    }
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        print(detailType)
        switch detailType {
        case .none:
            if (indexPath.row % 2 == 0) {
                cell.setData(.homeList)
            }else{
                cell.setData(.stories)
            }
            
            
            break
        case .upcomingExperience:
            cell.setData(.homeList)
            break
        case .booking:
            break
        case .stories:
            cell.setData(.stories)
            break
        case .myExperience:
            cell.setData(.homeList)
            break
        case .pastExperience:
            cell.setData(.homeList)
            break
        default:
            print("")
        }
        //cell.setData(.homeList)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  var controller = UpComingExperienceDetailController.loadVC()
        //router.goToUpComingExperienceController(from: self)
        
        print(detailType)
        router.goToBookingDetailController(from: self, type: detailType)
//        switch detailType {
//        case .none,.upcomingExperience :
//            router.goToBookingDetailController(from: self, type: .upcomingExperience)
//            break
//        case .booking:
//            router.goToBookingDetailController(from: self, type: .booking)
//            break
//
//        default:
//            print("")
//        }
    }
    
}


extension HomeVC{
    
       func callHomeService(){
        let requestParam = self.manager.params()
        
        self.manager.api(requestParam, completion: {
            if self.manager.isSuccess {
                let homeData = HomeTimeLine(fromDictionary: self.manager.homeTimeLineData)
                self.storiesArray = homeData.stories
                self.experienceArray = homeData.experiences
            }
        })
    }
}
