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
        view?.showLoading()
        interactor?.connectSocket()
    }
    
    func viewRoadLastChat() {
        interactor?.mergeChatFromSocket()
    }
    
    func emitButtonDidTap(message: String) {
        interactor?.emit(message: message)
    }
    
    func viewWillDisappear() {
        interactor?.disconnectSocket()
    }
    
    func getLastChatResult(lastChat: [Chat]) {
        view?.hideLoading()
        view?.showLastChat(lastChat: lastChat)
    }
    
    func arrangedChatFromChat(chat: [Chat], reloadIndex: Int?) {
        view?.showSocketChat(socketChat: chat, reloadIndex: reloadIndex)
    }

    func showError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
    
    func emitFailed(uuid: String) {
        view?.emitFailed(uuid: uuid)
    }
    
    func chatPaging() {
        interactor?.getPreChat()
    }
    
    func getPreChatResult(pagingChat: [Chat]) {
        view?.showPagingChat(pagingChat: pagingChat)
    }
}
