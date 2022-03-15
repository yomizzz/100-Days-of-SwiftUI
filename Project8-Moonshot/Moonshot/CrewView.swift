//
//  CrewView.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/10.
//

import Foundation
import SwiftUI

// challenge 2
struct CrewView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { CrewMember in
                    NavigationLink {
                        AstronautView(astronaut: CrewMember.astronaut)
                    } label: {
                        HStack {
                            Image(CrewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(CrewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(CrewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

// 如何创建一个预览视图感觉是个难点
struct CrewView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CrewView(crew: [CrewMember(role: "Command Pilot", astronaut: astronauts["grissom"]!)])
            .preferredColorScheme(.dark)
    }
 
}

