//
//  StudyCheck.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/25.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class StudyCheck {
    static func execute(study: StudyDetailPost) -> StudyNilCheck {
        let location = study.location ?? nil
        
        if study.category.isEmpty {
            return StudyNilCheck(message: "카테고리가 지정되어있지 않습니다.", label: "category")
        } else if study.title!.isEmpty {
            return StudyNilCheck(message: "제목을 입력해주세요", label: "title")
        } else if study.introduce!.isEmpty {
            return StudyNilCheck(message: "소개를 입력해주세요", label: "introduce")
        } else if let notion = study.snsNotion {
            if !notion.notionCheck() {
                return StudyNilCheck(message: "Notion URL이 정확하지 않습니다.", label: "sns_notion")
            } else if let evernote = study.snsEvernote {
                if !evernote.evernoteCheck() {
                    return StudyNilCheck(message: "Evernote URL이 정확하지 않습니다.", label: "sns_evernote")
                } else if let web = study.snsWeb {
                    if !web.webCheck() {
                        return StudyNilCheck(message: "web URL이 정확하지 않습니다.", label: "sns_web")
                    }
                }
            }
        } else if study.progress!.isEmpty {
            return StudyNilCheck(message: "진행을 입력해주세요", label: "progress")
        } else if location == nil {
            return StudyNilCheck(message: "장소를 선택해주세요.", label: "locaion_detail")
        } else if study.studyTime!.isEmpty {
            return StudyNilCheck(message: "시간을 입력해주세요", label: "study_time")
        }
        
        return StudyNilCheck(message: "성공", label: nil)
    }
}
