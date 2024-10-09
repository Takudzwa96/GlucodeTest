import UIKit
import Combine

protocol EngineersTableViewControllerDelegate {
    func hasSelectedCell (engineer: Engineer )
}

class EngineersTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var engineers: [Engineer] = Engineer.testingData()
    var selectedOrderString: String = ""
    var delegate: EngineersTableViewControllerDelegate?
    var viewDidAppear: Bool = false
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engineers at Glucode"
        self.tableView.backgroundColor = .white
        self.tableView.accessibilityIdentifier = "EngineersTableViewController"
        self.registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order by",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(orderByTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black

    }

    @objc func reloadTableView() {
        print("The method is called.")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @objc func orderByTapped() {
        guard let from = navigationItem.rightBarButtonItem else { return }
        let controller = OrderByTableViewController(style: .plain)
        controller.delegate = self
        let size = CGSize(width: 200,
                          height: 150)

        present(popover: controller,
             from: from,
             size: size,
             arrowDirection: .up)
    }

    func subscribeToEngineerUpdates(from viewController: QuestionsViewController) {
        viewController.engineerUpdatedSubject
            .sink { [weak self] updatedEngineer in
                guard let self = self else { return }
                if let index = self.engineers.firstIndex(where: { $0.name == updatedEngineer.name }) {
                    self.engineers[index] = updatedEngineer
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
        }

    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: GlucodianTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GlucodianTableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return engineers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GlucodianTableViewCell.self)) as? GlucodianTableViewCell
        let orderedEngineers = engineers.sorted(by: selectedOrderString)
        cell?.setUp(with: orderedEngineers[indexPath.row])
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = QuestionsViewController.loadController(with: engineers[indexPath.row].questions, engineer: engineers[indexPath.row])
        subscribeToEngineerUpdates(from: controller)
        navigationController?.pushViewController(controller, animated: true)
    }

}
extension EngineersTableViewController: OrderByTableViewControllerDelegate {

    func hasSelectedOrder(order: String) {
        self.selectedOrderString = order
        self.reloadTableView()
    }
}

private extension Array where Element == Engineer {
    func sorted(by order: String) -> [Engineer] {
        switch order {
        case "years":
            return self.sorted { $0.quickStats.years > $1.quickStats.years }
        case "Coffees":
            return self.sorted { $0.quickStats.coffees > $1.quickStats.coffees }
        case "Bugs":
            return self.sorted { $0.quickStats.bugs > $1.quickStats.bugs }
        default:
            return self
        }
    }
}
