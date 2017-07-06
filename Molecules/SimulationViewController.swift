//
//  SimulationViewController.swift
//  Molecules
//
//  Created by Etash Kalra on 6/5/17.
//  Copyright © 2017 Etash Kalra. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {
    
    var element: String!
    var timerMax = 200
    var timerMin = 50
    
    @IBOutlet var tempView: UILabel!
    
    @IBOutlet var upButton: UIImageView!
    @IBOutlet var downButton: UIImageView!
    
    @IBOutlet var elementLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    
    let molecules = ["Neon", "Water", "Nitrogen", "Iodine", "Chlorine", "Mercury"]
    
    var mNum = -1
    
    var temp = 0
    
    let colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
    
    let points = [[-248.6, -246.1], [0.0, 100.0], [-210.0, -195.79], [113.5, 184.0], [-100.98, -34.6], [-38.89, 356.7]]
    
    var freeze = Float()
    var boil = Float()
    
    var stateOfMatter = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mNum = molecules.index(of: element)!
        
        freeze = Float(points[mNum][0])
        boil = Float(points[mNum][1])
        
        if Float(temp) < freeze { stateOfMatter = 0 } //solid
        else if Float(temp) > boil { stateOfMatter = 2 } //gas
        else { stateOfMatter = 1 } //liquid
        
        buttonSetup()
        
        for v in self.view.subviews {
            
            self.addMolecules(n: 15)
            
            UIView.transition(with: v, duration: 1.5, options: .transitionFlipFromTop, animations: {
                
                v.alpha = 1
                
            }, completion: { (_) in
                
                //self.secondSetup()
                self.elementLabel.text = self.element
                self.stateLabel.text = (["Solid", "Liquid", "Gas"])[self.stateOfMatter]
                
            })
            
        }
        
        tempView?.text = "\(temp)°C"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        for v in view.subviews {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                v.alpha = 1
                
            })
            
        }
        
    }
    
    func buttonSetup() {
        
        upButton.isUserInteractionEnabled = true
        downButton.isUserInteractionEnabled = true
        
        let upTap = UITapGestureRecognizer(target: self, action: #selector(SimulationViewController.upTap(recognizer:)))
        upTap.numberOfTapsRequired = 1
        let upHold = UILongPressGestureRecognizer(target: self, action: #selector(SimulationViewController.upHold(recognizer:)))
        upButton.addGestureRecognizer(upHold)
        upButton.addGestureRecognizer(upTap)
        
        let downTap = UITapGestureRecognizer(target: self, action: #selector(SimulationViewController.downTap(recognizer:)))
        downTap.numberOfTapsRequired = 1
        let downHold = UILongPressGestureRecognizer(target: self, action: #selector(SimulationViewController.downHold(recognizer:)))
        downButton.addGestureRecognizer(downHold)
        downButton.addGestureRecognizer(downTap)
        
    }
    
    func upTap(recognizer: UIGestureRecognizer) {
        
        print("\n\n\n\nNNNEK")
        
        if temp < 500 {
            
            self.temp += 1
            reloadTemp()
            
        }
        
    }
    
    func downTap(recognizer: UIGestureRecognizer) {
        
        if temp > -274 {
            
            self.temp -= 1
            reloadTemp()
            
        }
        
    }
    
    var datTimer: Timer? = nil
    
    func upHold(recognizer: UIGestureRecognizer) {
        
        if recognizer.state == .began {
            
            datTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
                
                if self.temp <= 500 { self.temp += 5 }
                self.reloadTemp()
                
            })
            
        } else if recognizer.state == .ended || recognizer.state == .cancelled {
            
            datTimer?.invalidate()
            
        }
        
    }
    
    func downHold(recognizer: UIGestureRecognizer) {
        
        if recognizer.state == .began {
            
            datTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
                
                if self.temp >= -273 { self.temp -= 5 }
                self.reloadTemp()
                
            })
            
        } else if recognizer.state == .ended || recognizer.state == .cancelled {
            
            datTimer?.invalidate()
            
        }
    }
    
    func reloadTemp() {
        
        let old = stateOfMatter
        
        tempView?.text = "\(temp)°C"
        
        if Float(temp) < freeze { stateOfMatter = 0 } //solid
        else if Float(temp) > boil { stateOfMatter = 2 } //gas
        else { stateOfMatter = 1 } //liquid
        
        
        if old != stateOfMatter {
            
            self.elementLabel.text = self.element
            self.stateLabel.text = (["Solid", "Liquid", "Gas"])[self.stateOfMatter]
            
            for t in timers {
                
                t.fireDate = NSDate() as Date
                t.fire()
                
            }
            
        }
        
    }
    
