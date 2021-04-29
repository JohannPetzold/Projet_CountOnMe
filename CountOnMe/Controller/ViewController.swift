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
        if let numberText = sender.title(for: .normal) {
            if manager.expressionHasResult(text: textView.text) {
                textView.text = ""
            }
            textView.text.append(numberText)
        }
    }
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        if let error = manager.verifyOperationButton(text: textView.text) {
            let alertVC = makeAlertVC(message: error)
            return self.present(alertVC, animated: true, completion: nil)
        }
        if let sign = sender.title(for: .normal) {
            textView.text.append(" " + sign + " ")
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if let error = manager.verifyEqualButton(text: textView.text) {
            let alertVC = makeAlertVC(message: error)
            return self.present(alertVC, animated: true, completion: nil)
        }
        textView.text.append(" = \(manager.operationToReduce(text: textView.text))")
    }
    
    @IBAction func tappedEraseButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    
    // MARK: - Methods
    private func makeAlertVC(message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }
}
