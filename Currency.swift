//
//  ViewController.swift
//  Calculator
//
//  Created by Ibrahim Odumas on 5/20/17.
//  Copyright © 2017 Ibrahim Odumas. All rights reserved.
//

import UIKit
import Foundation

class Currency: UIViewController
{
    
    @IBOutlet var usdFinal: UITextField!
    @IBOutlet var gbpFinal: UITextField!
    @IBOutlet var eurFinal: UITextField!
    @IBOutlet var cnyFinal: UITextField!
    @IBOutlet var zarFinal: UITextField!
    @IBOutlet var krwFinal: UITextField!
    @IBOutlet var mxnFinal: UITextField!
    @IBOutlet var jpyFinal: UITextField!
    @IBOutlet var dateFinal: UILabel!
    
    @IBAction func convert(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "USD", value: value)
    }
    
    @IBAction func convert_gbp(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "GBP", value: value)
    }
    
    
    @IBAction func convert_eur(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "EUR", value: value)
    }
    
    @IBAction func convert_cny(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "CNY", value: value)
    }
    
    @IBAction func convert_zar(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "ZAR", value: value)
    }
    
    @IBAction func convert_krw(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "KRW", value: value)
    }
    
    @IBAction func convert_mxn(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "MXN", value: value)
    }
    
    @IBAction func convert_jpy(_ sender: UITextField)
    {
        let value = Double(sender.text!) ?? 1
        print(value)
        converter(fromCur: "JPY", value: value)
    }

    func converter(fromCur: String, value: Double)
    {
        let link = "https://api.fixer.io/latest?symbols=USD,GBP,JPY,CNY,MXN,KRW,ZAR"
        let url = URL(string: link)

        var usdRate: Double = 0.0
        var gbpRate: Double = 0.0
        var jpyRate: Double = 0.0
        var cnyRate: Double = 0.0
        var mxnRate: Double = 0.0
        var krwRate: Double = 0.0
        var zarRate: Double = 0.0
        
        var eur_Result: Double = 0.0
        var usd_Result: Double = 0.0
        var gbp_Result: Double = 0.0
        var jpy_Result: Double = 0.0
        var cny_Result: Double = 0.0
        var mxn_Result: Double = 0.0
        var krw_Result: Double = 0.0
        var zar_Result: Double = 0.0
        var date_Result: String = "yyyy-MM-dd"
        
        
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
            
            //let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else
            {
                DispatchQueue.main.async()
                {
                    self.usdFinal.text = String(format: "%.4f", usd_Result)
                    self.eurFinal.text = String(format: "%.4f", eur_Result)
                    self.gbpFinal.text = String(format: "%.4f", gbp_Result)
                    self.cnyFinal.text = String(format: "%.4f", cny_Result)
                    self.jpyFinal.text = String(format: "%.4f", jpy_Result)
                    self.mxnFinal.text = String(format: "%.4f", mxn_Result)
                    self.krwFinal.text = String(format: "%.4f", krw_Result)
                    self.zarFinal.text = String(format: "%.4f", zar_Result)
                    self.dateFinal.text = date_Result
                }
                return
            }
            
            if let dictionary = json as? [String: Any]
            {
                if let conv = dictionary["date"] as? String
                {
                    date_Result = conv
                }
                
                if let nestedDictionary = dictionary["rates"] as? [String: Any]
                {
                    if let conv = nestedDictionary["USD"] as? Double
                    {
                        usdRate = conv
                    }
                    
                    if let conv = nestedDictionary["GBP"] as? Double
                    {
                        gbpRate = conv
                    }
                    
                    if let conv = nestedDictionary["JPY"] as? Double
                    {
                        jpyRate = conv
                    }
                    
                    if let conv = nestedDictionary["CNY"] as? Double
                    {
                        cnyRate = conv
                    }
                    
                    if let conv = nestedDictionary["MXN"] as? Double
                    {
                        mxnRate = conv
                    }
                    
                    if let conv = nestedDictionary["KRW"] as? Double
                    {
                        krwRate = conv
                    }
                    
                    if let conv = nestedDictionary["ZAR"] as? Double
                    {
                        zarRate = conv
                    }
                    
                    switch fromCur
                    {
                        case "USD":
                            gbp_Result = value * gbpRate / usdRate
                            eur_Result = value / usdRate
                            usd_Result = value
                            jpy_Result = value * jpyRate / usdRate
                            cny_Result = value * cnyRate / usdRate
                            mxn_Result = value * mxnRate / usdRate
                            krw_Result = value * krwRate / usdRate
                            zar_Result = value * zarRate / usdRate
                        
                        case "GBP":
                            gbp_Result = value
                            eur_Result = value / gbpRate
                            usd_Result = value * usdRate / gbpRate
                            jpy_Result = value * jpyRate / gbpRate
                            cny_Result = value * cnyRate / gbpRate
                            mxn_Result = value * mxnRate / gbpRate
                            krw_Result = value * krwRate / gbpRate
                            zar_Result = value * zarRate / gbpRate
                        
                        case "EUR":
                            gbp_Result = value * gbpRate
                            eur_Result = value
                            usd_Result = value * usdRate
                            jpy_Result = value * jpyRate
                            cny_Result = value * cnyRate
                            mxn_Result = value * mxnRate
                            krw_Result = value * krwRate
                            zar_Result = value * zarRate
                        
                        case "JPY":
                            gbp_Result = value * gbpRate / jpyRate
                            eur_Result = value / jpyRate
                            usd_Result = value * usdRate / jpyRate
                            jpy_Result = value
                            cny_Result = value * cnyRate / jpyRate
                            mxn_Result = value * mxnRate / jpyRate
                            krw_Result = value * krwRate / jpyRate
                            zar_Result = value * zarRate / jpyRate
                        
                        case "CNY":
                            gbp_Result = value * gbpRate / cnyRate
                            eur_Result = value / cnyRate
                            usd_Result = value * usdRate / cnyRate
                            jpy_Result = value * jpyRate / cnyRate
                            cny_Result = value
                            mxn_Result = value * mxnRate / cnyRate
                            krw_Result = value * krwRate / cnyRate
                            zar_Result = value * zarRate / cnyRate
                        
                        case "MXN":
                            gbp_Result = value * gbpRate / mxnRate
                            eur_Result = value / mxnRate
                            usd_Result = value * usdRate / mxnRate
                            jpy_Result = value * jpyRate / mxnRate
                            cny_Result = value * cnyRate / mxnRate
                            mxn_Result = value
                            krw_Result = value * krwRate / mxnRate
                            zar_Result = value * zarRate / mxnRate
                        
                        case "KRW":
                            gbp_Result = value * gbpRate / krwRate
                            eur_Result = value / krwRate
                            usd_Result = value * usdRate / krwRate
                            jpy_Result = value * jpyRate / krwRate
                            cny_Result = value * cnyRate / krwRate
                            mxn_Result = value * mxnRate / krwRate
                            krw_Result = value
                            zar_Result = value * zarRate / krwRate
                        
                        case "ZAR":
                            gbp_Result = value * gbpRate / zarRate
                            eur_Result = value / zarRate
                            usd_Result = value * usdRate / zarRate
                            jpy_Result = value * jpyRate / zarRate
                            cny_Result = value * cnyRate / zarRate
                            mxn_Result = value * mxnRate / zarRate
                            krw_Result = value * krwRate / zarRate
                            zar_Result = value
                        
                        default: break
                    }
                    
                    
                    DispatchQueue.main.async()
                    {
                        self.usdFinal.text = String(format: "%.4f", usd_Result)
                        self.eurFinal.text = String(format: "%.4f", eur_Result)
                        self.gbpFinal.text = String(format: "%.4f", gbp_Result)
                        self.cnyFinal.text = String(format: "%.4f", cny_Result)
                        self.jpyFinal.text = String(format: "%.4f", jpy_Result)
                        self.mxnFinal.text = String(format: "%.4f", mxn_Result)
                        self.krwFinal.text = String(format: "%.4f", krw_Result)
                        self.zarFinal.text = String(format: "%.4f", zar_Result)
                        self.dateFinal.text = date_Result
                    }
                }
            }
        }
        
        task.resume()
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

