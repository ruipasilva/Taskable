//
//  ClearButtonModifier.swift
//  Taskable
//
//  Created by Rui Silva on 10/03/2021.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    @EnvironmentObject var dataController: DataController
    
    func body(content: Content) -> some View {
        
        HStack {
            content
            if !text.isEmpty {
                Button(
                    action: {
                        self.text = ""
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}
