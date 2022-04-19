import UIKit

class InfoViewController: UIViewController {

    lazy var alertButton: UIButton = {
        let alertButton = RoundedButton(cornerRadius: UIScreen.main.bounds.width * 0.05)
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        alertButton.backgroundColor = UIColor(named: "AccentColor")
        alertButton.tintColor = .orange
        alertButton.setTitle("Show Alert", for: .normal)
        return alertButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        alertButtonConstraints()
        //showAlert()
//        showAlertButton.layer.cornerRadius = showAlertButton.frame.width*0.1
//        showAlertButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    func alertButtonConstraints() {
        view.addSubview(alertButton)
        let leadingConstraint = alertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = alertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let bottomConstraint = alertButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        let heightConstraint = alertButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, heightConstraint])
    }
    
    @objc func showAlert(/*_ sender: UIButton*/) {
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
