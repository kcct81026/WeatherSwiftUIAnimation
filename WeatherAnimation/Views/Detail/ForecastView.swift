//
//  ForecastView.swift
//  WeatherAnimation
//
//  Created by Kcct on 20/11/2024.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationPorated : CGFloat = 1
    @State private var selection = 0
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                // MARK: Segmented Control
                SegmentedControl(selection: $selection)
                
                // MARK: Forecast Cards
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 12){
                        if selection == 0 {
                            ForEach(Forecast.hourly){ forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                            }
                            .transition(.offset(x: -430))
                        } else {
                            ForEach(Forecast.weekly){ forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .weekly)
                            }
                            .transition(.offset(x: 430))
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                // MARK: Forecast Widgets
                Image("Forecast Widgets")
                    .opacity(bottomSheetTranslationPorated)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationPorated)
        .overlay {
            // MARK: Bottom Sheet Seperator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay{
            // MARK: Drag Indigator 
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 8)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ForecastView()
        .background(Color.background)
        .preferredColorScheme(.dark)
}
