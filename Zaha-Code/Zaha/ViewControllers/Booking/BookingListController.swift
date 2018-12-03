

import UIKit

class BookingListController: BaseViewController , StoryBoardHandler {
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.booking.rawValue , nil)
    
    @IBOutlet weak var tblBookingList: UITableView!
    var manager = BookingManager()
    var arrDataList = [BaseHomeModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //setNavBar()
        tblBookingList.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        tblBookingList.estimatedRowHeight = 200.0
        tblBookingList.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.lblTitle.text = "BOOKINGS"
        baseNavigation?.createHomeButton(target: self, #selector(actionMenuButton))
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(isDataLoaded == false){
            self.getBookingList()
        }
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
        print(self.arrDataList.count)
        return self.arrDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
       // let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        cell.setData(self.arrDataList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // router.goToBookingDetailController(from: self, withTitle: "")
    }
    
    
}
extension BookingListController{
    
    func getBookingList() {
        
        let requestParam = self.manager.paramsBookingList()
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                print(self.manager.data)
                self.arrangeArrayResponse()
            }
        })
    }
    
    func arrangeArrayResponse() {
        print(self.manager.data)
        self.isDataLoaded = true
        var data = [BaseHomeModel]()
        for obj in self.manager.data {
            if let objExperience = obj as? HomeExperience {
                //                print(obj1.title)
                data.append(objExperience)
                // obj is a string array. Do something with stringArray
            }
            if let objStory = obj as? HomeStory {
                data.append(objStory)
                //                print(obj1.title)
                // obj is a string array. Do something with stringArray
            }
            
            
        }
        self.arrDataList = data//.sorted(by: { $0.sortingDateNew! < $1.sortingDateNew!})
        print(self.arrDataList.count)
        self.tblBookingList.reloadData()
    }
}
