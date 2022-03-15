//
//  DivideView.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/10.
//

import Foundation
import SwiftUI

// challenge 2
struct DivideView: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct DivideView_Priviews: PreviewProvider {
    static var previews: some View {
        DivideView()
    }
}
