//
//  ViewController.swift
//  TriviaApp
//
//  Created by Sumit Nalavade on 11/24/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var numQuestionsPickerView: UIPickerView!
    @IBOutlet weak var beginButton: UIButton!
    
    var categories: [String:Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradient()
        
        getCategories { (array) in
            array.forEach { category in
                let name = (category as! [String:Any]) ["name"] as! String
                let id = (category as! [String:Any]) ["id"] as! Int
                
                self.categories[name] = id
            }
            
            DispatchQueue.main.async {
                self.setPickerView()
            }
        }
        
        beginButton.addTarget(self, action: #selector(begin), for: .touchUpInside)
    }
    
    @objc func begin() {
        let category = String(Array(categories.values)[categoryPickerView.selectedRow(inComponent: 0)])
        
        let numQuestions = String((numQuestionsPickerView.selectedRow(inComponent: 0)) + 1)
        
        print(category, numQuestions)
        
        getQuestion(category: category, amount: numQuestions, { (array) in
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
                       
            vc.questions = array as! [Any]
                       
            self.present(vc, animated: true)
            }
        })
    }
    
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, UIColor(red: 37/160, green: 127/130, blue: 233/238, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setPickerView() {
        let pickerViews: [UIPickerView] = [categoryPickerView, numQuestionsPickerView]
        
        for pickerView in pickerViews {
            pickerView.setValue(UIColor.white, forKey: "textColor")
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }
    
    func getCategories(_ completion: @escaping (NSArray) -> ()) {
           let urlPath = "https://opentdb.com/api_category.php"

           guard let url = URL(string: urlPath) else { return }

           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let data = data else { return }
               do {
                   if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                       let results = jsonResult["trivia_categories"] as! NSArray
                        completion(results)
                   }
               } catch {
                   
               }
           }
           task.resume()
       }
    
    func getQuestion(category: String, amount: String, _ completion: @escaping (NSArray) -> ()) {
        let urlPath = "https://opentdb.com/api.php?amount=\(amount)&category=\(category)"

        guard let url = URL(string: urlPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let results = jsonResult["results"] as! NSArray
                     completion(results)
                }
            } catch {
                
            }
        }
        task.resume()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 0) {
            return categories.count
        }
        
        return 10
    }
}
   
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 0) {
            return Array(categories.keys)[row]
        }
        
        return String(row + 1)
    }
    
}

