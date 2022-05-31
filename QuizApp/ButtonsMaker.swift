import UIKit

class ButtonsMaker: UIView {

    func createButton(title: String, number: Int) -> UIButton {
        let btn: UIButton = {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(Config.Colors.primaryColor, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 25
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            addConstraints(button: button, number: number)
            return button
        }()
        return btn
    }
    
    func addConstraints(button: UIButton, number: Int) {
        let constraints = [
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: (Config.Constraints.spaceBetweenButtons + Config.Constraints.buttonHeightConstraint)*CGFloat(number)),
            button.widthAnchor.constraint(equalToConstant:Config.Constraints.buttonWidthConstraint),
            button.heightAnchor.constraint(equalToConstant: Config.Constraints.buttonHeightConstraint)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

