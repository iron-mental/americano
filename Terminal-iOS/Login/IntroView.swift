//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum BeginState {
    case signUp
    case join
}

enum IntroViewState {
    case emailInput
    case pwdInput
    case nickname
}

class IntroView: UIViewController {
    var presenter: IntroPresenterProtocol?
    
    var leftButton = UIButton()
    var rightbutton = UIButton()
    var guideLabel = UILabel()
    var inputTextfield = UITextField()
    var cancelButton = UIButton()
    var beginState: BeginState?
    var introState: IntroViewState?
    var rightBarButton: UIBarButtonItem?
    var leftBarButton: UIBarButtonItem?
    
    var invalidView = UIView()
    var invalidImage = UIImageView()
    var invalidLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inputTextfield.becomeFirstResponder()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func setting() {
        switch introState {
        case .emailInput:
            self.guideLabel.text = "이메일을\n입력해 주세요"
            self.inputTextfield.placeholder = "abc1234@terminal.com"
            self.introState = .emailInput
            self.leftButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            self.rightbutton.setTitle("다음", for: .normal)
            break
        case .pwdInput:
            self.guideLabel.text = self.beginState == .join ?  "로그인을 위해 계정의 비밀번호를\n입력해 주세요." : "사용하실 비밀번호를\n설정해 주세요"
            self.inputTextfield.do {
                $0.placeholder = "비밀번호"
                $0.isSecureTextEntry = true
            }
            self.introState = .pwdInput
            self.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.beginState == .join ? self.rightbutton.setTitle("완료", for: .normal) : self.rightbutton.setTitle("다음", for: .normal)
            break
        case .nickname:
            self.guideLabel.text = "가입을 위해\n닉네임을 입력해 주세요"
            self.inputTextfield.placeholder = "추천 닉네임"
            self.introState = .nickname
            self.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.rightbutton.setTitle("완료", for: .normal)
        case .none:
            print("none")
        }
    }
    
    // MARK: Attribute
    
    func attribute() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .black
        
        rightBarButton = UIBarButtonItem(customView: rightbutton)
        leftBarButton = UIBarButtonItem(customView: leftButton)
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.testColor)
            $0.navigationItem.rightBarButtonItem = rightBarButton
            $0.navigationItem.leftBarButtonItem = leftBarButton
            $0.navigationController?.navigationBar.standardAppearance = appearance
            $0.view.backgroundColor = UIColor.systemBackground
        }
        inputTextfield.do {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.delegate = self
        }
        leftButton.do {
            $0.addTarget(self, action: #selector(didClickedBackButon), for: .touchUpInside)
        }
        rightbutton.do {
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.addTarget(self, action: #selector(didClickedNextButton), for: .touchUpInside)
        }
        guideLabel.do {
            $0.numberOfLines = 0
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        cancelButton.do {
            $0.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
            $0.addTarget(self, action: #selector(didClickedCancelButton), for: .touchUpInside)
        }
        invalidLabel.do {
            $0.textColor = .systemPink
            $0.text = "아 좀 똑바로 입력하세용!!"
        }
        invalidView.do {
            $0.backgroundColor = .none
            $0.isHidden = true
        }
        invalidImage.do {
            $0.image = #imageLiteral(resourceName: "invalid")
            $0.contentMode = .scaleAspectFill
        }
    }
    
    // MARK: Layout
    
    func layout() {
        [inputTextfield, leftButton, rightbutton, guideLabel, cancelButton, invalidView].forEach { view.addSubview($0) }
        [invalidImage, invalidLabel].forEach { invalidView.addSubview($0) }
        
        inputTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (40/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * ( 235 / 375 )).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * ( 32 / 667 )).isActive = true
        }
        leftButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (18/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
        }
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: inputTextfield.topAnchor, constant: -(20/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (33/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (137/375) * UIScreen.main.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (93/667) * UIScreen.main.bounds.height).isActive = true
        }
        cancelButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: inputTextfield.trailingAnchor, constant: 10).isActive = true
            $0.centerYAnchor.constraint(equalTo: inputTextfield.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        invalidView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: inputTextfield.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        invalidImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: invalidLabel.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: invalidView.leadingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: invalidView.bottomAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
        }
        invalidLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: invalidImage.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: invalidImage.trailingAnchor, constant: 4).isActive = true
            $0.bottomAnchor.constraint(equalTo: invalidView.bottomAnchor).isActive = true
        }
        
    }
    
    
    @objc func didClickedBackButon() {
        self.inputTextfield.endEditing(true)
        switch introState {
        case .emailInput:
            navigationController?.popViewController(animated: true)
        case .pwdInput:
            navigationController?.popViewController(animated: true)
        case .nickname:
            navigationController?.popViewController(animated: true)
        default:
            print("none")
        }
        self.inputTextfield.endEditing(true)
    }
    
    // MARK: Next Button
    
    @objc func didClickedNextButton() {
        presenter?.didClickedRightBarButton(input: inputTextfield.text!, introState: self.introState!, beginState: self.beginState!)
    }
    
    @objc func testNextButton() {
        presenter?.didNextButton(input: inputTextfield.text!, introState: self.introState!, beginState: self.beginState!)
    }
    
    @objc func didClickedCancelButton() {
        switch introState {
        case .emailInput:
            inputTextfield.text = ""
        case .pwdInput:
            inputTextfield.text = ""
        case .nickname:
            inputTextfield.text = ""
        case .none:
            print("none")
        }
    }
}