//    func secondSetup() {
//
//
//
//        label?.isHidden = true
//        tempTextView?.isHidden =  true
//
//        self.label = UITextView(frame: CGRect(x: 0, y: 0, width: 600, height: 100))
//
//        let mol = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 30)]
//        let molecule = NSMutableAttributedString(string:self.molecules[self.mNum] + "\n", attributes: mol)
//
//        let som = [NSFontAttributeName : UIFont(name: "AvenirNext-DemiBold", size: 25)]
//        let state = NSMutableAttributedString(string:["Solid", "Liquid", "Gas"][stateOfMatter], attributes:som)
//
//        let labelText = NSMutableAttributedString()
//        labelText.append(molecule)
//        labelText.append(state)
//
//        label?.attributedText = labelText
//
//        label?.alpha = 0
//        label?.backgroundColor = .clear
//        label?.textColor = .black
//        label?.isUserInteractionEnabled = false
//        label?.textAlignment = .center
//        self.view.addSubview(label!)
//
//        tempTextView = UITextView(frame: CGRect(x: 25, y: 328, width: 75, height: 50))
//        tempTextView?.text = "\(temp)°C"
//        tempTextView?.alpha = 0
//        tempTextView?.backgroundColor = .clear
//        tempTextView?.textColor = .black
//        tempTextView?.font = UIFont.boldSystemFont(ofSize: 18)
//        tempTextView?.isUserInteractionEnabled = false
//
//        self.view.addSubview(tempTextView!)
//
//
//    }
    
    func createColoredMolecule(color: UIColor) -> UIView {
        
        let molecule = UIView(frame: CGRect(origin: CGPoint(x: view.frame.size.width/2, y: -100), size: CGSize(width: 30, height: 30)))
        
        molecule.alpha = 0.0
        
        molecule.layer.cornerRadius = 15
        
        molecule.backgroundColor = color
        
        return molecule
        
    }

    var addedAlready = false
    
    var timers = [Timer]()
    
    func addMolecules(n:Int) {
        
        if addedAlready { return }
        
        for i in 0..<n {
            
            let molecule = createColoredMolecule(color: colors[mNum])
            
            molecule.alpha = 0.0
            
            var interval = Float(arc4random_uniform(200)) + 50
            
            interval = interval / 100
            
            //self.moveMolecule(molecule: molecule, interval: Float(interval))
            
            timers.append(Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { (timr) in
                
                var ivl = interval
                
                if self.stateOfMatter == 0 {
                    
                    timr.fireDate = timr.fireDate.addingTimeInterval(10000000)
                    
                }
                
                if self.stateOfMatter == 2 {
                    
                    var diff = Float(self.temp) - self.boil
                    
                    if diff < 10 { diff += 5 }
                    else if diff > 200 { diff = 199 }
                    
                    ivl = Float(arc4random_uniform(UInt32(Float(200) / diff))) + (Float(arc4random_uniform(UInt32(500) + UInt32(diff))) / diff)
                    
                    ivl /= 100
                    
                    //                    if ivl >= 2.5 {
                    //
                    //                        ivl = Float(arc4random_uniform(200)) + 50
                    //
                    //                    }
                    
                    timr.fireDate = timr.fireDate.addingTimeInterval(TimeInterval(ivl))
                    
                }
                
                self.moveMolecule(molecule: molecule, interval: Float(ivl))
                
            }))
            
            view.addSubview(molecule)
            
            view.sendSubview(toBack: molecule)
            
            molecule.alpha = 0
            
        }
        
        addedAlready = true
        
    }
    
    func moveMolecule(molecule: UIView, interval: Float) {
        
        var ivl = interval
        
        UIView.animate(withDuration: TimeInterval(ivl), animations: {
            
            molecule.frame.origin = self.randomPlace()
            
        }) { (true) in
            
            //UIView.animate(withDuration: 0.5, animations: {
                
            
            //})
            
        }
        
    }
    
    func randomPlace() -> CGPoint {
        
        var point: CGPoint = CGPoint()
        
        if stateOfMatter == 2 {
            
            point = CGPoint(x:Int(arc4random_uniform(UInt32(view.frame.size.width + 50))) - 25, y:Int (arc4random_uniform(UInt32(view.frame.size.height + 50))) - 25)
            
        } else if stateOfMatter == 1 {
            
            point = CGPoint(x:Int(arc4random_uniform(UInt32(view.frame.width + 50))) - 25, y:Int (arc4random_uniform(100)) + Int(view.frame.size.height - 100))
            
        } else {
            
            point = CGPoint(x:Int(arc4random_uniform(200)) + Int(view.frame.size.width/2 - 100), y:Int (arc4random_uniform(100)) + Int(view.frame.size.height - 100))
            
        }
        
        return point
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backTho", sender: self)
        
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        for timer in timers {
            
            timer.invalidate()
            
        }
        
        for v in view.subviews {
            
            UIView.animate(withDuration: 1, animations: {
                
                v.alpha = 0
                
            }, completion: { (_) in
                
            })
            
            
        }
        
        
    }
    

}
