//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "openPostSegue" else { return }
        let postViewController = segue.destination as? PostViewController
        postViewController?.post = Post(title: "smth")
    }

}
