//
//  Exercise.swift
//  Praxi
//
//  Created by Augustus Murphy on 10/26/20.
//

import Foundation
import SwiftUI

struct Exercise {
    var name: String
    var image: Image?
    var description: String
    var variables: [ExerciseVariable]
    var areas: [String]
//    var records: [ExerciseRecord] = []
    let id: UUID = UUID()
}

class ExerciseVariable {
    var name = ""
    
    static func == (lhs: ExerciseVariable, rhs: ExerciseVariable) -> Bool {
        return lhs.name == rhs.name
    }
}

class ExerciseRangeVariable<T>: ExerciseVariable {
    var value: T? = nil
}

class ExerciseSetVariable<T>: ExerciseVariable {
    var members: [T] = []
}

//struct ExerciseRecord: Hashable {
//    var date: Date
//    var variableValues: [String: Any] = [:]
//    var id: UUID = UUID()
//
//    static func == (lhs: ExerciseRecord, rhs: ExerciseRecord) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

//extension Exercise {
//    static let `default` = Self(
//        name: "Exercise",
//        image: Image("exerciseph"),
//        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam suscipit non massa in feugiat. Suspendisse fermentum, neque sed cursus convallis, purus dolor suscipit massa, sit amet egestas purus neque vel felis.",
//        variables: [
//            ExerciseVariable(name: "Tempo", type: "range"),
//            ExerciseVariable(name: "Scales", type: "set", setMembers: ["C", "F", "Bb", "Eb", "Ab", "Db", "Gb", "B", "E", "A", "D", "G"])
//        ],
//        areas: ["scales", "flexibility"]
//    )
//}
