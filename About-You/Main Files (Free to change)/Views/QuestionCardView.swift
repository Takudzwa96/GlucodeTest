import UIKit

class QuestionCardView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionsStackView: UIStackView!
    var selectedIndex: Int? = nil
    var currentSelection: SelectableAnswerView?

    override func awakeFromNib() {
        applyStyling()
    }

    func setUp(with title: String, options: [String], selectedIndex: Int? = nil) {
        titleLabel.text = title
        self.selectedIndex = selectedIndex
        for (index, optionText) in options.enumerated() {
            addOption(with: optionText,
                      addSeperator: index != options.count - 1,
                      setSelected: index == selectedIndex)
        }
    }

    func ensureCorrectSelectionIsSelected() {
        if let index = selectedIndex,
           let selectionView = optionsStackView.arrangedSubviews[index] as? SelectableAnswerView {
            selectionView.applySelectionStyling()
            currentSelection = selectionView
        }
    }

    private func applyStyling() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)

        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }

    private func addOption(with text: String, addSeperator: Bool = true, setSelected: Bool) {
        guard let optionView = SelectableAnswerView.loadView() else { return }
        optionView.setUp(with: text, delegate: self)

        optionsStackView.addArrangedSubview(optionView)
        if addSeperator {
            createAndAddSeperator()
        }

        if setSelected {
            optionView.applySelectionStyling()
            currentSelection = optionView
        }
    }

    private func createAndAddSeperator() {
        let seperatorView = UIView.seperatorView(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10))
        optionsStackView.addArrangedSubview(seperatorView)
    }

    static func loadView() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else {
            return nil
        }
        return view
    }
}

extension QuestionCardView: SelectionViewDelegate {
    func didSelect(selectionview: SelectableAnswerView) {
        currentSelection?.deselect()
        selectionview.applySelectionStyling()
        currentSelection = selectionview
        if let index = optionsStackView.arrangedSubviews.firstIndex(of: selectionview) {
            selectedIndex = index
        }
    }
}
