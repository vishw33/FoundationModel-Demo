//
//  PlayGround.swift
//  Medium_Example
//
//  Created by Vishwas NG on 10/10/25.
//

import FoundationModels
import Playgrounds

#Playground {
    let model = SystemLanguageModel.default
    let instruction = """
        Act as a expert Swift Tutor and always give atleast one code example at the end
        """
    let session = LanguageModelSession(instructions:instruction)
    let response = try await session.respond(to: "explain UIKit in 100 words", generating:myResponseDetail.self)
}
