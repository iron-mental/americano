//
//  SearchLocationView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SearchLocationView: UIViewController {
    var presenter: SearchLocationPresenterProtocol?
    var parentView: UIViewController?
    var closeButton = UIButton()
    var searchTextField = UITextField()
    var searchButton = UIButton()
    var tableView = UITableView()
    var searchResultList: [StudyDetailLocationPost] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        closeButton.do {
            $0.setImage(UIImage(systemName: "xmark")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
            $0.addTarget(self, action: #selector(didCloseButtonClicked), for: .touchUpInside)
            $0.tintColor = .white
        }
        searchButton.do {
            $0.setImage(UIImage(systemName: "magnifyingglass")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
            $0.addTarget(self, action: #selector(didSearchButtonClicked), for: .touchUpInside)
            $0.tintColor = .white
        }
        searchTextField.do {
            $0.textColor = .white
            $0.placeholder = "장소 키워드 검색 ex) 강남, 신촌"
            $0.becomeFirstResponder()
            $0.delegate = self
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(SearchLocationTableViewCell.self, forCellReuseIdentifier: SearchLocationTableViewCell.identifier)
        }
    }
    
    func layout() {
        [closeButton, searchTextField, searchButton, tableView].forEach { view.addSubview($0) }
        
        closeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
        }
        searchButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertWidth(value: 15)).isActive = true
            $0.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        searchTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeight(value: 18)).isActive = true
            $0.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: Terminal.convertWidth(value: 15.7)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 250)).isActive = true
        }
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Terminal.convertHeight(value: 20.6)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 13.5)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertWidth(value: 13.5)).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func didCloseButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func didSearchButtonClicked() {
        if let keyword = searchTextField.text {
            presenter?.didClickedSearchButton(text: keyword)
        }
    }
}

extension SearchLocationView: SearchLocationViewProtocol {
    func dismiss() {
        dismiss(animated: true)
    }
    
    func showSearchResult(list: [StudyDetailLocationPost]) {
        if list.isEmpty {
            searchResultList = list
            showToast(controller: self, message: "검색결과가 없습니다.", seconds: 1)
        } else {
            searchResultList = list
            tableView.reloadData()
            searchTextField.endEditing(true)
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}

extension SearchLocationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResultList.isEmpty {
            tableView.setEmptyView(type: .SearchLocationListEmptyViewType)
            return 0
        } else {
            tableView.restore()
            return searchResultList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchLocationTableViewCell.identifier, for: indexPath) as! SearchLocationTableViewCell
        let data = searchResultList[indexPath.row]
        cell.setData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectedItem(item: searchResultList[indexPath.row],
                                   view: self,
                                   parentView: parentView!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextField.endEditing(true)
    }
}

extension SearchLocationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = searchTextField.text {
            presenter?.didClickedSearchButton(text: keyword)
        }
        return true
    }
}
