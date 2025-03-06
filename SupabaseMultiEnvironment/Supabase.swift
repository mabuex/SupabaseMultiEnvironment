//
//  Supabase.swift
//  SupabaseMultiEnvironment
//
//  Created by Marcus Buexenstein on 3/6/25.
//

import Foundation
import Supabase

fileprivate enum SupabaseEnvironment: String {
    case develop = "Develop"
    case production = "Production"
    
    var supabaseURL: URL {
        url(self)
    }
    
    var supabaseKey: String {
        key(self)
    }
}

extension SupabaseEnvironment {
    func url(_ environment: Self) -> URL {
        if let dictionary = Bundle.main.infoDictionary?["Supabase Url"] as? [String : String] {
            if let urlString = dictionary[environment.rawValue], let url = URL(string: urlString) {
                return url
            }
        }
        
        fatalError("Please set the correct Supabase Url in Supabase.xcconfig file.")
    }
    
    func key(_ environment: Self) -> String {
        if let dictionary = Bundle.main.infoDictionary?["Supabase Anon Key"] as? [String : String] {
            if let anonKey = dictionary[environment.rawValue] {
                return anonKey
            }
        }
        
        fatalError("Please set the correct Supabase Anon Key in Supabase.xcconfig file.")
    }
}

final class Supabase {
    let client: SupabaseClient
    
    static let production = Supabase(.production)
    static let develop = Supabase(.develop)
    
    let baseUrl: URL
    
    private init(_ environment: SupabaseEnvironment) {
        client = SupabaseClient(
            supabaseURL: environment.supabaseURL,
            supabaseKey: environment.supabaseKey
        )
        
        self.baseUrl = environment.supabaseURL
    }
}
