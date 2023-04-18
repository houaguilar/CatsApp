//
//  SplashViewController.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit
import SnapKit
import Reachability

protocol SplashDisplayLogic: AnyObject {
    var interactor: SplashInteractor { get }
    var presenter: SplashPresenter { get }
}
protocol ListProductsDisplayLogic: AnyObject {
    func displayFetchedProducts(viewModel: ListProducts.Products.ViewModel)
    func displayError(error: MessageError)
}
class SplashViewController: UIViewController, ListProductsDisplayLogic, SplashDisplayLogic, ConnectionListener {

    static let identifier = "splashViewController"
    private var splashView: SplashView
    var coordinator: ListCatsCoordinatorLogic?
    var interactor: SplashInteractor
    var presenter: SplashPresenter
    let rechabilityManager = ReachabilityManager.shared

    init(_ interactor: SplashInteractor,
         _ presenter: SplashPresenter,
         _ splashView: SplashView = SplashView()) {
        self.interactor = interactor
        self.presenter = presenter
        self.splashView = splashView
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override  func loadView() {
        self.view = splashView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = self
        presenter.viewController = viewController
        interactor.presenter = presenter
        setupView()
    }
    func setupView() {
        splashView.setupUI()
        splashView.startAnimating()
    }
    func fetchProducts() {
        let request = ListProducts.Products.Request()
        interactor.fetchListProducts(request: request)
    }
    // MARK: ListProductsDisplayLogic
    func displayFetchedProducts(viewModel: ListProducts.Products.ViewModel) {
        rechabilityManager.stopMonitoring()
        splashView.stopAnimating()
        coordinator?.goToCats(products: viewModel.displayedProducts)
    }
    func displayError(error: MessageError) {

        let listener: ConnectionListener = self
        rechabilityManager.addListener(listener: listener)
        if error.currentError == ServerError.nointernet {
            rechabilityManager.startMonitoring()
            splashView.show(title: error.title, message: error.message)
        }
    }
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      fetchProducts()
    }
    // MARK: ConnectionListener
    func connectionChanged(status: Reachability.Connection) {
        if status == .cellular || status == .wifi {
            fetchProducts()
        }
    }
}
