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
    @IBOutlet weak var mainVStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradient()
        
        getNextQuestion()
    }
    
    func getNextQuestion() {
        
        for view in mainVStack.subviews{
            view.removeFromSuperview()
        }
        
        var newQuestion: [String:Any]
        guard questions.count > 0 else { return }
        newQuestion = questions.popLast() as! [String : Any]
        
        createQuestionLabel(text: (newQuestion ) ["question"] as! String)
        
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
    
    func createQuestionLabel(text: String) {
        let questionLabel = UILabel()
        questionLabel.numberOfLines = 10
        questionLabel.textColor = .white
        questionLabel.textAlignment = .center
        questionLabel.font = questionLabel.font.withSize(20)
        questionLabel.text = text
        
        mainVStack.addArrangedSubview(questionLabel)
    }
    
    func createAnswerButton(text: String, correctAnswer: Bool) {
        let answerChoice = UIButton(type: .system)
        answerChoice.setTitleColor(.white, for: .normal)
        answerChoice.setTitle(text, for: .normal)
        
        if(correctAnswer) {
            answerChoice.addTarget(self, action: #selector(correctAnswerClicked(_:)), for: .touchUpInside)
        } else {
            answerChoice.addTarget(self, action: #selector(wrongAnswerClicked(_:)), for: .touchUpInside)
        }
        
        mainVStack.addArrangedSubview(answerChoice)
    }
    
    @objc func correctAnswerClicked(_ sender: UIButton) {
        sender.setTitleColor(.green, for: .normal)
        
        getNextQuestion()
    }
    
    @objc func wrongAnswerClicked(_ sender: UIButton) {
        sender.setTitleColor(.red, for: .normal)
    }
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, UIColor(red: 37/160, green: 127/130, blue: 233/238, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
