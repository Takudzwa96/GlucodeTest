//
//  ProfileEngineerView.swift
//  About-You
//
//  Created by Takudzwa Raisi on 2024/10/07.
//

import UIKit

//MARK: + Protocol methods
protocol ProfileEngineerViewDelegate {
    func hasClickedImage()
}

class ProfileEngineerView: UIView  {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var statsContainerView: UIView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet fileprivate(set) weak var yearsNameLabel: UILabel!
    @IBOutlet fileprivate(set) weak var yearsValueLabel: UILabel!

    @IBOutlet fileprivate(set) weak var coffeesNameLabel: UILabel!
    @IBOutlet fileprivate(set) weak var coffeesValueLabel: UILabel!

    @IBOutlet fileprivate(set) weak var bugsNameLabel: UILabel!
    @IBOutlet fileprivate(set) weak var bugsValueLabel: UILabel!

    var engineer: Engineer?
    var delegate: ProfileEngineerViewDelegate?

    override func awakeFromNib() {
        self.applyStyling()
    }
    //MARK: + View Load methods
    static func loadView() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else {
            return nil
        }
        return view
    }
    //MARK: + View Setup methods
    private func applyStyling() {

        self.containerView.backgroundColor = .black
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.cornerCurve = .continuous

        self.statsContainerView.backgroundColor = .white
        self.statsContainerView.layer.cornerRadius = 10

        self.profileImageView.layer.cornerRadius = 10

        self.nameLabel.textColor = .white
        self.nameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)

        self.roleLabel.textColor = .white
        self.roleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)

        self.yearsNameLabel.textColor = .black
        self.yearsNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)

        self.yearsValueLabel.textColor = .black
        self.yearsValueLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)

        self.coffeesNameLabel.textColor = .black
        self.coffeesNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)

        self.coffeesValueLabel.textColor = .black
        self.coffeesValueLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)

        self.bugsNameLabel.textColor = .black
        self.bugsNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)

        self.bugsValueLabel.textColor = .black
        self.bugsValueLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)

    }
    //MARK: + Public methods
    func setUpContentView(engineer: Engineer) {
        self.yearsNameLabel.text = "Years"
        self.coffeesNameLabel.text = "Coffees"
        self.bugsNameLabel.text = "Bugs"

        self.nameLabel.text = engineer.name
        self.roleLabel.text = engineer.role

        self.yearsValueLabel.text = "\(engineer.quickStats.years)"

        self.coffeesValueLabel.text = "\(engineer.quickStats.coffees)"

        self.bugsValueLabel.text = "\(engineer.quickStats.bugs)"
        self.profileImageView.image = engineer.profileImage
    }

    //MARK: + Action methods
    @IBAction func profileImageButtonClicked(_ sender: AnyObject?) {
        self.delegate?.hasClickedImage()
    }
}


