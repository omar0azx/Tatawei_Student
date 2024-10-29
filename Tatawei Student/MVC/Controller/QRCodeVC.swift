//
//  QRCodeVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 27/10/2024.
//

import UIKit

class QRCodeVC: UIViewController, Storyboarded {

    //MARK: - Varibales

    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        showQRCodeOverlay()
    }

    //MARK: - Functions

    func showQRCodeOverlay() {
        // Create the overlay view
        let overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        // Add blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = overlayView.bounds
        overlayView.addSubview(blurEffectView)
        
        // Generate the QR code
        if let qrCodeImage = generateQRCode(from: "\(Student.currentStudent!.id)") {
            // Create a green background view for the QR code
            let greenBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 274, height: 302))
            greenBackgroundView.backgroundColor = UIColor.standr
            greenBackgroundView.layer.cornerRadius = 20
            greenBackgroundView.clipsToBounds = true
            greenBackgroundView.center = overlayView.center
            overlayView.addSubview(greenBackgroundView)

            // Create the QR image view
            let qrImageView = UIImageView(image: qrCodeImage)
            qrImageView.contentMode = .scaleAspectFit
            qrImageView.frame = CGRect(x: 10, y: 11, width: 254, height: 250)
            qrImageView.center = CGPoint(x: greenBackgroundView.bounds.midX, y: greenBackgroundView.bounds.midY - 10)
            qrImageView.layer.cornerRadius = 15
            qrImageView.clipsToBounds = true
            greenBackgroundView.addSubview(qrImageView)
            
            // Create a label below the QR code
            let qrLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
            qrLabel.text = "\(Student.currentStudent!.id.prefix(6))"
            qrLabel.textColor = .white
            qrLabel.textAlignment = .center
            qrLabel.center = CGPoint(x: greenBackgroundView.bounds.midX, y: qrImageView.frame.maxY + 13)
            greenBackgroundView.addSubview(qrLabel)
        }

        // Add tap gesture to dismiss the overlay
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOverlay))
        overlayView.addGestureRecognizer(tapGesture)
        self.view.addSubview(overlayView)
    }
    @objc func dismissOverlay() {
        // Find the overlay view and remove it
        if let overlayView = self.view.subviews.last {
            overlayView.removeFromSuperview()
        }
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        
        // Create a CIFilter for QR code generation
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel") // Error correction level

            if let outputImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                let scaledImage = outputImage.transformed(by: transform)
                return UIImage(ciImage: scaledImage)
            }
        }
        
        return nil
    }
}
