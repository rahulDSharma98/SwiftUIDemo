//
//  Temp.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 15/01/26.
//

import SwiftUI
import Combine

struct Temp: View {
    @Environment(\.self) var environment
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ColorPickerView()
        } else {
            // Fallback on earlier versions
        }
    }
}

@available(iOS 17.0, *)
struct ColorPickerView: View {
//    @Environment(\.self) var environment
    
    @State private var currentColor: Color = .red
    @State private var resolvedColor: Color.Resolved? = nil
    
    @State private var isAnimating: Bool = false
    
    @State var resolvedColorJSON: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button {
                isAnimating.toggle()
            } label: {
                Text("Select Color")
            }
            .font(.headline)
            .bold()
            .padding()
            .padding(.horizontal, 10)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            ./*fullScreenCover*/sheet(isPresented: $isAnimating) {
                ColorPickerWheelView(currentColor: $currentColor, resolvedColor: $resolvedColor, resolvedColorJSON: $resolvedColorJSON)
            }
            
            ColorPickerResultView(resolvedColor: $resolvedColor, resolvedColorJSON: $resolvedColorJSON)
            
            Rectangle()
                .fill(Color.Resolved(red: resolvedColor?.red ?? 0, green: resolvedColor?.green ?? 0, blue: resolvedColor?.blue ?? 0, opacity: resolvedColor?.opacity ?? 1))
                .frame(width: 200, height: 100)
                .cornerRadius(10)
            
            Button {
                isAnimating.toggle()
            } label: {
                Label {
                    Text("Animate")
                } icon: {
                    isAnimating ? Image(systemName: "checkmark") : Image(systemName: "mail.stack")
                }
            }
            .symbolEffect(.variableColor.cumulative, options: .repeat(3).speed(0.5), value: isAnimating)
            .foregroundStyle(Color.black)
            .font(.largeTitle)
        }
        .padding()
    }
    /*
    func getColor() {
        resolvedColor = currentColor.resolve(in: environment)
        
        if let resolvedColorJSONData = try? JSONEncoder().encode(resolvedColor),
           let resolvedColorJSON = String(data: resolvedColorJSONData, encoding: .utf8) {
            self.resolvedColorJSON = resolvedColorJSON
        }
    }*/
}

@available(iOS 17.0, *)
struct ColorPickerResultView: View {
    @Binding var resolvedColor: Color.Resolved?
    @Binding var resolvedColorJSON: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let resolvedColor {
                Text("Red: \(resolvedColor.red)")
                Text("Green: \(resolvedColor.green)")
                Text("Blue: \(resolvedColor.blue)")
                Text("Alpha: \(resolvedColor.opacity)")
            }
            
            Text("Color JSON: \(resolvedColorJSON)")
        }
    }
}

@available(iOS 17.0, *)
struct ColorPickerWheelView: View {
    @Environment(\.self) var environment
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var currentColor: Color
    @Binding var resolvedColor: Color.Resolved?
    
    @Binding var resolvedColorJSON: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .padding()
            .foregroundStyle(.black)
            .background(.blue)
            
            Spacer(minLength: 10).frame(height: 5)
            
            ColorPicker("Select Color", selection: $currentColor)
                .onChange(of: currentColor, initial: true, getColor)
        }
        .padding()
    }
    
    func getColor() {
        resolvedColor = currentColor.resolve(in: environment)
        
        if let resolvedColorJSONData = try? JSONEncoder().encode(resolvedColor),
           let resolvedColorJSON = String(data: resolvedColorJSONData, encoding: .utf8) {
            self.resolvedColorJSON = resolvedColorJSON
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        Temp()
    } else {
        // Fallback on earlier versions
    }
}
