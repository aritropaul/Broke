//
//  ViewController.swift
//  Broke
//
//  Created by Aritro Paul on 12/05/18.
//  Copyright © 2018 NotACoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var bigView: UIView!
    @IBOutlet weak var moneyCard: UIView!
    @IBOutlet weak var addView: UIView!
    @IBAction func cancelButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.addView.transform =  CGAffineTransform(translationX: 0, y: self.addView.frame.height)
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var amountTextField: UITextField!
    @IBAction func doneButton(_ sender: Any) {
        
        if let money = Int(amountTextField.text!){
        if segmentedControl.selectedSegmentIndex == 0{
            transactions.append(money)
            cancelButton((Any).self)
        }
        else{
            transactions.append(-money)
            cancelButton((Any).self)
        }
        }
        else{
            cancelButton((Any).self)
        }
        tableView.reloadData()
        amountTextField.text = ""
        defaults.set(transactions, forKey: "money")
        moneyReload()
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBAction func addMoney(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.addView.transform =  CGAffineTransform(translationX: 0, y: -self.addView.frame.height+10)
        }
    }
    
    
    func setupViews(){
        moneyCard.layer.cornerRadius = 10
        moneyCard.layer.shadowOffset = CGSize(width: 1, height: 1)
        moneyCard.layer.shadowOpacity = 0.1
        addView.layer.cornerRadius = 10
        addView.layer.shadowOffset = CGSize(width: 1, height: 1)
        addView.layer.shadowOpacity = 0.1
        tableView.dataSource = self
        tableView.delegate = self
        transactions.remove(at: 0)
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            addView.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = addView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.clipsToBounds = true
            
            addView.addSubview(blurEffectView)
            addView.sendSubview(toBack: blurEffectView)
        } else {
            addView.backgroundColor = .black
        }
        
        transactions = defaults.array(forKey: "money")  as? [Int] ?? [Int]()
        
    }
    
    func moneyReload(){
        income = 0
        expense = 0
        for item in transactions{
            if item == 0{
                income = 0
                expense = 0
            }
            if item > 0{
                income = income + item
            }
            else {
                expense = expense + abs(item)
            }
        }
        
        incomeLabel.text = String(income)
        expenseLabel.text = String(expense)
        moneyLabel.text = String(income-expense)
    }
    
    var transactions = [0]
    var income = 0
    var expense = 0
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        moneyReload()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TTableViewCell
        
        let money = self.transactions[indexPath.row]
        if money == 0{
            //
        }
        if money > 0{
            cell.percentageView.alpha = 0
            cell.percentageValue.alpha = 0
            cell.typeLabel.text = "INCOME"
            cell.valueLabel.text = String(money)
            cell.typeLabel.textColor = UIColor.init(red: 37/255, green: 186/255, blue: 52/255, alpha: 1)
        }
        else if money < 0{
            cell.percentageView.alpha = 1
            cell.percentageValue.alpha = 1
            cell.typeLabel.text = "EXPENSE"
            cell.valueLabel.text = String(abs(money))
            cell.typeLabel.textColor = UIColor.init(red: 164/255, green: 0/255, blue: 0/255, alpha: 1)
            cell.percentageView.layer.cornerRadius = 3
            let percent = (abs(money) * 100) / income
            cell.percentageValue.text = String(percent)+" %"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


