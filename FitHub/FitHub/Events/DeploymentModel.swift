//
//  DeploymentModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class DeploymentModel: NSObject {
    var id: Int = 0
    var url: String?
    var sha: String?
    var ref: String?
    var task: String?
    var environment: String?
    var desc: String?
    var created_at: String?
    var updated_at: String?
    var statuses_url: String?
    var repository_url: String?
    var payload: String?
    var creator: UserModel?

}

class DeploymentStatusModel: NSObject {
    var id: Int = 0
    var url: String?
    var state: String?
    var desc: String?
    var target_url: String?
    var created_at: String?
    var updated_at: String?
    var repository_url: String?
    var deployment_url: String?
    var creator: UserModel?
    
}
