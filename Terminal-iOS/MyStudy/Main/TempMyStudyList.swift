//
//  TempMyStudyList.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation



struct MyStudy: Codable {
    let id: Int
    let title: String
    let location: String
    let image: String
}


class TempMyStudyList {
    static var List: [MyStudy] = [
        MyStudy(id: 0, title: "강남역 스터디", location: "강남역 어딘가", image: "swiftmain"),
        MyStudy(id: 9, title: "홍대역 잉겔스", location: "끝이 아니군", image: "android"),
        MyStudy(id: 8, title: "스위프트 스터디", location: "저녁에 햄버거", image: "frontend"),
        MyStudy(id: 7, title: "홍대 나의봄날", location: "먹기로 했었는데", image: "tensorflow"),
        MyStudy(id: 4, title: "사당역 더포도", location: "배가 좀 많이 안좋네", image: "node"),
        MyStudy(id: 3, title: "진짜 이름짓기 힘듬", location: "개오바쓰 오바쓰", image: "tensorflow"),
        MyStudy(id: 2, title: "이런게 제일 힘든듯", location: "담주 관악산등반", image: "swiftmain"),
        MyStudy(id: 5, title: "당신은 날 울리는", location: "살아서 돌아오길", image: "android"),
        MyStudy(id: 6, title: "땡벌 땡벌", location: "쨔스", image: "android"),
        MyStudy(id: 1, title: "오예 끝", location: "오우오우오우", image: "node")
    ]
}
