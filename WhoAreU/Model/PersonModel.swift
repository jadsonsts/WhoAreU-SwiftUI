//
//  PersonModel.swift
//  WhoAreU
//
//  Created by Jadson on 22/12/22.
//

import Foundation

struct PersonModel: Equatable, Identifiable {
    var id: Int?
    var title: String?
    var image: String?
}

extension PersonModel {
    static func allPerson() -> [PersonModel] {
        return [PersonModel(id: 0, title: "PARENT", image: "parent"),
                PersonModel(id: 1, title: "CHILD", image: "Child"),
                PersonModel(id: 2, title: "TEACHER", image: "teacher")]
    }
}
