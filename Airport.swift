//
//  metric_ViewController.swift
//  Calculator
//
//  Created by Ibrahim Odumas on 5/28/17.
//  Copyright © 2017 Ibrahim Odumas. All rights reserved.
//

import UIKit

class Airport: UIViewController
{
    
    @IBOutlet var desc_Final: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var delay: UILabel!
    @IBOutlet var temp: UILabel!
    
    @IBAction func getStatus(_ sender: UITextField)
    {
        var code = sender.text!
        if code == ""
        {
            code = "JFK"
        }
        
        if code.characters.count != 3
        {
            desc_Final.text = "Invalid Code! e.g JFK"
            clearLabel()
            return
        }
        
        var name_: String = ""
        var time_: String = ""
        var type_: String = ""
        var delay_: String = ""
        var temp_: String = ""
        var codeChk: String = ""
        
        let link = "https://services.faa.gov/airport/status/" + code + "?format=application/json"
        let url = URL(string: link)
        
        let task = URLSession.shared.dataTask(with: url!)
        {
            data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else
            {
                DispatchQueue.main.async()
                {
                    self.desc_Final.text = "Status not available!"
                    self.clearLabel()
                }
                return
            }
            
            if let dictionary = json as? [String: Any]
            {
                if let conv = dictionary["IATA"] as? String
                {
                    codeChk = conv
                }
                
                if let conv = dictionary["name"] as? String
                {
                    name_ = conv
                }
                
                if let conv = dictionary["delay"] as? String
                {
                    if conv == "true"
                    {
                        if let nestedDictionary_status = dictionary["status"] as? [String: Any]
                        {
                            if let conv = nestedDictionary_status["type"] as? String
                            {
                                type_ = conv
                            }
                            
                            if let conv = nestedDictionary_status["reason"] as? String
                            {
                                type_ = "Type: " + type_ + " - " +  conv
                            }
                            
                            if let conv = nestedDictionary_status["avgDelay"] as? String
                            {
                                delay_ = "Delay Time: " + conv
                            }
                        }
                    }
                    else
                    {
                        delay_ = "No Delay"
                        type_ = ""
                    }
                }
                
                if let nestedDictionary_weather = dictionary["weather"] as? [String: Any]
                {
                    if let conv = nestedDictionary_weather["temp"] as? String
                    {
                        temp_ = "Temp: " + conv
                    }
                    
                    if let nestedDictionary_meta = nestedDictionary_weather["meta"] as? [String: Any]
                    {
                        if let conv = nestedDictionary_meta["updated"] as? String
                        {
                            time_ = "Updated Time: " + conv
                        }
                    }
                }
            }
            
            DispatchQueue.main.async()
            {
                if codeChk != code
                {
                    self.desc_Final.text = "Invalid Code! e.g JFK"
                    self.clearLabel()
                    return
                }
                
                self.name.text = name_
                self.delay.text = delay_
                self.temp.text = temp_
                self.time.text = type_
                self.type.text = time_
                self.desc_Final.text = ""
            }
        }

        task.resume()
        
    }
    
    func clearLabel()
    {
        name.text = ""
        time.text = ""
        type.text = ""
        delay.text = ""
        temp.text = ""
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
