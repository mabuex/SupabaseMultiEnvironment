//
//  SupabaseMultiEnvironmentApp.swift
//  SupabaseMultiEnvironment
//
//  Created by Marcus Buexenstein on 3/6/25.
//

import SwiftUI

@main
struct SupabaseMultiEnvironmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

let supabase = Supabase.develop
