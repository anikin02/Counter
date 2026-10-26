//
//  ViewController.swift
//  Counter
//
//  Created by Данил on 12/09/2026.
//

import UIKit

class ViewController: UIViewController {
  
  private var counter: Int = 0 {
    didSet {
      counterLabel.text = "Значение счётчика: \(counter)" // Не уверен, считаеться ли это хорошим тоном при разработке, или лучше сделать отдельную функцию, например, updateCounterLabel(), которая будет вызываться при + или -
    }
  }
  
  private var history: [String] = [] {
    didSet {
      historyTextView.text = "История изменений:\n" + history.joined(separator: "\n") // аналогично
    }
  }
  
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var resetButton: UIButton!
  @IBOutlet weak var incrementButton: UIButton!
  @IBOutlet weak var decrementButton: UIButton!
  @IBOutlet weak var historyTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    counterLabel.text = "Значение счётчика: \(counter)"
    
    incrementButton.configuration?.title = "+"
    incrementButton.configuration?.attributedTitle?.font  = UIFont.systemFont(ofSize: 30, weight: .regular) // решил добавить, так как символ сильно маленький получается
    incrementButton.tintColor = .systemRed
    
    decrementButton.configuration?.title  = "-"
    decrementButton.configuration?.attributedTitle?.font  = UIFont.systemFont(ofSize: 30, weight: .regular) // решил добавить, так как символ сильно маленький получается
    decrementButton.tintColor = .systemBlue
    
    historyTextView.text = "История изменений:"
    historyTextView.isEditable = false
    historyTextView.isSelectable = true
  }
  
  @IBAction func reset(_ sender: Any) {
    counter = 0
    
    addEventToHistory(event: "значение сброшено")
  }
  
  @IBAction func incrementCounter(_ sender: Any) {
    counter += 1
    
    addEventToHistory(event: "значение изменёно на +1")
  }
  @IBAction func decrementCounter(_ sender: Any) {
    if counter > 0 {
      counter -= 1
      addEventToHistory(event: "значение изменёно на -1")
    } else {
      addEventToHistory(event: "попытка уменьшить значение счётчика ниже 0")
    }
  }
  
  private func addEventToHistory(event: String) {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: Date())
    let currentHour = components.hour ?? 0
    let currentMinute = components.minute ?? 0
    
    let eventWithTime = "[\(currentHour):\(currentMinute)]: \(event)"
    
    history.append(eventWithTime)
  }
  
}

