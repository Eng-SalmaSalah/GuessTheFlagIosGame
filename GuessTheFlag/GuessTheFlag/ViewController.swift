//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Salma Salah on 2/9/20.
//  Copyright © 2020 Salma Salah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flagOneBtn: UIButton!
    @IBOutlet weak var flagTwoBtn: UIButton!
    @IBOutlet weak var flagThreeBtn: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initCountriesArray()
        adjustFlagsAppearence()
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Score", style: .plain, target: self, action: #selector(showScore))
        
    }
    
    func initCountriesArray(){
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func adjustFlagsAppearence(){
        flagOneBtn.layer.borderWidth = 1
        flagTwoBtn.layer.borderWidth = 1
        flagThreeBtn.layer.borderWidth = 1
        
        flagOneBtn.layer.borderColor = UIColor.lightGray.cgColor
        flagTwoBtn.layer.borderColor = UIColor.lightGray.cgColor
        flagThreeBtn.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    func askQuestion(action : UIAlertAction! = nil){ // we added this param to call this method in action handler of the alert btn , it sets uialert as nil if not received as default value
        if counter == 10{
            let scoreAlert = UIAlertController(title: "Score", message: "Your Final Score is \(score) out of 10", preferredStyle: .alert)
            scoreAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: resetGame))
            title = "Your Score :\(score)"
            present(scoreAlert, animated: true)
            return
        }
        // to show different flags each time
        countries.shuffle()
        
        //to show the name of the country to select as title
        correctAnswer = Int.random(in: 0...2)
        let countryToSelect = countries[correctAnswer].uppercased()
        title = "Your Score :\(score) - select \(countryToSelect)'s flag"
        
        flagOneBtn.setImage(UIImage(named: countries[0]), for: .normal)
        flagTwoBtn.setImage(UIImage(named: countries[1]), for: .normal)
        flagThreeBtn.setImage(UIImage(named: countries[2]), for: .normal)

    }
    
    func resetGame (action : UIAlertAction!){
        counter = 0
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonPressedAction(_ sender: UIButton) {
        counter += 1
        var title : String?
        var alertBody : String?
        if sender.tag == correctAnswer{
            title = "Correct!"
            alertBody = "Yes!,that is the flag of \(countries[correctAnswer].uppercased())"
            score += 1
        }else{
            title = "Wrong!"
            alertBody = "No!,that is the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
//        let alertController = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
        let alertController = UIAlertController(title: title, message: alertBody, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) //here we path only the name of the function to run when btn pressed , don't call the method askQuestion() bec if we do this it means call the method askQuestion now to get the name of the method to run when btn pressed
        present(alertController, animated: true)
    }
    
    @objc func showScore (){
        let scoreAlert = UIAlertController(title: "Your Score", message: "Your Current Score \(score)", preferredStyle: .alert)
        scoreAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(scoreAlert,animated: true)
    }
    

}

