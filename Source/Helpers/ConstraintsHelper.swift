//
//  ConstraintsHelper.swift
//  AnimatedPageView
//
//  Created by Alex K. on 13/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

struct ConstraintInfo {
    var attribute: NSLayoutAttribute = .left
    var secondAttribute: NSLayoutAttribute = .notAnAttribute
    var constant: CGFloat = 0
    var identifier: String?
    var relation: NSLayoutRelation = .equal
}

precedencegroup constOp {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator >>>-: constOp

@discardableResult
func >>>- <T: UIView>(left: (T, T), block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute

    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.0,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}

@discardableResult
func >>>- <T: UIView>(left: T, block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)

    let constraint = NSLayoutConstraint(item: left,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: nil,
                                        attribute: info.attribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.addConstraint(constraint)
    return constraint
}

@discardableResult
func >>>- <T: UIView>(left: (T, T, T), block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute

    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.2,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}
