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
    var records: [ExerciseRecord] = []
    let id = UUID()
}

enum ExerciseType: String {
    case generic = "generic"
    case range = "range"
    case set = "set"
}

class ExerciseVariable: Hashable {
    var name: String = ""
    var type: ExerciseType {
        return .generic
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(ObjectIdentifier(self))
    }

    static func == (lhs: ExerciseVariable, rhs: ExerciseVariable) -> Bool {
        return lhs.name == rhs.name
    }
}

class ExerciseRangeVariable: ExerciseVariable {
    var value: Int = 0
    override var type: ExerciseType {
        return .range
    }
    
    init(name: String, value: Int) {
        super.init()
        super.name = name
        self.value = value
    }
}

class ExerciseSetVariable: ExerciseVariable {
    var members: [String] = []
    override var type: ExerciseType {
        return .set
    }

    init(name: String, members: [String]) {
        super.init()
        super.name = name
        self.members = members
    }
}

struct ExerciseRecord {
    var date = Date()
    var variableValues: [ExerciseVariable: Any] = [:]
    var id = UUID()

    static func == (lhs: ExerciseRecord, rhs: ExerciseRecord) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Exercise {
    static let `default` = Self(
        name: "Exercise",
        image: Image("exerciseph"),
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam suscipit non massa in feugiat. Suspendisse fermentum, neque sed cursus convallis, purus dolor suscipit massa, sit amet egestas purus neque vel felis.",
        variables: [
            ExerciseSetVariable(name: "Keys", members: ["C", "F", "Bb", "Eb", "Ab", "Db", "Gb", "B", "E", "A", "D", "G"]),
            ExerciseRangeVariable(name: "Temp", value: 72)
        ],
        areas: ["scales", "flexibility"]
    )
}
