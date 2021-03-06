//
//  YNAnswerTableViewCell.swift
//  nongjitong
//
//  Created by 农盟 on 15/12/8.
//  Copyright © 2015年 农盟. All rights reserved.
//

import UIKit

class YNAnswerTableViewCell: UITableViewCell {
    
    var didSetupConstraints: Bool = false
    
    var questionModel: YNAnswerModel? {
    
        didSet {
            
            if let _ = questionModel {
                
                setInterface()
                setLayout()
                
                //TODO: 设置头像 和文字
                self.contentButton.setTitle(questionModel?.description, forState: .Normal)
                
                if questionModel!.isQuestionOwner! {
                  self.contentButton.setBackgroundImage(resizeImage("bubble_left_blue"), forState: .Normal)
                    
                } else {
                
                    self.contentButton.setBackgroundImage(resizeImage("bubble_green"), forState: .Normal)
                }
                
                
            }
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImageView.removeFromSuperview()
        self.contentButton.removeFromSuperview()
        self.activityIndicatorView.removeFromSuperview()
        self.sendButton.removeFromSuperview()
    }
    
    func resizeImage(name: String) -> UIImage{
    
        let image = UIImage(named: name)
        
        let top =  image!.size.height * 0.6
        let bottom = image!.size.height - top
        let left = image!.size.width * 0.5
        
        let newimage = image!.resizableImageWithCapInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: left), resizingMode: .Stretch)
        
        return newimage
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sendButton.addTarget(self, action: "sendMessageToserver", forControlEvents: .TouchUpInside)
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInterface() {
    
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(contentButton)
        self.contentView.addSubview(activityIndicatorView)
        self.contentView.addSubview(sendButton)
    }
    
    //头像
    let avatarImageView: UIImageView = {
    
        let tempView = UIImageView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.image = UIImage(named: "admin")
        tempView.contentMode = .ScaleToFill
        return tempView
        
    }()
    
    //文字
    let contentButton: UIButton = {
    
        let tempView = UIButton()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.titleLabel?.font = UIFont.systemFontOfSize(15)
        tempView.titleLabel?.numberOfLines = 0
        tempView.setTitleColor(UIColor.blackColor(), forState: .Normal)
        tempView.backgroundColor = UIColor.clearColor()
        tempView.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        tempView.userInteractionEnabled = false
        
        return tempView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
    
        let tempView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.hidesWhenStopped = true
        return tempView
    }()
    
    let sendButton: UIButton = {
    
        let tempView = UIButton()
        tempView.hidden = true
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.setBackgroundImage(UIImage(named: "chatroom_msg_failed"), forState: .Normal)
        return tempView
        
    }()
    
    func setLayout() {
    
        //avatarImageView
        Layout().addTopConstraint(avatarImageView, toView: self.contentView, multiplier: 1, constant: questionModel!.marginTopBottomLeftOrRight)
        Layout().addWidthHeightConstraints(avatarImageView, toView: nil, multiplier: 1, constant: questionModel!.avatarWidthHeight)
        
        if self.questionModel!.isQuestionOwner! {
            
            //avatarImageView
            Layout().addLeftConstraint(avatarImageView, toView: self.contentView, multiplier: 1, constant: questionModel!.marginTopBottomLeftOrRight)
            
            //contentLabel
            Layout().addLeftToRightConstraint(contentButton, toView: avatarImageView, multiplier: 1, constant: questionModel!.marginBetweenAvatarAndContent)
            
            
        } else {
            
            //avatarImageView
            Layout().addRightConstraint(avatarImageView, toView: self.contentView, multiplier: 1, constant: -questionModel!.marginTopBottomLeftOrRight)
            
            //contentLabel
            Layout().addRightToLeftConstraint(contentButton, toView: avatarImageView, multiplier: 1, constant: -questionModel!.marginBetweenAvatarAndContent)
            
        }
        
        Layout().addTopConstraint(contentButton, toView: avatarImageView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(contentButton, toView: nil, multiplier: 0, constant: questionModel!.contentSize.height)
        Layout().addWidthConstraint(contentButton, toView: nil, multiplier: 0, constant: questionModel!.contentSize.width)
        
        
        //activityIndicatorView
        Layout().addCenterYConstraint(activityIndicatorView, toView: contentButton, multiplier: 1, constant: 0)
        Layout().addWidthHeightConstraints(activityIndicatorView, toView: nil, multiplier: 0, constant: 22)
        
        //sendButton
        Layout().addCenterYConstraint(sendButton, toView: contentButton, multiplier: 1, constant: 0)
        Layout().addWidthHeightConstraints(sendButton, toView: nil, multiplier: 0, constant: 22)
        
        if self.questionModel!.isQuestionOwner! {
            
            //activityIndicatorView
            Layout().addLeftToRightConstraint(activityIndicatorView, toView: contentButton, multiplier: 1, constant: 0)
            
            //sendButton
            Layout().addLeftToRightConstraint(sendButton, toView: contentButton, multiplier: 1, constant: 0)
            
        } else {
            
            //activityIndicatorView
            Layout().addRightToLeftConstraint(activityIndicatorView, toView: contentButton, multiplier: 1, constant: 6)
            
            //sendButton
            Layout().addRightToLeftConstraint(sendButton, toView: contentButton, multiplier: 1, constant: 6)
        }
    }
    

  
}
