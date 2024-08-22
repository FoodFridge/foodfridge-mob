//
//  OnBoardingScreen.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/20/24.
//

import SwiftUI

struct OnBoardingScreen: View {
    
    @State private var step = 1
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                // Background color
                Color(.white)
                    .ignoresSafeArea()
               
                VStack{
                        Text("Welcome to")
                            .font(.largeTitle)
                            .foregroundStyle(Color(.button1))
                            .padding(.top)
                        Text("FoodFridge")
                            .font(Font.custom("CourierPrime-Bold", size: 36))
                            .foregroundStyle(Color(.button1))
                        
                        GeometryReader { gp in
                            HStack {
                                VStack {
                                    Image("ingredients")
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                    
                                    Text("Recipes ideas with ingredient available\n in your fridge")
                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 25))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .minimumScaleFactor(0.5)
                                        .padding(.top, -20)
                                        .padding()
                                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8).delay(0.1), value: step)
                                }
                                .offset( y: -60)
                                .frame(width: gp.frame(in: .global).width)
                                
                                VStack(spacing: 50) {
                                    Image("zero")
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                    Text("Go green, Keep no waste!")
                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 25))
                                        .padding(.top, -60)
                                        .padding()
                                        .fixedSize(horizontal: false, vertical: true)
                                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8).delay(0.1), value: step)
                                }
                                .offset( y: -60)
                                .frame(width: gp.frame(in: .global).width)
                                
                                VStack(spacing: 50) {
                                    Image("peopleCooking")
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                    Text("Cooking and Exploring tons of recipes you may like")
                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 25))
                                        .padding(.top, -60)
                                        .padding()
                                        .fixedSize(horizontal: false, vertical: true)
                                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8).delay(0.1), value: step)
                                }
                                .offset( y: -60)
                                .frame(width: gp.frame(in: .global).width)
                            }
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(.black))
                            .font(.title)
                            .padding(.vertical, 60)
                            .frame(width: gp.frame(in: .global).width * 3) // Make HStack 3X width of device
                            .frame(maxHeight: .infinity)
                            .offset(x: step == 1 ? 0
                                    : step == 2 ? -gp.frame(in: .global).width
                                    : -gp.frame(in: .global).width * 2)
                            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8), value: step)
                        }
                        
                        HStack(spacing: 20) {
                            Button(action: { step = 1 }) {
                                Image(systemName: "chevron.forward")
                                    .padding()
                                    .background(Circle().fill(Color(.button2)).shadow(radius: 10))
                                    .foregroundStyle(step == 1 ? Color(.button1) : Color(.clear))
                                    .scaleEffect(step == 1 ? 1 : 0.65)
                            }
                            
                            Button(action: { step = 2 }) {
                                Image(systemName: "chevron.forward")
                                    .padding()
                                    .background(Circle().fill(Color(.button2)).shadow(radius: 10))
                                    .foregroundStyle(step == 2 ? Color(.button1) : Color(.clear))
                                    .scaleEffect(step == 2 ? 1 : 0.65)
                            }
                            
                            Button(action: { step = 3 }) {
                                Image(systemName: "chevron.forward")
                                    .padding()
                                    .background(Circle().fill(Color(.button2)).shadow(radius: 10))
                                    .foregroundStyle(step == 3 ? Color(.clear) : Color(.clear))
                                    .scaleEffect(step == 3 ? 1 : 0.65)
                            }
                        }
                        .padding(.bottom, -5)
                        .animation(.spring(response: 0.4, dampingFraction: 0.5), value: step)
                        .font(.largeTitle)
                        .tint(Color(.button3))
                        
                        Button {
                            navigationController.currentView = .authentication
                        }label: {
                            HStack {
                                Text("Continue")
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal)
                            .padding()
                            .background(Capsule().fill(Color(.button1)))
                            .foregroundStyle(Color(.button5))
                            .opacity(step == 3 ? 1 : 0)
                            .animation(.none, value: step) // adjust to animate the opacity
                            .scaleEffect(step == 3 ? 1 : 0.01)
                            .animation(Animation.interpolatingSpring(stiffness: 50, damping: 10, initialVelocity: 10), value: step)
                            .padding(.bottom, 5)
                        }
                       
                        
                    }
                }
               //set elements to be adaptive in any screen size
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
}
#Preview {
    OnBoardingScreen()
}

