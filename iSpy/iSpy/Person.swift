//
//  Person.swift
//  iSpy
//
//  Created by Jr Carreiro on 19/08/25.
//
class Person {
    var name: String
    var age: UInt
    
    init(name: String, age: UInt) {
        self.name = name
        self.age = age
    }
    
    func greet() {
        print("Hello, I am \(name) and I am \(age) years old")
    }
}
