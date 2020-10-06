//
//  SelectLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationWireFrame: SelectLocationWireFrameProtocol {
    static func selectLocationViewModul() -> UIViewController {
        //여기서 view presenter 어쩌고 저쩌고 다할당 시켜서 리턴
        return SelectLocationView()
    }
}
