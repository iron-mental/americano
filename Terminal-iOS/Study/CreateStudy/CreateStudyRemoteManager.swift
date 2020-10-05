//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyRemoteManager: CreateStudyRemoteDataManagerProtocols {
    func postStudy(studyInfo: StudyInfo) -> Bool {
        guard let endpoint = URL (string : "3.35.154.27:3000/v1/study") else {
            print ( "Error creating endpoint")
            return false
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let mimeType = "image/jpg"
        let params : [String : Any] = [
            "userid" : studyInfo.userID,
            "category" : studyInfo.category,
            "title" : studyInfo.title,
            "introduce" : studyInfo.introduce,
            "progress" : studyInfo.progress,
            "studyTime" : studyInfo.studyTime,
            "location" : studyInfo.location,
            "notion" : studyInfo.notion,
            "everNote" : studyInfo.everNote,
            "web" : studyInfo.web
        ]
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in params {
            body.append(Data(boundaryPrefix.utf8))
            body.append(Data(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n").utf8))
            body.append(Data(("\(value)\r\n").utf8))
        }
        let imageData = studyInfo.image.jpegData(compressionQuality: 1.0)
        var filename = "image1"
        body.append(Data(boundaryPrefix.utf8))
        body.append(Data(("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n\r\n").utf8))
        body.append(Data(("Content-Type: \(mimeType)\r\n\r\n").utf8))
        body.append(Data(("\r\n").utf8))
        body.append(Data(("-".appending(boundary.appending("-"))).utf8))
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                dump(data)
                print("-----------------------")
                dump(response)
                print("-----------------------")
                dump(error)
            }
        }.resume()
        return true
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
