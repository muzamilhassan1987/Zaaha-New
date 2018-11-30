//
//  ChatViewController.swift
//  Zaha
//
//  Created by Faraz Haider on 11/29/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum ChatMsgType : Int {
    case chatMsgTypeSender
    case chatMsgTypeReceiver
}

class ChatViewController: UIViewController {
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMsgType = indexPath.row % 2 == 0 ? ChatMsgType.chatMsgTypeReceiver : ChatMsgType.chatMsgTypeSender
        
        if chatMsgType.rawValue == ChatMsgType.chatMsgTypeSender.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellSender", for: indexPath) as! ChatCell
              cell.setDataForChatWithSenderType(chatMsgType: chatMsgType)
            
            return cell
        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellReceiver", for: indexPath) as! ChatCell
               
                 cell.setDataForChatWithSenderType(chatMsgType: chatMsgType)
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
