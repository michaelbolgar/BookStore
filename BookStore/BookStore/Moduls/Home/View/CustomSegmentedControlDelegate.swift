//
//  CustomSegmentedControlDelegate.swift
//  BookStore
//
//  Created by Сазонов Станислав on 07.12.2023.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    
    func buttonPressed(selectedSegment: TrendingPeriod)
}
