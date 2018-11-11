

import UIKit

class BookingListController: BaseViewController , StoryBoardHandler {
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.booking.rawValue , nil)
    
    @IBOutlet weak var tblBookingList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setNavBar()
        tblBookingList.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        tblBookingList.estimatedRowHeight = 200.0
        tblBookingList.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    func setNavBar()
    {
        self.title = "BOOKING"
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
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
extension BookingListController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
//        cell.backgroundColor = UIColor.yellow
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.goToBookingDetailController(from: self, withTitle: "")
    }
    
    
}
