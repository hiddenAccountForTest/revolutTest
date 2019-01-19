//
//  CurrenciesViewController.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 05/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

protocol CurrenciesViewModelDelegate: class {
    func updateTableView()
}

final class CurrenciesViewController: UIViewController {
    
    // MARK: - Properties
    
    let tableView = UITableView()
    private let viewModel: CurrenciesViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.startDownloadCurrenciesWithEuro()
    }

    // MARK: - Private methods
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrenciesTableViewCell.self, forCellReuseIdentifier: "Cell")
        title = .currencies
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

// MARK: - UITableViewDataSource

extension CurrenciesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellViewModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        (cell as? CurrenciesTableViewCell)?.setup(viewModel.getCellViewModels()[indexPath.row])
        (cell as? CurrenciesTableViewCell)?.delegate = viewModel
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CurrenciesViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

// MARK: - CurrenciesViewModelDelegate

extension CurrenciesViewController: CurrenciesViewModelDelegate {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
}

// MARK: - Constants

private extension String {
    
    static let currencies = "Currencies"
    
}
