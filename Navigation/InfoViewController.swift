//
//  InfoViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var showAlertButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlertButton.layer.cornerRadius = showAlertButton.frame.width*0.1
        showAlertButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Some info", message: "second home work", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default) { _ in
            print("ok pushed")
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { _ in
            print("cancel pushed")
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
