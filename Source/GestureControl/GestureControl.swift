//
//  GestureControl.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol GestureControlDelegate: class {
    func gestureControlDidSwipe(_ direction: UISwipeGestureRecognizer.Direction)
}

public class GestureControl: UIView {

    weak var delegate: GestureControlDelegate!
    
    public private(set) var swipeLeft: UISwipeGestureRecognizer!
    public private(set) var swipeRight: UISwipeGestureRecognizer!

    init(view: UIView, delegate: GestureControlDelegate) {
        self.delegate = delegate

        super.init(frame: CGRect.zero)

        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)

        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        view.addSubview(self)
        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            (view, self) >>>- {
                $0.attribute = attribute
                return
            }
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: actions

extension GestureControl {

    @objc dynamic func swipeHandler(_ gesture: UISwipeGestureRecognizer) {
        delegate.gestureControlDidSwipe(gesture.direction)
    }
}
