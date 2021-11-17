//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nalavade, Sumit S on 11/16/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
     1. Outlets for on screen elements
     */
    @IBOutlet weak var initiBillField: UITextField!
    @IBOutlet weak var tipAmountControl: UISegmentedControl!
    @IBOutlet weak var finalTipLabel: UILabel!
    @IBOutlet weak var finalTotalLabel: UILabel!
    @IBOutlet weak var otherField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        initiBillField.addTarget(self, action: #selector(valuesChanged), for: .editingChanged)
        tipAmountControl.addTarget(self, action: #selector(valuesChanged), for: .valueChanged)
        otherField.addTarget(self, action: #selector(valuesChanged), for: .editingChanged)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
     
    }
    
    /*
     2. Function is called whenever the value of the billField or the segmentedControl is changed
        Verifies if the billField is not an empty string and calls the calcTip and updateDisplay function
     */
    @objc func valuesChanged() {
        var billAmount : Double
         var tipAmount : Double
                         
         switch tipAmountControl.selectedSegmentIndex {
         case 0:
             tipAmount = 0.15
         case 1:
             tipAmount = 0.18
         case 2:
             tipAmount = 0.20
         case 3:
             tipAmount = 0.25
         default:
             tipAmount = 0.00
         }
        
        if(otherField.text != "") {
            tipAmount = (Double(otherField.text!) ?? 0) / 100
        }
            
        /*
         3. Guard clause to verifiy that the value of the segementedControl is not an empty string
            Force unwraps the billField text as a Double and assigns a 0 if the type casting fails
         */
        
        if(initiBillField.text != "") {
            billAmount = Double(initiBillField.text!) ?? 0
            
            let finalBill = calcTip(billAmount: billAmount, tipAmount: tipAmount)
            
            updateDisplay(finalTip: finalBill["finalTip"]!, finalTotal: finalBill["finalTotal"]!)
            
        }
                
    }
    
    /*
     4. Calculates the tip and finaltotal and retuns and dictionary
     */
    func calcTip(billAmount: Double, tipAmount: Double) -> [String:Double] {
        let finalTip = billAmount * tipAmount
        let finalTotal = billAmount + finalTip
                
        return ["finalTip":finalTip, "finalTotal":finalTotal]
    }

    /*.
     5. Updated the finalTipLabel and finalTotalLabel on screen elements after formatting the finalTip and finalTotal with a dollar sign and decimal
     */
    func updateDisplay(finalTip: Double, finalTotal: Double) {
        finalTipLabel.text = "$\(String(format: "%.2f", finalTip))"
        finalTotalLabel.text = "$\(String(format: "%.2f", finalTotal))"
    }

    @objc func reset() {
        initiBillField.text = ""
        otherField.text = ""
        tipAmountControl.selectedSegmentIndex = 0
        finalTipLabel.text = "$0.00"
        finalTotalLabel.text = "$0.00"
    }
}

