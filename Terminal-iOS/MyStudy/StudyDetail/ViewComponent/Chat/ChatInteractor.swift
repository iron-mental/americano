//
//  ChatInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ChatInteractor: ChatInteractorProtocol {
    weak var presenter: ChatPresenterProtocol?
    var remoteDataManager: ChatRemoteDataManagerProtocol?
    var localDataManager: ChatLocalDataManagerProtocol?
    var studyID: Int?
    var lastLocalChat: [String] = []
    var receiveFromSocketChat: [String] = []
    var mergeChatFlag = false
    var lastTimeStamp: Int?
    
    func connectSocket() {
//        if let localChat = 코어데이터 가지고온 후 localChat에 넣어주기
//        remoteDataManager?.socketConnect(studyID: studyID!)
    }
    func emit(message: String) {
        let test = Chat(studyID: studyID!,
                        nickname: "재인",
                        message: message,
                        date: "testDate")
        CoreDataManager.shared.saveChatInfo(studyID: studyID!, chatList: [test])
        remoteDataManager?.emit(message: message)
//        CoreDataManager.shared.getCurrentChatInfo(studyID: studyID!)
    }
    func disconnectSocket() {
        remoteDataManager?.disconnectSocket()
    }
    func getLastLocalChat() {
        //코어 데이터로부터 과거에 저장한 채팅을 가지고옴
        //        lastLocalChat = CoreDataManager.get
    }
    func receiveMessage(message: Chat) {
        //소켓을 통해 들어온 메세지는 그저 이곳에 저장만
//        receiveFromSocketChat.append(message)
        arrangeChat()
    }
    func receiveLastChat(lastRemoteChat: [String]) {
        //리모트로부터 과거에 저장된 채팅을 가지고옴
        //합쳐주고
        _ = lastLocalChat + lastRemoteChat
        //프레젠터로 넘겨주고
        //        presenter.getLastChatResult(lastChat: wholeLastChat)
        //기준이 될 라스트 스탬프 할당 해준뒤
        //        lastTimeStamp = lastRemoteChat.last.timeStamp
        // 스위치 온!! 하면 뷰에 arrangeChat이 먼저도착할지 어떻게알아 확실하게 뷰에 다뿌려졌으면 다시 뷰->프레젠터->mergeChatFlag on해서 뷰로 넘겨주는걸로 하자 ㅇ.ㅇ
//        mergeChatFlag = true
    }
    func arrangeChat() {
        //스위치도 켜져있고 소켓으로 넘어온 메세지가 있다면
//        while mergeChatFlag
//                && !receiveFromSocketChat.isEmpty{
//            //타임 스탬프보다 전 메세지면 그걸 그냥 지워
//            if lastTimeStamp! >= receiveFromSocketChat.first.timeStamp {
//                receiveFromSocketChat.removeFirst()
//            } else if {
//            //타임스탬프 기준보다 나중 메세지면 뷰로 보내자
//                presenter?.showReceiveMessage(message: receiveFromSocketChat.first)
//            }
//        }
    }
}
