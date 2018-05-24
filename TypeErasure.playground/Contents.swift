//: Playground - noun: a place where people can play

import Foundation

// Collor
protocol Adaptable {}
protocol Describable {
    associatedtype AdapterType: Adaptable
    var adapter: AdapterType { get }
}

// Label
protocol LabelAdapterProtocol : Adaptable {
    var label: String { get }
}
struct TitleAdapter: LabelAdapterProtocol {
    var label: String = "UIKonf"
}
struct LabelDescriptor<T: LabelAdapterProtocol>: Describable {
    let adapter: T
    init(adapter: T) {
        self.adapter = adapter
    }
}

// Folder
struct FolderAdapter: Adaptable {
    let od: String = "Paris - Berlin"
}
struct FolderDescriptor: Describable {
    let adapter = FolderAdapter()
}

// Time
struct TimeAdapter: Adaptable {
    let time: String = "5h"
}
struct TimeDescriptor: Describable {
    let adapter = TimeAdapter()
}

struct AnyDescribable<AdapterType: Adaptable>: Describable {
    let adapter: AdapterType
    
    init<Descriptor: Describable>(_ descriptor: Descriptor) where Descriptor.AdapterType == AdapterType {
        adapter = descriptor.adapter
    }
}

// array of descriptors
let a = FolderDescriptor()
let b = LabelDescriptor(adapter: TitleAdapter())
let c = TimeDescriptor()
let descriptors = [AnyDescribable(a), AnyDescribable(b), AnyDescribable(c)]
