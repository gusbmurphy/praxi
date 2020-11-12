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
    var name: String = ""
    
    static func == (lhs: ExerciseVariable, rhs: ExerciseVariable) -> Bool {
        return lhs.name == rhs.name
    }
}

class ExerciseRangeVariable<T>: ExerciseVariable {
    var value: T? = nil
    
    init(name: String, value: T) {
        super.init()
        super.name = name
        self.value = value
    }
}

class ExerciseSetVariable<T>: ExerciseVariable {
    var members: [T] = []
    
    init(name: String, members: [T]) {
        super.init()
        super.name = name
        self.members = members
    }
}

extension Exercise {
    static let `default` = Self(
        name: "Exercise",
        image: Image("exerciseph"),
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam suscipit non massa in feugiat. Suspendisse fermentum, neque sed cursus convallis, purus dolor suscipit massa, sit amet egestas purus neque vel felis.",
        variables: [
            ExerciseSetVariable<String>(name: "Keys", members: ["C", "F", "Bb", "Eb", "Ab", "Db", "Gb", "B", "E", "A", "D", "G"]),
            ExerciseRangeVariable<Int>(name: "Temp", value: 72)
        ],
        areas: ["scales", "flexibility"]
    )
}
