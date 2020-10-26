//
//  Exercise.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import Foundation

struct Exercise {
    var name: String
    var imageName: String?
    var description: String
    var variables: [ExerciseVariable]
    var areas: [String]
    
    static let `default` = Self(
        name: "Exercise",
        imageName: "exerciseph",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam suscipit non massa in feugiat. Suspendisse fermentum, neque sed cursus convallis, purus dolor suscipit massa, sit amet egestas purus neque vel felis.",
        variables: [
            ExerciseVariable(name: "Tempo", type: "range"),
            ExerciseVariable(name: "Scales", type: "set", setMembers: ["C", "F", "Bb", "Eb", "Ab", "Db", "Gb", "B", "E", "A", "D", "G"])
        ],
        areas: ["scales", "flexibility"]
    )
}

struct ExerciseVariable: Hashable {
    var name, type: String
    var setMembers: [String] = []
    
    func getSetMembersString() -> String {
        return setMembers.reduce("", {
            $0 == "" ? $1 : $0 + ", " + $1
        })
    }
}