extension IntroView: IntroViewProtocol {
    func presentNextView() {
        let view = IntroView()
        let presenter = IntroPresenter()
        let interactor = IntroInteractor()
        let remoteDataManager = IntroRemoteDataManager()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager

        switch introState {
        case .emailInput:
            view.introState = .pwdInput
            view.beginState = self.beginState == .join ? .join : .signUp
            self.inputTextfield.endEditing(true)
        case .pwdInput:
            view.beginState = self.beginState == .join ? .join : .signUp
            if self.beginState == .join {
                dismiss(animated: true) {
                    print("act something after join")
                }
            } else {
                view.introState = .nickname
                self.inputTextfield.endEditing(true)
            }
        case .nickname:
            self.introState = .nickname
            dismiss(animated: true)
        default:
            print("none")
        }
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide {
            print("Loading hide")
        }
    }
    
    func presentCompleteView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func completeJoin() {
        let view = ViewController()
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    func showInvalidEmailAction(message: String) {
        invalidView.isHidden = false
        invalidLabel.text = message
        invalidGuideAnimation()
    }
    
    func showInvalidPasswordAction() {
        invalidView.isHidden = false
        invalidLabel.text = "유효하지 않은 비밀번호 입니다."
        invalidGuideAnimation()
    }
    
    func showInvalidNickNameAction() {
        invalidView.isHidden = false
        invalidLabel.text = "중복된 닉네임 입니다."
        invalidGuideAnimation()
    }
    
    func showInvalidLoginAction(message: String) {
        invalidView.isHidden = false
        invalidLabel.text = message
        invalidGuideAnimation()
    }
    
    func invalidGuideAnimation() {
        UIView.animate(withDuration: 0.05) {
            self.invalidView.transform = CGAffineTransform(translationX: -10, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.invalidView.transform = CGAffineTransform(translationX: 5, y: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.invalidView.transform = CGAffineTransform(translationX: -2.5, y: 0)
                } completion: { _ in
                    UIView.animate(withDuration: 0.05) {
                        self.invalidView.transform = CGAffineTransform(translationX: 1.25, y: 0)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            self.invalidView.transform = CGAffineTransform(translationX: -0.6125, y: 0)
                        } completion: { _ in
                            UIView.animate(withDuration: 0.05) {
                                self.invalidView.transform = CGAffineTransform(translationX: 0, y: 0)
                            } completion: { _ in
                                print("Invalid Response")
                            }
                        }
                    }
                }
            }
        }
    }
}

extension IntroView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didClickedNextButton()
        return true
    }
}
