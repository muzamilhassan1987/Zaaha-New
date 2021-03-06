
import UIKit

class Router  {
 
    typealias viewController  =  StoryBoardHandler & UIViewController
    
    func goToViewController(from vc : viewController , withTitle title : String) {
      
      vc.show(viewcontrollerInstance: ViewController.loadVC()) { (vc : ViewController) in
            vc.titleHeader = title
        }
        
        
    }
    
    func goToCreateStoryController(from vc : viewController) {
        
        vc.show(viewcontrollerInstance: CreateStoryController.loadVC()) { (vc : CreateStoryController) in
            //vc.titleHeader = title
        }
        
        
    }
    func goToBookingDetailController(from vc : viewController , withTitle title : String) {
        
        vc.show(viewcontrollerInstance: BookingDetailController.loadVC()) { (vc : BookingDetailController) in
           // vc.titleHeader = title
        }
        
        
    }
    
    
    func goToHomeAsRoot()
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Storyboards.sideMenu.rawValue, bundle: nil)
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
        UIApplication.shared.keyWindow?.rootViewController = viewController
//        vc.navigationController?.setViewControllers([SideMenuController.loadVC()], animated: true)
    }
    
    
    func goToLoginScreen() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Storyboards.registeration.rawValue, bundle: nil)
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "BaseNavigationController") as! BaseNavigationController
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
        // vc.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
    }
    
    
    func goToEnterCodeVC(from vc : viewController, codeType : CodeType) {
      vc.show(viewcontrollerInstance: EnterCodeViewController.loadVC()) { (vc : EnterCodeViewController) in
            vc.type = codeType
        }
    }
    
    func goToChangePwdVC(from vc : viewController)  {
        
        vc.show(viewcontrollerInstance: ChangePasswordViewController.loadVC())
    }
    
    func goToCreateExperience(from vc : viewController)  {
        
        vc.show(viewcontrollerInstance: CreateExperienceController.loadVC())
    }
    
    func goToCreateStory(from vc : viewController)  {
        
        vc.show(viewcontrollerInstance: CreateStoryController.loadVC())
    }
    
    func goToSettingsVC(from vc : viewController) {
        
          vc.show(viewcontrollerInstance: SettingViewController.loadVC())
   
    }
    
    func goToResetPwd(from vc : viewController) {
        vc.show(viewcontrollerInstance: ResetPasswordViewController.loadVC())
    }
    
    func goToTerms(from vc : viewController) {
        vc.show(viewcontrollerInstance: TermsConditionViewController.loadVC())
    }
    
    func goToUpComingExperienceController(from vc : viewController) {
        vc.show(viewcontrollerInstance: UpcommingExperienceDetailViewController.loadVC())
    }
    func goToUpPhotosController(from vc : viewController, type : BookingDetailEnum, videos : [HomeVideo]? = nil , photos : [HomePicture]? = nil) {
        vc.show(viewcontrollerInstance: PhotosController.loadVC()) { (vc : PhotosController) in
            vc.arrPhotos = photos
            vc.arrVideos = videos
            vc.detailType = type
        }
    }
    func goToBookingDetailController(from vc : viewController, type : BookingDetailEnum,navigation : BaseNavigationController, data : Any?) {
        
        vc.navigateWithCustomNavigation(viewControllerInstance: BookingDetailController.loadVC(), navController: navigation) { (vc : BookingDetailController) in
            vc.detailType = type
            vc.detailData = data
        }
        
//        vc.show(viewcontrollerInstance: BookingDetailController.loadVC()) { (vc : BookingDetailController) in
//            vc.detailType = type
//            vc.detailData = data
//        }
        
       
    }
    
}
