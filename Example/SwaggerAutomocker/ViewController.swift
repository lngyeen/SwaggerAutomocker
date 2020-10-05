//
//  ViewController.swift
//  SwaggerAutomocker
//
//  Created by lngyeen on 05/06/2020.
//  Copyright (c) 2020 lngyeen. All rights reserved.
//

import UIKit
import SwaggerAutomocker

class ViewController: UIViewController {
    var mockServer: MockServer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let json = readJSONFromFile(fileName: "swagger")
        if let json = json {
            mockServer = MockServer(port: 8080, swaggerJson: json)
            mockServer?.start()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func readJSONFromFile(fileName: String) -> [String: Any]? {
        var json: Any?
        
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                } catch {
                    print("Error!! Unable to parse \(fileName).json")
                }
            } catch {
                print("Error!! Unable to load \(fileName).json")
            }
        }
        return json as? [String : Any]
    }
}

