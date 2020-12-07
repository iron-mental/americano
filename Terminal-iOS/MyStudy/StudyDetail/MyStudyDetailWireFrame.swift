//
//  MyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyDetailWireFrame: MyStudyDetailWireFrameProtocol {
    
    
    var presenter: MyStudyDetailPresenterProtocol?
    
    static func createMyStudyDetailModule(studyID: Int) -> UIViewController {
        let view = MyStudyDetailView()
        let presenter = MyStudyDetailPresenter()
        let interactor = MyStudyDetailInteractor()
        let remoteDataManager = MyStudyDetailRemoteDataManager()
        let localDataManager = MyStudyDetailLocalManager()
        let wireFrame = MyStudyDetailWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        presenter.view = view
        print(view)
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        interactor.localDatamanager = localDataManager
        wireFrame.presenter = presenter
        
        return view
    }
    
    func goToAddNotice(studyID: Int, parentView: UIViewController) {
        let view = AddNoticeWireFrame.createAddNoticeModule(studyID: studyID, notice: nil, parentView: parentView, state: .new)
        parentView.present(view, animated: true) {
            print("뷰 띄움")
        }
    }
    
    func goToEditStudy(study: StudyDetail, parentView: UIViewController) {
        let view = CreateStudyWireFrame.createStudyViewModul(category: study.category, studyDetail: study, state: .edit, parentView: parentView)
        parentView.present(view, animated: true) {
            print("뷰띄워줌")
        }
    }
    
    func goToNoticeDetail(notice: Int, studyID: Int, parentView: UIViewController) {
        let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: notice, studyID: studyID, parentView: parentView)
        parentView.present(view, animated: true) {
            print("아무화면에서나 공지사항 추가하면 뜰거임")
        }
    }
}
