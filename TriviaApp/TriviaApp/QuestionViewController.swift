//
//  QuestionViewController.swift
//  TriviaApp
//
//  Created by Sumit Nalavade on 11/25/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
        
    var questions:[Any] = []
    var totalQuestions: Int = 0
    var correctQuestions: Int = 0
    var isCorrect: Bool = true
    @IBOutlet weak var mainVStack: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalQuestions = questions.count
        
        setGradient()
        
        getNextQuestion()
    }
    
    /*
     Pop a new question from the questions array
     Create and suffle and array of answers, create buttons corresponding to each
     Call the createQuestionLabel function to change the text of the questionLabel
    */
    func getNextQuestion() {
        clearView()
        
        isCorrect = true
        
        guard questions.count > 0 else {
            displayResults()
            return
        }
        let newQuestion: [String:Any] = questions.popLast() as! [String : Any]
        
        createQuestionLabel(text: (newQuestion) ["question"] as! String)
        
        let correctAnswer = (newQuestion ) ["correct_answer"] as! String
        
        var answers = (newQuestion ) ["incorrect_answers"] as! [String]
        answers.append(correctAnswer)
        answers.shuffle()
        
        answers.forEach { answer in
            if(answer == correctAnswer) {
                createAnswerButton(text: answer, correctAnswer: true)
            } else {
                createAnswerButton(text: answer, correctAnswer: false)
            }
        }
    }
    
    func clearView() {
        questionLabel.text = ""
        
        for view in buttonsStackView.subviews{
            view.removeFromSuperview()
        }
    }
    
    func createQuestionLabel(text: String) {
        questionLabel.text = convertSpecialCharacters(string: text)
    }
    
    func createAnswerButton(text: String, correctAnswer: Bool) {
        let answerChoice = UIButton(type: .system)
        answerChoice.setTitleColor(.black, for: .normal)
        answerChoice.setTitle(convertSpecialCharacters(string: text), for: .normal)
        answerChoice.backgroundColor = .white
        answerChoice.layer.cornerRadius = 5
        
        if(correctAnswer) {
            answerChoice.addTarget(self, action: #selector(correctAnswerClicked(_:)), for: .touchUpInside)
        } else {
            answerChoice.addTarget(self, action: #selector(wrongAnswerClicked(_:)), for: .touchUpInside)
        }
        
        buttonsStackView.addArrangedSubview(answerChoice)
    }
    
    /*
     Set the color of the UIButton to green
     
     Increment the correctQuestions variable by one if a wrong answer hasn't been chosen
    */
    @objc func correctAnswerClicked(_ sender: UIButton) {
        sender.setTitleColor(.green, for: .normal)
        
        if(isCorrect) {
            correctQuestions += 1
        }
        
        getNextQuestion()
    }
    
    /*
     Set the color of the UIButton to red
     
     Change the isCorrect variable to false because a wrong answer has been chosen.
        This will prevent the correctQuestions variable from being incremented when a correct answer is chosen
    */
    @objc func wrongAnswerClicked(_ sender: UIButton) {
        sender.setTitleColor(.red, for: .normal)
        
        isCorrect = false
    }
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, UIColor(red: 37/160, green: 127/130, blue: 233/238, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func displayResults() {
        let vc = self.storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
        
        vc.correctQuestions = correctQuestions
        vc.totalQuestions = totalQuestions
        
        present(vc, animated: true)
    }
    
    func dismissVC() {
        dismiss(animated: true)
    }
    
    func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&amp;" : "&",
            "&lt;" : "<",
            "&gt;" : ">",
            "&quot;" : "\"",
            "&apos;" : "'",
            "&#039;" : "'"
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
}
