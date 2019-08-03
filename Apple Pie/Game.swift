//
//  Game.swift
//  Apple Pie
//
//  Created by Ковтун Виктор on 8/4/19.
//  Copyright © 2019 Ковтун Виктор. All rights reserved.
//

import Foundation

struct Game {
    //угадываемое слово
    var word: String
    
    //количество оставшихся попыток
    var incorrectMovesRemaining: Int
    
    //список нажатых букв
    var guessedLetters: [Character]
    
    //отображаемое слово
    var formattedWord: String{
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            } else {
                guessedWord  += "_"
            }
        }
        
        return guessedWord
    }
    
    //обработка нажатой буквы
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        
        //проверяем, содержится ли буква в слове
        if !word.contains(letter){
            //уменьшаем количество попыток
            incorrectMovesRemaining -= 1
        }
    }
    
    
}
