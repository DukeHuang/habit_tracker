//
//  ContentView.swift
//  Habit_Tracker
//
//  Created by sakuragi on 2025/1/29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedItem: Item = items.first!
    @State private var introItems: [Item] = items
    @State private var activeIndex: Int = 0
    var body: some View {
        VStack(spacing: 0) {
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.green.gradient)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)

            
            
            ZStack {
                ForEach(items) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxHeight: .infinity)
            
            VStack(spacing: 6) {
                ///Progress Indicator View
                HStack(spacing: 4) {
                    ForEach(introItems) { item in
                        Capsule()
                            .fill(selectedItem.id == item.id ? Color.primary : .gray)
                            .frame(width: selectedItem.id == item.id ? 25 : 4, height: 4)
                        
                    }
                }
                .padding(.bottom, 15)
                
                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                Text("Lorem Ipsum is simply dummy text.")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                /// Next/Continue Button
                Button {
                    updateItem(isForward: true)
                } label: {
                    Text(selectedItem.id == introItems.last?.id ? "Continue" : "Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 250)
                        .padding(.vertical,12)
                        .background(.green.gradient, in:.capsule)
                }
                .padding(.top, 25)
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: Item) -> some View {
        let isSelected = selectedItem.id  == item.id
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120, height: 120)
            .background(.green.gradient,in:.rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius:1 , x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius:1 , x: -1, y: -1)
                    .padding(-3)
                    .opacity(selectedItem.id == item.id ? 1 : 0)
            }
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            .zIndex(isSelected ? 2 : item.zindex)
//            .border(.gray)
    }
    
    func updateItem(isForward: Bool) {
        guard activeIndex != introItems.count - 1 else { return }
       
        activeIndex += 1
        
        let fromIndex = activeIndex - 1
        /// 重置所有项的 ZIndex
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        
        withAnimation(.bouncy(duration: 3)) {
            print(introItems[activeIndex])
            // 当前项移动到下一项的初始位置
            introItems[fromIndex].scale = introItems[activeIndex].scale
            introItems[fromIndex].rotation = introItems[activeIndex].rotation
            introItems[fromIndex].anchor = introItems[activeIndex].anchor
            introItems[fromIndex].offset = introItems[activeIndex].offset
            
            // 下一项重置到默认状态
            introItems[activeIndex].scale = 1
            introItems[activeIndex].rotation = .zero
            introItems[activeIndex].anchor = .center
            introItems[activeIndex].offset = .zero
            
            introItems[fromIndex].zindex = 1
            
            selectedItem = introItems[activeIndex]
        }
    }
}

#Preview {
    ContentView()
}
