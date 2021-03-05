//
//  UITapGestureRecognizer.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/05.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum SignUpGuideState {
    case Privacy
    case TermsOfService
    case unowned
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel) -> SignUpGuideState {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize


        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        if NSLocationInRange(indexOfCharacter, NSRange(location: 8, length: 9)) {
            return .Privacy
        } else if NSLocationInRange(indexOfCharacter, NSRange(location: 17, length: 3)) {
            return .TermsOfService
        } else {
            return .unowned
        }
    }

}
