//
//  InboxListViewController.swift
//  Zaha
//
//  Created by Faraz Haider on 11/29/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class InboxListViewController: BaseViewController,StoryBoardHandler {
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.inbox.rawValue , nil)
    var inboxManager = InboxManager()
    @IBOutlet weak var inboxTableView: UITableView!
    var inboxArray  = [InboxThread]()
    var receiverId = 0
    var threadId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getInboxListing()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.lblTitle.text = "Inbox"
        baseNavigation?.createHomeButton(target: self, #selector(actionMenuButton))
        
    }
    
    func setNavBar()
    {
        self.title = "Inbox"
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
    }
    
    func getInboxListing() {
        
        let requestParam =  self.inboxManager.paramsInboxListing()
        self.inboxManager.apiGetMyInboxThreads(requestParam, completion: {
            
            if self.inboxManager.isSuccess {
                print(self.inboxManager.data)
                if (self.inboxManager.data?.count)! > 0 {
                    self.inboxArray = self.inboxManager.data!
                }
            }
            
            self.inboxTableView.reloadData()
        })
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChatingView"{
            var vc = segue.destination as! ChatViewController
            vc.receiverId = receiverId
            vc.threadId = threadId
            //Data has to be a variable name in your RandomViewController
        }
    }
 

}

extension InboxListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath) as! InboxCell
    
        let inboxObj = inboxArray[indexPath.row]
        
        cell.selectionStyle = .none
        cell.dateLabel.text = Date.getFormattedDate(string: inboxObj.updatedAt!, formatter: "h:mm a")
        cell.nameLabel.text = inboxObj.senderDetail?.userName
        cell.msgLabel.text = inboxObj.message
        cell.userImageView.setImageFromUrl(urlStr: (inboxObj.receiverDetail?.imageUrl!)!)
        receiverId  = inboxObj.receiverId!
        if inboxObj.unreadMessageCount! > 0{
            cell.unreadMsgLabel.text = "\(inboxObj.unreadMessageCount!)"
            cell.unreadMsgLabel.isHidden = false
            cell.unreadMsgBgView.isHidden = false
        }else{
            cell.unreadMsgLabel.isHidden = true
            cell.unreadMsgBgView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let inboxObj = inboxArray[indexPath.row]
        threadId = inboxObj.id!
        self.performSegue(withIdentifier: "showChatingView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}
