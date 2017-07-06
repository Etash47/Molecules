//
//  PickerViewController.swift
//  Molecules
//
//  Created by Etash Kalra on 6/4/17.
//  Copyright © 2017 Etash Kalra. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet var water: UIButton!
    @IBOutlet var chlorine: UIButton!
    @IBOutlet var iodine: UIButton!
    @IBOutlet var neon: UIButton!
    @IBOutlet var nitrogen: UIButton!
    @IBOutlet var mercury: UIButton!
    
    let colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        neon.backgroundColor = colors[0]
        water.backgroundColor = colors[1]
        nitrogen.backgroundColor = colors[2]
        iodine.backgroundColor = colors[3]
        chlorine.backgroundColor = colors[4]
        mercury.backgroundColor = colors[5]
        
        neon.layer.cornerRadius = 10
        water.layer.cornerRadius = 10
        nitrogen.layer.cornerRadius = 10
        mercury.layer.cornerRadius = 10
        iodine.layer.cornerRadius = 10
        chlorine.layer.cornerRadius = 10
    
    }
    
    @IBAction func back(_ sender: Any) {
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selected = String()
    
    @IBAction func waterX(_ sender: Any) {clicked(element: "Water")}
    
    @IBAction func chlorineX(_ sender: Any) {clicked(element: "Chlorine")}
    
    @IBAction func iodineX(_ sender: Any) {clicked(element: "Iodine")}
    
    @IBAction func neonX(_ sender: Any) {clicked(element: "Neon")}
    
    @IBAction func nitrogenX(_ sender: Any) {clicked(element: "Nitrogen")}
    
    @IBAction func mercuryX(_ sender: Any) {clicked(element: "Mercury")}
    
    func clicked(element: String) {
        
        selected = element
        self.performSegue(withIdentifier: "pickToSim", sender: self)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! SimulationViewController
        vc.element = selected
        
    }
    

}
