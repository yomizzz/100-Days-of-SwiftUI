//
//  ContentView.swift
//  BetterRest
//
//  Created by yomizzz on 2022/2/7.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var sleepTime = "00:00"
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            sleepTime = (wakeUp - prediction.actualSleep).formatted(date: .omitted, time: .shortened)
            
            /*
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            */
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
            
        }
        
        //showingAlert = true
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                } header: {
                    Text("When do you want to wake up?")
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                    
                } header: {
                    Text("Desired amount of sleep")
                }
                
                Section {
                    Picker("Number of coffee", selection: $coffeeAmount) {
                        ForEach(1..<21) {num in
                            if num == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(num) cups")
                            }
                        }
                    }
                    
                } header: {
                    Text("Daily coffee intake")
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("The time you should go to bed")
                    
                    Text(sleepTime)
                        .font(.largeTitle)
                    
                    
                }
                
                VStack {
                    Button("SleepTime", action: calculateBedtime)
                        
                }
                
                
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
                    
            }
            .navigationTitle("BetterRest")
            /*
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
             */
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
