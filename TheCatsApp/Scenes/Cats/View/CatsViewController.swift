//
//  CatsViewController.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit
protocol CatsDisplayLogic: AnyObject {
    var interactor: CatsInteractor { get }
    var presenter: CatsPresenter { get }
    func displayCats(_ viewModel: ListProducts.Products.ViewModel)
    func displayError(error: MessageError)
}
class CatsViewController: UIViewController, CatsDisplayLogic {
    var interactor: CatsInteractor
    var presenter: CatsPresenter
    var coordinator: CatsCoordinator?

    var catsView = CatsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = catsView
        catsView.setupUI()
        let viewController = self
        presenter.viewController = viewController
        self.interactor.presenter = presenter
    }
    init(_ interactor: CatsInteractor,
         _ presenter: CatsPresenter) {
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchListProducts()
    }
    // MARK: - CatsDisplayLogic
    func displayCats(_ viewModel: ListProducts.Products.ViewModel) {
        catsView.displayProducts(products: viewModel.displayedProducts)
    }
    func displayError(error: MessageError) {
    }
}
