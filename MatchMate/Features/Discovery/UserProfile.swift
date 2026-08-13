//
//  UserProfile.swift
//  MatchMate
//
//  Created by Kumar Saurabh on 13/08/26.
//

import Foundation

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let location: String
    let bio: String
    let interests: [String]
    let compatibility: Int
}
