//
//  ViewController.swift
//  TicTacToe
//
//  Created by Julien Noël on 24/06/2019.
//  Copyright © 2019 Julien Noël. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var player1 = true
    var player2 = false
    
    // false -> not occuped, true -> occuped
    var buttons:  [Bool] = {
        var array = [Bool]()
        for _ in 0...8 {
            array.append(false)
        }
        return array
    }()
    
    // 0 -> aucun joueur, 1 -> cross, 2 -> circle
    var filledArray:  [Int] = {
        var array = [Int]()
        for _ in 0...8 {
            array.append(0)
        }
        return array
    }()
    
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var equalityLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
        winnerImageView.isHidden = true
        equalityLabel.isHidden = true
    }
    
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        
        if buttons[sender.tag] == false {
            if player1 == true && player2 == false {
                setBox(button: sender, player: 1)
                filledArray[sender.tag] = 1
            } else if player1 == false && player2 == true {
                setBox(button: sender, player: 2)
                filledArray[sender.tag] = 2
            } else {
                print("Erreur : les deux joueurs ne peuvent pas jouer en même temps")
            }
            
            if let winner = testWin() {
                if winner == 1 {
                    winnerImageView.image = UIImage(named: "circle")
                    for i in 0...8 {
                        if buttons[i] == false {
                            buttons[i] = true
                        }
                    }
                } else {
                    winnerImageView.image = UIImage(named: "cross")
                    for i in 0...8 {
                        if buttons[i] == false {
                            buttons[i] = true
                        }
                    }
                }
                winnerImageView.isHidden = false
                winnerLabel.isHidden = false
            }
            if nobodyWin() {
                equalityLabel.isHidden = false
            }
            
            player1 = !player1
            player2 = !player2
            buttons[sender.tag] = true
        } else {
            print("Erreur : la case est déjà occupé")
        }
    }
    
    @IBAction func replay(_ sender: UIButton) {
        for i in 0...8 {
            buttons[i] = false
            filledArray[i] = 0
        }
        winnerLabel.isHidden = true
        winnerImageView.isHidden = true
        equalityLabel.isHidden = true
        button1.setBackgroundImage(nil, for: .normal)
        button2.setBackgroundImage(nil, for: .normal)
        button3.setBackgroundImage(nil, for: .normal)
        button4.setBackgroundImage(nil, for: .normal)
        button5.setBackgroundImage(nil, for: .normal)
        button6.setBackgroundImage(nil, for: .normal)
        button7.setBackgroundImage(nil, for: .normal)
        button8.setBackgroundImage(nil, for: .normal)
        button9.setBackgroundImage(nil, for: .normal)
    }
    
    private func setBox(button : UIButton, player : Int) {
        if player == 1 {
            button.setBackgroundImage(UIImage(named:"circle"), for: .normal)
        } else if player == 2 {
            button.setBackgroundImage(UIImage(named:"cross"), for: .normal)
        } else {
            print("Erreur : le joueur \(player) n'existe pas")
        }
    }
    
    private func nobodyWin() -> Bool {
        for i in 0...8 {
            if filledArray[i] == 0 {
                return false
            }
        }
        return true
    }
    
    private func testWin() -> Int? {
        var winner : Int? = nil
        // Gagnant par ligne
        if filledArray[0] != 0 && filledArray[0] == filledArray[1] && filledArray[1] == filledArray[2] {
            winner = filledArray[0]
        }
        
        if filledArray[3] != 0 && filledArray[3] == filledArray[4] && filledArray[4] == filledArray[5] {
            winner = filledArray[3]
        }
        
        if filledArray[6] != 0 && filledArray[6] == filledArray[7] && filledArray[7] == filledArray[8] {
            winner = filledArray[6]
        }
        
        // Gagnant par colonne
        if filledArray[0] != 0 && filledArray[0] == filledArray[3] && filledArray[3] == filledArray[6] {
            winner = filledArray[0]
        }
        
        if filledArray[1] != 0 && filledArray[1] == filledArray[4] && filledArray[4] == filledArray[7] {
            winner = filledArray[1]
        }
        
        if filledArray[2] != 0 && filledArray[2] == filledArray[5] && filledArray[5] == filledArray[8] {
            winner = filledArray[2]
        }
        
        // Gagnant par diagonale
        if filledArray[0] != 0 && filledArray[0] == filledArray[4] && filledArray[4] == filledArray[8] {
            winner = filledArray[0]
        }
        
        if filledArray[2] != 0 && filledArray[2] == filledArray[4] && filledArray[4] == filledArray[6] {
            winner = filledArray[2]
        }
        return winner
    }

}

