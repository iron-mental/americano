//
//  ChatPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class ChatPresenter: ChatPresenterProtocol {
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
    
    func chatPaging() {
        interactor?.getPreChat()
    }
}

extension ChatPresenter: ChatInteractorOutputProtocol {
    func getLastChatResult(lastChat: [Chat]) {
        view?.hideLoading()
        view?.showLastChat(lastChat: lastChat)
    }
    
    func arrangedChatFromChat(chat: [Chat], reloadIndex: Int?) {
        view?.showSocketChat(socketChat: chat, reloadIndex: reloadIndex)
    }
    
    func emitFailed(uuid: String) {
        view?.emitFailed(uuid: uuid)
    }
    
    func showError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
    
    func getPreChatResult(pagingChat: [Chat]) {
        view?.showPagingChat(pagingChat: pagingChat)
    }
}
