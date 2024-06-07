//
//  TestService.swift
//
//
//  Created by Kolos Foltanyi on 2023. 11. 24..
//

import Mockable
import Foundation

@Mockable
protocol TestService {

    // MARK: Associated Type

    associatedtype Color
    func getFavoriteColor() -> Color

    // MARK: Properties

    var name: String { get set }
    var computed: String { get }

    // MARK: Functions

    func getUser(for id: UUID) throws -> User
    func getUsers(for ids: UUID...) -> [User]
    func setUser(user: User) async throws -> Bool
    func modify(user: User) -> Int
    func update(products: [Product]) -> Int
    func print() throws

    // MARK: Generics

    func getUserAndValue<Value>(for id: UUID, value: Value) -> (User, Value)
    func delete<T>(for value: T) -> Int
    func retrieve<V>() -> V
    func retrieveItem<T, V>(item: T) -> V
}
