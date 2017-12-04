//
//  EventModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/29.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class EventModel: NSObject {
    
    var id: Int = 0
    var type: String? {
        didSet {
            
            switch type {
            case EventModel.CommitCommentEvent?:
                desc = " commented on commit"
                break
            case EventModel.CreateEvent?:
                desc = " create"
                break
            case EventModel.DeleteEvent?:
                desc = " delete"
                break
            case EventModel.DeploymentEvent?:
                desc = " deployment"
                break
            case EventModel.DeploymentStatusEvent?:
                desc = " commented on commit"
                break
            case EventModel.IssueCommentEvent?:
                desc = " comment on issue"
                break
            case EventModel.IssuesEvent?:
                desc = " issue"
                break
            case EventModel.MemberEvent?:
                desc = " member"
                break
            case EventModel.MembershipEvent?:
                desc = " membership"
                break
            case EventModel.PullRequestEvent?:
                desc = " PullRequestEvent"
                break
            case EventModel.PullRequestReviewCommentEvent?:
                desc = " pull request review comment"
                break

            case EventModel.PushEvent?:
                desc = " push to"
                break
            case EventModel.RepositoryEvent?:
                desc = " repository"
                break
            case EventModel.TeamAddEvent?:
                desc = " team add"
                break
            case EventModel.WatchEvent?:
                desc = " "
                break
            case EventModel.ForkEvent?:
                desc = " forked"
                break
            default:
                desc = " unspport event item"
                break
            }
        }
    }
    
    var actor: UserModel?
    var repo: RepositoryModel?
    // -------------------------
    var payload : PayloadModel?
    var isPublic: Bool = false
    var created_at: String?
    // -----------------------
    var org: OrgModel?
    
    var desc: String?
    
    
    // ---------------------------
    static let CommitCommentEvent = "CommitCommentEvent"
    static let CreateEvent = "CreateEvent"
    static let DeleteEvent = "DeleteEvent"
    static let DeploymentEvent = "DeploymentEvent"
    static let DeploymentStatusEvent = "DeploymentStatusEvent"
    static let IssueCommentEvent = "IssueCommentEvent"
    static let DownloadEvent = "DownloadEvent"
    static let IssuesEvent = "IssuesEvent"
    static let MemberEvent = "MemberEvent"
    static let MembershipEvent = "MembershipEvent"
    static let PullRequestEvent = "PullRequestEvent"
    static let PullRequestReviewCommentEvent = "PullRequestReviewCommentEvent"
    static let PushEvent = "PushEvent"
    static let RepositoryEvent = "RepositoryEvent"
    static let TeamAddEvent = "TeamAddEvent"
    static let WatchEvent = "WatchEvent"
    static let ForkEvent = "ForkEvent"
    // ---------------------------
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "actor" {
            self.actor = UserModel(dict: value as! [String : AnyObject])
        } else if key == "repo" {
            self.repo = RepositoryModel(dict: value as! [String : AnyObject])
        } else if key == "org" {
            self.org = OrgModel(dict: value as! [String: AnyObject])
        } else if key == "payload" {
            self.payload = PayloadModel(dict: value as! [String: AnyObject])
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
        
    }

}
