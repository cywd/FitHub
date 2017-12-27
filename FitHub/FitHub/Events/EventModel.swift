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
    var type: String?
    
    var actor: UserModel?
    var repo: RepositoryModel?
    // -------------------------
    var payload : PayloadModel?
    var isPublic: Bool = false
    var created_at: String?
    // -----------------------
    var org: OrgModel?
    
    var desc: String?
    
    var finDesc: String?
    
    var descAttr = NSMutableAttributedString()
    var finAttributeString = NSMutableAttributedString()
//    var finAttributeData: Data?
    
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

extension EventModel {
    
    func eventWrap() -> EventModel {
        let login = self.actor?.login
        let repoName = self.repo?.name

        let loginAttr = NSAttributedString(string: login!, attributes: [NSAttributedStringKey.link : URL(string: "fithub-name://\(login!)")!])
        let repoNameAttr = NSAttributedString(string: repoName!, attributes: [NSAttributedStringKey.link : URL(string: "fithub-repo://\(repoName!)")!])
        
        finAttributeString.append(loginAttr)
        
        if let ttype = self.type {
            switch ttype {
            case EventModel.CommitCommentEvent:
                desc = " commented on commit "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.CreateEvent:
                desc = " created a repository "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.DeleteEvent:
                desc = " delete "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.DeploymentEvent:
                desc = " deployment "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.DeploymentStatusEvent:
                desc = " commented on commit "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.IssueCommentEvent:
                let issue = "#" + "\(self.payload?.issue?.number ?? 0)"
                desc = " comment on issue " + issue + " in "
                let issueAttr = NSAttributedString(string: issue, attributes: [NSAttributedStringKey.link : URL(string: "")!])
                let aAttr = NSAttributedString(string: " comment on issue ")
                let bAttr = NSAttributedString(string: " in ")
                descAttr.append(aAttr)
                descAttr.append(issueAttr)
                descAttr.append(bAttr)
                finAttributeString.append(descAttr)
                break
            case EventModel.IssuesEvent:
                let action = (self.payload?.action ?? "")
                let issue = "#" + "\(self.payload?.issue?.number ?? 0)"
                let issueUrl = self.payload?.issue?.url
                desc = " " + action + " issue " + issue + " in "
                let actionAttr = NSAttributedString(string: action)
                let issueAttr = NSAttributedString(string: issue, attributes: [NSAttributedStringKey.link : URL(string: "fithub-issue://\(issueUrl ?? "")")!])
                let aAttr = NSAttributedString(string: " ")
                let bAttr = NSAttributedString(string: " issue ")
                let cAttr = NSAttributedString(string: " in ")
                descAttr.append(aAttr)
                descAttr.append(actionAttr)
                descAttr.append(bAttr)
                descAttr.append(issueAttr)
                descAttr.append(cAttr)
                finAttributeString.append(descAttr)
                break
            case EventModel.MemberEvent:
                desc = " member "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.MembershipEvent:
                desc = " membership "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.PullRequestEvent:
                var action = self.payload?.action ?? ""
                if "closed" == self.payload?.action {
                    action = "merged"
                }
                desc = " \(action) "
                
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.PullRequestReviewCommentEvent:
                desc = " pull request review comment "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.PushEvent:
                desc = " push to master at "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.RepositoryEvent:
                desc = " repository "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.TeamAddEvent:
                desc = " team add "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.WatchEvent:
                desc = " " + (self.payload?.action ?? "") + " "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            case EventModel.ForkEvent:
                let ttt = self.payload!.forkee!.full_name!
                let repoAttr = NSAttributedString(string: ttt, attributes: [NSAttributedStringKey.link : URL(string: "fithub-repo://\(ttt)")!])
                let aAttr = NSAttributedString(string: " forked ")
                let bAttr = NSAttributedString(string: " from ")
                descAttr.append(aAttr)
                descAttr.append(repoAttr)
                descAttr.append(bAttr)
                finAttributeString.append(descAttr)
                break
            default:
                desc = " unspport event item "
                descAttr = NSMutableAttributedString(string: desc!)
                finAttributeString.append(descAttr)
                break
            }
        }
        
        finAttributeString.append(repoNameAttr)
        
        finAttributeString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, finAttributeString.length))
        
        return self
    }
    
}
