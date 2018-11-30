//
//  ChatCell.swift
//  Zaha
//
//  Created by Faraz Haider on 11/29/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var chatMsg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDataForChatWithSenderType(chatMsgType: ChatMsgType){
        
        if chatMsgType.rawValue == ChatMsgType.chatMsgTypeSender.rawValue{
           
            let image = UIImage(named: "Inbox_messageRecieveBox")
            bubbleImageView.image = image?
                .resizableImage(withCapInsets:
                    UIEdgeInsets(top: 15, left: 29, bottom: 15, right: 29),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
            bubbleImageView.tintColor =  UIColor.init(hexString: "#575756")
            
            chatMsg.text = "ChatMsgType.chatMsgTypeSender.rawValue"
            
        }else{
            let image = UIImage(named: "Inbox_messageSentBox")
            bubbleImageView.image = image?
                .resizableImage(withCapInsets:
                    UIEdgeInsets(top: 22, left: 76, bottom: 22, right: 76),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
           bubbleImageView.tintColor =  UIColor.init(hexString: "#C89F68")
            
            chatMsg.text = "ChatMsgType.chatMsgTypeReceiver.rawValue"
        }
        
    }
    
}