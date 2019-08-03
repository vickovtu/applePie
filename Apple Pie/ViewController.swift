//
//  ViewController.swift
//  Apple Pie
//
//  Created by Ковтун Виктор on 8/3/19.
//  Copyright © 2019 Ковтун Виктор. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //слова для угадывания
    var listOfWords = [
        "абруз",
        "банан",
        "вертолет",
        "домик"
    ]
    
    //количество попыток
    let incorrectMovesAllowed = 7
    //количество выигрышей
    var totalWims = 0 {
        didSet{
            newRound()
        }
    }
    //количество проигрышей
    var totalLoses = 0 {
        didSet{
            newRound()
        }
    }
    
    var currentGame: Game!

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWorldLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    //запуск нового райнда игры
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetteButtons(true)
        } else{
            enableLetteButtons(false)
        }
         updateUI()
    }

    
    //разрешить/запретить кнопки
    func enableLetteButtons ( _ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    //обновляем интерфейса
    func updateUI(){
        //обновляем картинку
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        treeImageView.image = image
        
        // обновляем угадавоемое слово
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        correctWorldLabel.text = wordWithSpaces
        
        //обновляем счет
        ScoreLabel.text = "Выигрыши : \(totalWims), проигрыши: \(totalLoses)"
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    
    //проверяем на окончание игры
    func updateGameState(){
        if currentGame.incorrectMovesRemaining < 1 {
            //проиграли раунд
            totalLoses += 1
        }else if currentGame.word == currentGame.formattedWord {
            //выиграли раунд
            totalWims += 1
        } else {
            updateUI()
        }
    }
        
    
    
    
    
    
}

