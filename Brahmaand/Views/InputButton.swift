//
//  InputButton.swift
//  Brahmaand
//
//  Created by jaydeep on 08/04/21.
//

import UIKit

class InputButton: UIButton {

    private var myInputView = UIView()

    override var inputView: UIView {
        get {
            return self.myInputView
        }
        set {
            self.myInputView = newValue
        }
    }

    override var canBecomeFirstResponder: Bool { true }
}
