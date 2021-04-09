//
//  InputButton.swift
//  Brahmaand
//
//  Created by jaydeep on 08/04/21.
//

import UIKit

class InputButton: UIButton {

    private var myInputView = UIView()
    private var myInputAccessoryView: UIView?

    override var inputView: UIView {
        get {
            return self.myInputView
        }
        set {
            self.myInputView = newValue
        }
    }

    override var inputAccessoryView: UIView? {
        get {
            return self.myInputAccessoryView
        }
        set {
            self.myInputAccessoryView = newValue
        }
    }

    override var canBecomeFirstResponder: Bool { true }
}
