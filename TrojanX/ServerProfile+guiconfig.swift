//
//  ServerProfile+guiconfig.swift
//  TrojanX for gui-config.json support
//
//  Created by zhsoft88 on 2020/4/4.
//  Copyright © 2020 zhuatang.com. All rights reserved.
//

import Foundation

extension ServerProfile {

  static func fromGuiConfig(_ config: [String:Any]) -> ServerProfile? {
    if let server = config["server"] as? String,
      let server_port = config["server_port"] as? UInt16,
      let password = config["password"] as? String {
      let profile = ServerProfile()
      profile.serverHost = server
      profile.serverPort = server_port
      profile.password = password
      profile.remark = config["remarks"] as? String ?? ""
      return profile
    }
    return nil
  }

  static func profilesFromGuiConfigJson(_ data: Data) -> [ServerProfile] {
    var profiles = [ServerProfile]()
    if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()),
      let dict = json as? [String:Any],
      let configs = dict["configs"] as? [[String:Any]],
      !configs.isEmpty {
      for config in configs {
        if let profile = fromGuiConfig(config) {
          profiles.append(profile)
        }
      }
    }
    return profiles
  }

}
