//
//  UserProfile.swift
//  MatchMate
//
//  Created by Kumar Saurabh on 13/08/26.
//
import Foundation

struct UserProfile: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let location: String
    let bio: String
    let interests: [String]
    let compatibility: Int

    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        location: String,
        bio: String,
        interests: [String],
        compatibility: Int
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.location = location
        self.bio = bio
        self.interests = interests
        self.compatibility = compatibility
    }
}