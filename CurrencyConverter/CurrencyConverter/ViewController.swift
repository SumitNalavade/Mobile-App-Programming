//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Sumit Nalavade on 11/20/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     1. Outlets for UIKit components
     */
    @IBOutlet weak var convertedLabel: UILabel!
    @IBOutlet weak var fromSegmentedControl: UISegmentedControl!
    @IBOutlet weak var toSegmentedControl: UISegmentedControl!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var initValue: UITextField!
    @IBOutlet weak var fromOtherTextField: UITextField!
    @IBOutlet weak var toOtherTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         2. Call the changeConvertedLabelValue when the convert button is tapped
         */
        convertButton.addTarget(self, action: #selector(changeConvertedLabelValue), for: .touchUpInside)
    }
    
    /*
     3. Fetches the conversion rate from the API using the from currency code and the to currency code
     
        Returns a double corresponding to the conversion rate
     */
    @objc func getConversionRate(_ completion: @escaping (Double) -> ()) {
                
        var from : String
        var to : String
        
        if(fromOtherTextField.text != "") {
            from = fromOtherTextField.text!
        } else {
            from = fromSegmentedControl.titleForSegment(at: fromSegmentedControl.selectedSegmentIndex)!
        }
        
        if(toOtherTextField.text != "") {
            to = toOtherTextField.text!
        } else {
            to = toSegmentedControl.titleForSegment(at: toSegmentedControl.selectedSegmentIndex)!
        }
                                
        let urlPath = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/\(from.lowercased())/\(to.lowercased()).json"

        guard let url = URL(string: urlPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let results = jsonResult[to.lowercased()] as! Double
                    completion(results)
                }
            } catch {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Invalid Currency Codes", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true)
                }

                completion(0)
            }
        }
        task.resume()
    }
    
    /*
     4. Calls the getConversionRate function and uses the return value to set the new value of the big label
     */
    @objc func changeConvertedLabelValue () {
        let value = Double(initValue.text!)
        
        getConversionRate { (rate) in
            DispatchQueue.main.async {
                self.convertedLabel.text = String(format: "%.2f", rate * value!)
            }
        }
    }
}

