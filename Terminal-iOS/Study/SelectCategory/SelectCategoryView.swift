//
//  SelectCategoryView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryView: UIViewController {
    var presenter: SelectCategoryPresenterProtocols?
    var categoryList: [Category] = []
    
    let titleView = UILabel()
    let textLabel = UILabel()
    let font = UIFont(name:"Apple Color Emoji" , size: 25)
    //    let tempView = UIImageView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    let tempcategorySelectButton = UIButton()
    var tempCategory: String?
    var selectedCategory = "카테고리선택부터넘어온값"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        titleView.do {
            $0.text = "스터디 만들기"
            //            $0.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
            $0.textColor = .white
        }
        navigationItem.do {
            $0.titleView = titleView
        }
        textLabel.do {
            $0.text = "카테고리 선택"
            $0.textColor = .white
            $0.frame = CGRect(x: 0, y: 0, width: 90, height: 35)
            let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "empty")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: font, range: NSMakeRange(0, 7))
            textLabel.attributedText = attributedStr
        }
        //        tempView.do {
        //            $0.image = #imageLiteral(resourceName: "categoryimage")
        //            $0.contentMode = .scaleAspectFit
        //        }
        collectionView.do {
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor(named: "background")
        }
        navigationItem.do {
            $0.leftBarButtonItem = UIBarButtonItem(title: "<<<<", style: .plain, target: self, action: #selector(backButtonTapped))
        }
        tempcategorySelectButton.do {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.backgroundColor = .green
            $0.addTarget(self, action: #selector(goToCreateStudy), for: .touchUpInside)
        }
    }
    
    func layout() {
        view.addSubview(textLabel)
        //        view.addSubview(tempView)
        view.addSubview(collectionView)
        view.addSubview(tempcategorySelectButton)
        
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 500).isActive = true
        }
        //        tempView.do {
        //            $0.translatesAutoresizingMaskIntoConstraints = false
        //            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        //            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30).isActive = true
        //        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.053).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.053)).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tempcategorySelectButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.back()
    }
    
    @objc func goToCreateStudy() {
        presenter?.go(selected: selectedCategory)
    }
    
    func viewAppearAnimation() {
        //애니메이션은 task 단위로 묶어서 하나 하는 중일 때 하나 들어오면 그전 꺼 취소하거나 그런식으로..
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: -490, y: 0)
        })
        { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.textLabel.transform = self.textLabel.transform.translatedBy(x: 10, y: 0)
            })
            { _ in
                UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                    self.textLabel.transform = self.textLabel.transform.translatedBy(x: -5, y: 0)
                })
            }
        }
    }
    
    func viewDisappearAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: 500, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.collectionView.transform = self.collectionView.transform.translatedBy(x: 0, y: -60)
            },completion: { _ in
                self.navigationController?.popViewController(animated: false)
            })
        }
    }
}

extension SelectCategoryView: SelectCategoryViewProtocols {
    func showCategory() {
        attribute()
        layout()
        viewAppearAnimation()
    }
    //이부분은 콜렉션뷰의 didSelected 부분에 들어가게 되겠네요
    func selected() {
        //이부분은 리스트에[선택한인덱스] 가 파라미터로 들어가겠네요
        presenter?.go(selected: selectedCategory)
    }
    
    func backTapped() {
        viewDisappearAnimation()
    }
}

extension SelectCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width * 0.4,
                      height: UIScreen.main.bounds.width * 0.27)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.07
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.035
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        
        let category = categoryList[indexPath.row]
        cell.imageView.image = category.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presenter?.showStudyListDetail()
//        presenter.
    }
}
