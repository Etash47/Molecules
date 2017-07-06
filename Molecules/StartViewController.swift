//
//  StartViewController.swift
//  Molecules
//
//  Created by Etash Kalra on 5/23/17.
//  Copyright © 2017 Etash Kalra. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        timers.removeAll()
        molecules.removeAll()
        
        self.addMolecules(n: 10, theView: self.view)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
    
    func createRandomMolecule() -> UIView {
        
        let rnd = Int(arc4random_uniform(UInt32(colors.count)))
        
        let molecule = UIView(frame: CGRect(origin: randomPlace(), size: CGSize(width: 30, height: 30)))
        
        molecule.layer.cornerRadius = 15
        
        molecule.backgroundColor = colors[rnd]
        
        return molecule
        
    }
    
    var addedAlready = false
    
    var timers = [Timer]()
    var molecules = [UIView]()
    
    func addMolecules(n:Int, theView: UIView) {
        
        if addedAlready { return }
        
        for i in 0..<n {
            
            let molecule = createRandomMolecule()
            
            var interval = Float(arc4random_uniform(150)) + 50
            
            interval = interval / 100
            
            self.moveMolecule(molecule: molecule, interval: Float(interval))
            
            timers.append(Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { (tmr) in
                
                self.moveMolecule(molecule: molecule, interval: Float(interval))
                
            }))
            
            theView.addSubview(molecule)
            
            theView.sendSubview(toBack: molecule)
            
            molecules.append(molecule)
            
        }
        
        addedAlready = true
        
    }

    func moveMolecule(molecule: UIView, interval: Float) {
        
        UIView.animate(withDuration: TimeInterval(interval), animations: {
            
            molecule.frame.origin = self.randomPlace()
            
        }) { (_) in
            
            
        }
        
    }
    
    func randomPlace() -> CGPoint {
        
        let point = CGPoint(x:Int(arc4random_uniform(UInt32(view.frame.width + 50))) - 25, y:Int (arc4random_uniform(UInt32(view.frame.height + 50))) - 25)
        
        return point
        
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        for timer in timers {
            
            timer.invalidate()
            
        }
        
        for molecule in molecules {
            
            molecule.isHidden = true
            molecule.removeFromSuperview()
            
        }
        
    }
    

}
