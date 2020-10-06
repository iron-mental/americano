//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire

class CreateStudyRemoteManager: CreateStudyRemoteDataManagerProtocols {
    func postStudy(studyInfo: StudyInfo) -> Bool {
        let params : [String : Any] = [
            "userId" : studyInfo.userID,
            "category" : studyInfo.category,
            "title" : studyInfo.title,
            "introduce" : studyInfo.introduce,
            "progress" : studyInfo.progress,
            "studyTime" : studyInfo.studyTime,
            "snsNotion" : studyInfo.notion,
            "snsEvernote" : studyInfo.everNote,
            "snsWeb" : studyInfo.web,
            "location" : studyInfo.location,
            "locationSigungu" : studyInfo.location,
            "locationRo" : studyInfo.location,
            "locationDetail" : studyInfo.location
        ]
        var urlComponent = URLComponents(string: "http://3.35.154.27:3000/v1/study")
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data" ]
        guard let url = urlComponent?.url else { return true }
//        let imageData = UIImage(named: "test")?.jpegData(compressionQuality: 1.0)
        
        
//         위의 주석된 걸로 하면 asset에 넣어놓은 test이미지가 날라가구요 밑에 코드는 사진 실제로 선택해야 비어있지않고 잘날라가용
        let imageData = studyInfo.image.jpegData(compressionQuality: 1.0)
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            multipartFormData.append(imageData!, withName: "image", fileName: "\(studyInfo.userID).jpg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: header) { result in
            dump(result)
        }.resume()
        return true
        //        guard let endpoint = URL (string : "http://3.35.154.27:3000/v1/study") else {
        //            print ( "Error creating endpoint")
        //            return false
        //        }
        //        var request = URLRequest(url: endpoint)
        //        request.httpMethod = "POST"
        //        let boundary = "Boundary-\(UUID().uuidString)"
        //        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //        let mimeType = "image/jpg"
        //
        //        let params : [String : Any] = [
        //            "userId" : studyInfo.userID,
        //            "category" : studyInfo.category,
        //            "title" : studyInfo.title,
        //            "introduce" : studyInfo.introduce,
        //            "progress" : studyInfo.progress,
        //            "studyTime" : studyInfo.studyTime,
        //            "snsNotion" : studyInfo.notion,
        //            "snsEverNote" : studyInfo.everNote,
        //            "snsWeb" : studyInfo.web,
        //            "location" : studyInfo.location,
        //            "locationSigungu" : studyInfo.location,
        //            "locationRo" : studyInfo.location,
        //            "locationDetail" : studyInfo.location
        //        ]
        //
        //
        //        var body = Data()
        //        let boundaryPrefix = "--\(boundary)\r\n"
        //        for (key, value) in params {
        //            body.append(Data(boundaryPrefix.utf8))
        //            body.append(Data(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n").utf8))
        //            body.append(Data(("\(value)\r\n").utf8))
        //        }
        //        let imageData = UIImage(named: "test")?.jpegData(compressionQuality: 1.0)
        //        var filename = "image"
        //        body.append(Data(boundaryPrefix.utf8))
        //        body.append(Data(("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n\r\n").utf8))
        //        body.append(Data(("Content-Type: \(mimeType)\r\n\r\n").utf8))
        //        body.append(Data((imageData)!))
        //        body.append(Data(("\r\n").utf8))
        //        body.append(Data(("-".appending(boundary.appending("-"))).utf8))
        //        URLSession.shared.dataTask(with: request) { (data, response, error) in
        //            do {
        //                print(response)
        //                print(error)
        //            }
        //        }.resume()
    }
    func getNotionValid(id: String?) -> Bool {
        return true
    }
    func getEvernoteValid(url: String?) -> Bool{
        return true
    }
    func getWebValid(url: String?) -> Bool{
        return true
    }
}
