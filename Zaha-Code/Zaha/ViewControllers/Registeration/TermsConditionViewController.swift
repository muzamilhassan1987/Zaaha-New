

import UIKit

class TermsConditionViewController: UIViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue , nil)
    
   var manager = CMSManager()
    
    @IBOutlet weak var txtViewTerms: BaseUITextView!
    
    
    @IBOutlet weak var btnGoBack: UIButton!
    
    @IBOutlet weak var lblHeader: BaseUILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblHeader.text = GlobalStatic.getLocalizedString("terms_condition")
        let img = UIImage.init(named: "backBtn")?.flipIfNeeded()
        btnGoBack.setImage(img, for: .normal)
        self.txtViewTerms.text = ""
         //getTerms()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

