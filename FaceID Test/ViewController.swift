import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBAction func faceIDButtonPressed(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let localizedReason = "Authenticate with Face ID to proceed"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { [weak self] (success, error) in
                if success {
                    print("Authentication succeeded")
                    DispatchQueue.main.async {
                        let nextViewController = self?.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
                        self?.present(nextViewController, animated: true, completion: nil)
                    }
                } else {
                    print("Authentication failed")
                    if let error = error as NSError? {
                        if error.code == LAError.userCancel.rawValue {
                            print("Authentication canceled by user")
                        } else {
                            print("Authentication error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        } else {
            print("Face ID is not available or not enabled")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
