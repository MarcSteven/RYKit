//
//  JSONUtils.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation

/// JSON 工具
public struct JSONUtil {
    /// Automatically detect and load the JSON from local(mainBundle) or a remote url.
    public static func remoteOrLocalJSONFile(_ named: String, callback: @escaping ((Any?) -> Void)) {
        if let url = URL(string: named), url.host != nil {
            DispatchQueue.global().async {
                let json = self.parse(url)
                DispatchQueue.main.async {
                    callback(json)
                }
            }
        } else {
            DispatchQueue.global().async {
                let json = self.parse(filename: named)
                DispatchQueue.main.async {
                    callback(json)
                }
            }
        }
    }

    /// Parse local JSON file from `Bundle.main`.
    public static func parse(filename: String, bundle: Bundle = .main) -> Any? {
        guard
            let filePath = bundle.path(forResource: filename.deletingPathExtension, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        else {
            return nil
        }

        return parse(data)
    }

    /// Parse remote JSON file.
    public static func parse(_ url: URL) -> Any? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }

        return parse(data)
    }

    /// Parse Data to JSON.
    public static func parse(_ data: Data) -> Any? {
        try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }

    /// Parse String to JSON.
    public static func parse(jsonString: String) -> Any? {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }

    /// Convert value to a JSON string.
    @available(iOS 11.0, *)
    public static func stringify(_ value: Any, prettyPrinted: Bool = false) -> String {
        guard
            let data = serialize(value, prettyPrinted: prettyPrinted),
            let string = String(data: data, encoding: .utf8)
        else {
            return ""
        }

        return string
    }

    /// Serialize value to `Data`.
    
  
    @available(iOS 11.0, *)
    //MARK: - serialize the json to data
    public static func serialize(_ value: Any, prettyPrinted: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(value) else {
            Console.error("Invalid JSON Object.")
            return nil
        }
            var options: JSONSerialization.WritingOptions = .sortedKeys
            if prettyPrinted {
                options.insert(.prettyPrinted)
            }
            return try? JSONSerialization.data(withJSONObject: value, options: options)
        }
}




