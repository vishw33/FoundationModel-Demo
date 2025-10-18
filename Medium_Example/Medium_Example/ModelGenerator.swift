//
//  ModelGenerator.swift
//  Medium_Example
//
//  Created by Vishwas NG on 11/10/25.
//

import FoundationModels
import SwiftUI

@Generable
struct myResponseDetail:Equatable {
    @Guide(description: "Detail response for given prompt")
    var name:String = ""
    @Guide(description: "Detail response for given prompt")
    var Description:String = ""
    @Guide(description: "Assert the source URL from where you got information or any URL where you can get more information")
    var url:String = ""
}

@Observable public class ModelGenerator {
    
    let model = SystemLanguageModel.default
    let session:LanguageModelSession
    var response: myResponseDetail.PartiallyGenerated?
    
    init () {
        session =  LanguageModelSession()
    }
    
    func getResponse(for prompt:String) async throws   {
        do {
            let tokens = session.streamResponse(to: prompt,  generating: myResponseDetail.self)
            for try await token in tokens {
                response = token.content
            }
        }
        catch {
            print("This is Catch Block \(error.localizedDescription)")
        }
    }
}
