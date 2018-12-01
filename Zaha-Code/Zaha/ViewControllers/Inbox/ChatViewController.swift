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

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    var inboxManager = InboxManager()
    var chatArray  = [ChatMessages]()
    var receiverId = 0
    var threadId = 0

    @IBOutlet weak var chatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.getChatMsgs()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.createBackButton()
    }
    
    func getChatMsgs(){
        
        var parameters = [String : String]()
        parameters.updateValue(String(threadId), forKey: "thread_id")
        
        let requestParam =  self.inboxManager.paramsChatMessgaes(parameters: parameters as [String : AnyObject])
        self.inboxManager.apiGetChatMessages(requestParam, completion: {
            
            if self.inboxManager.isSuccess {
                print(self.inboxManager.data)
                if (self.inboxManager.chatData?.count)! > 0 {
                    self.chatArray = self.inboxManager.chatData!
                }
            }
            
            self.chatTableView.reloadData()
            self.scrollToBottom()
        })
    }
    
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatArray.count-1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    @IBAction func sendChatButtonClicked(_ sender: Any) {
        if chatTextField.text == ""{
            return
        }
        
        var parameters = [String : String]()
        parameters.updateValue(String(threadId), forKey: "thread_id")
        parameters.updateValue(chatTextField.text!, forKey: "message")
        parameters.updateValue(String(receiverId), forKey: "receiver_id")
        
        let requestParam =  self.inboxManager.paramsSendChatMessgaes(parameters: parameters as [String : AnyObject])
        self.inboxManager.apiSendChatMsgs(requestParam, completion: {
            self.chatTextField.text = ""
            if self.inboxManager.isSuccess {
               self.getChatMsgs()
            }
        })
    }
    
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let msgData = self.chatArray[indexPath.row]
        
        let userId = 541
        
        var chatMsgType =  ChatMsgType.chatMsgTypeReceiver
        
        if (userId == msgData.senderId)
         {
            chatMsgType = ChatMsgType.chatMsgTypeSender
            
        }
        else{
             chatMsgType = ChatMsgType.chatMsgTypeReceiver
        }
        
        
        if chatMsgType.rawValue == ChatMsgType.chatMsgTypeSender.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellSender", for: indexPath) as! ChatCell
                    cell.selectionStyle = .none
              cell.setDataForChatWithSenderType(chatMsgType: chatMsgType, withMsg: msgData)
            
            return cell
        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellReceiver", for: indexPath) as! ChatCell
                       cell.selectionStyle = .none
                 cell.setDataForChatWithSenderType(chatMsgType: chatMsgType, withMsg: msgData)
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
