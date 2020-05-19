//
//  ViewController.swift
//  ApplePie2
//
//  Created by Riad on 2/1/20.
//  Copyright © 2020 Projectum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet var player1: UILabel!
    @IBOutlet var player1Score: UILabel!
    
    @IBOutlet var player2: UILabel!
    @IBOutlet var player2Score: UILabel!
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var listOfWords = ["swift", "buccaneer"]
    //, "glorious", "incandescent", "bug", "programm"
    let incorrectMovesAllowed = 7
    
    var player1Wins = 0 {
        didSet {
            saveGameState(currentGame.isPlayer1Active)
            newRound()
        }
    }
    
    var player1Losses = 0 {
        didSet {
            saveGameState(currentGame.isPlayer1Active)
            newRound()
        }
    }
    
    var player2Wins = 0 {
        didSet {
            saveGameState(currentGame.isPlayer1Active)
            newRound()
        }
    }
    
    var player2Losses = 0 {
        didSet {
            saveGameState(currentGame.isPlayer1Active)
            newRound()
        }
    }
    
    var currentGame: Game!
    
    var whichPlayerShouldPlay: Bool = true
    
    func saveGameState(_ whichPlayer: Bool) {
        whichPlayerShouldPlay = whichPlayer
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [], isPlayer1Active: whichPlayerShouldPlay)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
        if currentGame.isPlayer1Active {
            player1.backgroundColor = .green
            player2.backgroundColor = .yellow
        } else {
            player2.backgroundColor = .green
            player1.backgroundColor = .yellow
        }
        
        player1.text = "Player 1"
        player2.text = "Player 2"
        
        player1Score.text = "Wins: \(player1Wins), Losses: \(player1Losses)"
        player2Score.text = "Wins: \(player2Wins), Losses: \(player2Losses)"
    }
    
    func updateGameState() {
        if currentGame.isPlayer1Active == true {
            if currentGame.incorrectMovesRemaining == 0 {
                player1Losses += 1
            } else if currentGame.word == currentGame.formattedWord {
                player1Wins += 1
            } else {
                updateUI()
            }
        }
        else {
            if currentGame.incorrectMovesRemaining == 0 {
                player2Losses += 1
            } else if currentGame.word == currentGame.formattedWord {
                player2Wins += 1
            } else {
                updateUI()
            }

        }
        
    }


}

