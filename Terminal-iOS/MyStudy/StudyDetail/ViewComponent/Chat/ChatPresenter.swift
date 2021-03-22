//
//  ChatPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ChatPresenter: ChatPresenterProtocol {
    weak var view: ChatViewProtocol?
    var wireFrame: ChatWireFrameProtocol?
    var interactor: ChatInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.connectSocket()
    }
    func emitButtonDidTap(message: String) {
        interactor?.emit(message: message)
    }
    func viewWillDisappear() {
        interactor?.disconnectSocket()
    }
    func showReceiveMessage(message: String) {
        view?.showMessage(message: message)
    }
}
