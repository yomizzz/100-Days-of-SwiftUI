//
//  ContentView.swift
//  Unitconv
//
//  Created by yomizzz on 2022/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var numInput = 0.0
    @State private var unitInput = "Celsius"
    @State private var unitOutput = "Fahrenheit"
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var middleNum: Double {
        if unitInput == "Celsius" {
            return numInput
        } else if unitInput == "Fahrenheit" {
            return (numInput - 32.0) / 1.8
        } else {
            return numInput - 273.15
        }
    }
    
    var numOutput: Double {
        var num = 0.0
        
        if unitOutput == "Celsius" {
            num = middleNum
        } else if unitOutput == "Fahrenheit" {
            num = middleNum * 1.8 + 32.0
        } else {
            num =  middleNum + 273.15
        }
        
        return num
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Number", value: $numInput, format: .number)
                
                    Picker("the unit of input number", selection: $unitInput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                } header: {
                    Text("the number you want to convert")
                }
                
                Section {
                    Text(numOutput, format: .number)
                    
                    Picker("the unit of output number", selection: $unitOutput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                } header: {
                    Text("the output number")
                }
                
                .navigationTitle("UnitConvert")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
