//
//  ActivityIndicatorView.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        return activity
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.startAnimating()
    }
}
