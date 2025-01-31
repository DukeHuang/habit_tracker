//
//  Item.swift
//  Habit_Tracker
//
//  Created by sakuragi on 2025/1/29.
//

import SwiftUI

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotation: CGFloat = 0
    var zindex: CGFloat = 0
    /// As you can observe, the ZIndex won't have any animation effects, Therefore, I'll modify the offset value when it starts moving and reset its original offset value after a slight delay. This will ultimately make the icons appear to be swapping.
    var extraOffset: CGFloat = -350
    
}

/// Sample Intro page items
var items: [Item] = [
    .init(image: "figure.walk.circle.fill", title: "Keep an eye on your workout."),
    .init(
        image: "figure.run.circle.fill",
        title: "Maintain your cardio fitness",
        scale: 0.6,
        anchor: .topLeading,
        offset: -70,
        rotation: 30
    ),
    .init(
        image: "figure.badminton.circle.fill",
        title: "Take a break from work and relax.",
        scale: 0.5,
        anchor: .bottomLeading,
        offset: -60,
        rotation: -35
    ),
    .init(
        image: "figure.climbing.circle.fill",
        title: "Turn climbing into a hobby",
        scale: 0.4,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 160,
        extraOffset: -120
    ),
    .init(
        image: "figure.cooldown.circle.fill",
        title: "Cool down after a workout",
        scale: 0.35,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 250,
        extraOffset: -100
    )
]
