//
//  ContentView.swift
//  Sentiment Analysis
//
//  Created by Ankur Batta on 25/08/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var userInput = ""
    @State private var sentimentPrediction = ""
    
    var body: some View {
        VStack {
            Text("Sentiment Analysis")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 100)
                .foregroundColor(Color.primary) // Use primary color for text
            Spacer()
            VStack {
                TextField("Enter your text here", text: $userInput)
                    .padding()
                    .background(Color(UIColor.systemBackground)) // Use system background color
                    .cornerRadius(3)
                    .shadow(radius: 3)
                Button(action: {
                    self.analyzeButton()
                }) {
                    Text("Analyze")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(Color.indigo)
                        .cornerRadius(50)
                }
                .padding()
                Text(sentimentPrediction)
                    .padding()
                    .font(Font(UIFont(name: "Arial", size: 100)!)) // Adjust font size
                    .foregroundColor(Color.primary) // Use primary color for text
                
            }
            .padding(.horizontal, 30)
            .cornerRadius(20)
            .padding()
            Spacer()
        }
    }
    
    private func analyzeButton() {
        let model = try! SentimentAnalysisClassifier(configuration: MLModelConfiguration())
        let input = SentimentAnalysisClassifierInput(text: userInput)
        
        guard let output = try? model.prediction(input: input) else {
            return
        }
        
        switch output.label {
        case "negative":
            sentimentPrediction = "☹️"
        case "neutral":
            sentimentPrediction = "😐"
        case "positive":
            sentimentPrediction = "😀"
        default:
            sentimentPrediction = "🤨"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark) // Set the environment to dark mode for preview
    }
}
