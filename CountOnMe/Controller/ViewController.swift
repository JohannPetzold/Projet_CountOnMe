//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    // MARK: - Properties
    private var manager = CountManager()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if manager.expressionHasResult(text: textView.text) {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        guard manager.canAddOperator(text: textView.text) else {
            let alertVC = makeAlertVC(message: "Un operateur est déja mis !")
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard !manager.expressionHasResult(text: textView.text) else {
            let alertVC = makeAlertVC(message: "Commencez avec un chiffre !")
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard let sign = sender.title(for: .normal) else {
            return
        }
        
        textView.text.append(" " + sign + " ")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard manager.expressionIsCorrect(text: textView.text) else {
            let alertVC = makeAlertVC(message: "Entrez une expression correcte !")
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard manager.expressionHasEnoughElement(text: textView.text) else {
            let alertVC = makeAlertVC(message: "Démarrez un nouveau calcul !")
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard !manager.expressionHasResult(text: textView.text) else {
            let alertVC = makeAlertVC(message: "Résultat déjà obtenu !")
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        textView.text.append(" = \(manager.operationToReduce(text: textView.text)!.first!)")
    }
    
    // MARK: - Methods
    private func makeAlertVC(message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }
}
