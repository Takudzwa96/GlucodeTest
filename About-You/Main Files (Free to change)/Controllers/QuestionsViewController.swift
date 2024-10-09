import UIKit
import Combine

class QuestionsViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    var imagePicker = UIImagePickerController()
    var profileCardView: ProfileEngineerView?

    @IBOutlet weak var containerStack: UIStackView!
    var questions: [Question] = []
    var engineer : Engineer?
    var engineerUpdatedSubject = PassthroughSubject<Engineer, Never>()

    static func loadController(with questions: [Question], engineer: Engineer) -> QuestionsViewController {
        let viewController = QuestionsViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(with: questions, engineer: engineer)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "About"
        self.scrollView.delegate = self
        self.containerView.layer.cornerRadius = 10
        self.containerView.backgroundColor = .black
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func setUp(with questions: [Question], engineer: Engineer) {
        loadViewIfNeeded()
        addProfileView(with: engineer)
        for question in questions {
            addQuestion(with: question)
        }
        self.engineer = engineer
        self.questions = questions
    }

    private func addQuestion(with data: Question) {
        guard let cardView = QuestionCardView.loadView() else { return }
        cardView.setUp(with: data.questionText,
                       options: data.answerOptions,
                       selectedIndex: data.answer?.index)
        self.containerStack.addArrangedSubview(cardView)

    }

    private func addProfileView(with engineer: Engineer) {
        guard let cardView = ProfileEngineerView.loadView() else { return }
        cardView.delegate = self
        cardView.setUpContentView(engineer: engineer)
        cardView.layer.cornerRadius = 10
        self.containerView.addSubview(cardView)
        self.profileCardView = cardView
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.engineer?.profileImage = image
            if let engineer = self.engineer {
                self.profileCardView?.setUpContentView(engineer: engineer)
                engineerUpdatedSubject.send(engineer)
            }

        }

    }

}

extension QuestionsViewController: ProfileEngineerViewDelegate {
    func hasClickedImage() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.allowsEditing = false
            present(self.imagePicker, animated: true, completion: nil)
        }
    }

}

