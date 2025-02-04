//
//  StepFourStep.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation

struct StepFourStepRquest: Codable {
    let stepFourStep: [StepFourStep]
}

struct StepFourStep: Codable {
    let upperLocation: String
    let lowerLocation: String
}
