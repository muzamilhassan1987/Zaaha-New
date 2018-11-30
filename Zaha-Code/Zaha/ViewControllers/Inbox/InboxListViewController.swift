//
//  InboxListViewController.swift
//  Zaha
//
//  Created by Faraz Haider on 11/29/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class InboxListViewController: UIViewController {
    var inboxManager = InboxManager()
    @IBOutlet weak var inboxTableView: UITableView!
    var inboxArray  = [InboxThread]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getInboxListing()
        // Do any additional setup after loading the view.
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InboxListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath) as! InboxCell
    
        let inboxObj = inboxArray[indexPath.row]
        
        
        cell.dateLabel.text = Date.getFormattedDate(string: inboxObj.updatedAt!, formatter: "h:mm a")
        cell.nameLabel.text = inboxObj.senderDetail?.userName
        cell.msgLabel.text = inboxObj.message
        cell.userImageView.setImageFromUrl(urlStr: (inboxObj.senderDetail?.imageUrl!)!)
        if inboxObj.unreadMessageCount! > 0{
            cell.unreadMsgLabel.text = "\(inboxObj.unreadMessageCount)"
            cell.unreadMsgLabel.isHidden = false
            cell.unreadMsgBgView.isHidden = false
        }else{
            cell.unreadMsgLabel.isHidden = true
            cell.unreadMsgBgView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showChatingView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}
