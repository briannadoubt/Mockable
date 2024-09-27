//
//  ExoticParameterTests.swift
//  
//
//  Created by Kolos Foltanyi on 2023. 11. 21..
//

import MacroTesting
import XCTest

final class ExoticParameterTests: MockableMacroTestCase {
    func test_inout_parameter() {
        assertMacro {
          """
          @Mockable
          protocol Test {
              func modifyValue(_ value: inout Int)
          }
          """
        } expansion: {
            """
            protocol Test {
                func modifyValue(_ value: inout Int)
            }

            #if MOCKING
            final class MockTest: Test, Mockable.MockableService {
                typealias Mocker = Mockable.Mocker<MockTest>
                private let mocker = Mocker()
                @available(*, deprecated, message: "Use given(_ service:) of Mockable instead. ")
                func given() -> ReturnBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use when(_ service:) of Mockable instead. ")
                func when() -> ActionBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use verify(_ service:) of MockableTest instead. ")
                func verify(with assertion: @escaping Mockable.MockableAssertion) -> VerifyBuilder {
                    .init(mocker: mocker, assertion: assertion)
                }
                func reset(_ scopes: Set<Mockable.MockerScope> = .all) {
                    mocker.reset(scopes: scopes)
                }
                init(policy: Mockable.MockerPolicy? = nil) {
                    if let policy {
                        mocker.policy = policy
                    }
                }
                func modifyValue(_ value: inout Int) {
                    let member: Member = .m1_modifyValue(.value(value))
                    mocker.mock(member) { producer in
                        let producer = try cast(producer) as (inout Int) -> Void
                        return producer(&value)
                    }
                }
                enum Member: Mockable.Matchable, Mockable.CaseIdentifiable {
                    case m1_modifyValue(Parameter<Int>)
                    func match(_ other: Member) -> Bool {
                        switch (self, other) {
                        case (.m1_modifyValue(let leftParam1), .m1_modifyValue(let rightParam1)):
                            return leftParam1.match(rightParam1)
                        }
                    }
                }
                struct ReturnBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func modifyValue(_ value: Parameter<Int>) -> Mockable.FunctionReturnBuilder<MockTest, ReturnBuilder, Void, (inout Int) -> Void> {
                        .init(mocker, kind: .m1_modifyValue(value))
                    }
                }
                struct ActionBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func modifyValue(_ value: Parameter<Int>) -> Mockable.FunctionActionBuilder<MockTest, ActionBuilder> {
                        .init(mocker, kind: .m1_modifyValue(value))
                    }
                }
                struct VerifyBuilder: Mockable.AssertionBuilder {
                    private let mocker: Mocker
                    private let assertion: Mockable.MockableAssertion
                    init(mocker: Mocker, assertion: @escaping Mockable.MockableAssertion) {
                        self.mocker = mocker
                        self.assertion = assertion
                    }
                    func modifyValue(_ value: Parameter<Int>) -> Mockable.FunctionVerifyBuilder<MockTest, VerifyBuilder> {
                        .init(mocker, kind: .m1_modifyValue(value), assertion: assertion)
                    }
                }
            }
            #endif
            """
        }
    }

    func test_variadic_parameter() {
        assertMacro {
          """
          @Mockable
          protocol Test {
              func printValues(_ values: Int...)
          }
          """
        } expansion: {
            """
            protocol Test {
                func printValues(_ values: Int...)
            }

            #if MOCKING
            final class MockTest: Test, Mockable.MockableService {
                typealias Mocker = Mockable.Mocker<MockTest>
                private let mocker = Mocker()
                @available(*, deprecated, message: "Use given(_ service:) of Mockable instead. ")
                func given() -> ReturnBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use when(_ service:) of Mockable instead. ")
                func when() -> ActionBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use verify(_ service:) of MockableTest instead. ")
                func verify(with assertion: @escaping Mockable.MockableAssertion) -> VerifyBuilder {
                    .init(mocker: mocker, assertion: assertion)
                }
                func reset(_ scopes: Set<Mockable.MockerScope> = .all) {
                    mocker.reset(scopes: scopes)
                }
                init(policy: Mockable.MockerPolicy? = nil) {
                    if let policy {
                        mocker.policy = policy
                    }
                }
                func printValues(_ values: Int...) {
                    let member: Member = .m1_printValues(.value(values))
                    mocker.mock(member) { producer in
                        let producer = try cast(producer) as ([Int]) -> Void
                        return producer(values)
                    }
                }
                enum Member: Mockable.Matchable, Mockable.CaseIdentifiable {
                    case m1_printValues(Parameter<[Int]>)
                    func match(_ other: Member) -> Bool {
                        switch (self, other) {
                        case (.m1_printValues(let leftParam1), .m1_printValues(let rightParam1)):
                            return leftParam1.match(rightParam1)
                        }
                    }
                }
                struct ReturnBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func printValues(_ values: Parameter<[Int]>) -> Mockable.FunctionReturnBuilder<MockTest, ReturnBuilder, Void, ([Int]) -> Void> {
                        .init(mocker, kind: .m1_printValues(values))
                    }
                }
                struct ActionBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func printValues(_ values: Parameter<[Int]>) -> Mockable.FunctionActionBuilder<MockTest, ActionBuilder> {
                        .init(mocker, kind: .m1_printValues(values))
                    }
                }
                struct VerifyBuilder: Mockable.AssertionBuilder {
                    private let mocker: Mocker
                    private let assertion: Mockable.MockableAssertion
                    init(mocker: Mocker, assertion: @escaping Mockable.MockableAssertion) {
                        self.mocker = mocker
                        self.assertion = assertion
                    }
                    func printValues(_ values: Parameter<[Int]>) -> Mockable.FunctionVerifyBuilder<MockTest, VerifyBuilder> {
                        .init(mocker, kind: .m1_printValues(values), assertion: assertion)
                    }
                }
            }
            #endif
            """
        }
    }

    func test_closure_parameter() {
        assertMacro {
          """
          @Mockable
          protocol Test {
              func execute(operation: @escaping () throws -> Void)
          }
          """
        } expansion: {
            """
            protocol Test {
                func execute(operation: @escaping () throws -> Void)
            }

            #if MOCKING
            final class MockTest: Test, Mockable.MockableService {
                typealias Mocker = Mockable.Mocker<MockTest>
                private let mocker = Mocker()
                @available(*, deprecated, message: "Use given(_ service:) of Mockable instead. ")
                func given() -> ReturnBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use when(_ service:) of Mockable instead. ")
                func when() -> ActionBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use verify(_ service:) of MockableTest instead. ")
                func verify(with assertion: @escaping Mockable.MockableAssertion) -> VerifyBuilder {
                    .init(mocker: mocker, assertion: assertion)
                }
                func reset(_ scopes: Set<Mockable.MockerScope> = .all) {
                    mocker.reset(scopes: scopes)
                }
                init(policy: Mockable.MockerPolicy? = nil) {
                    if let policy {
                        mocker.policy = policy
                    }
                }
                func execute(operation: @escaping () throws -> Void) {
                    let member: Member = .m1_execute(operation: .value(operation))
                    mocker.mock(member) { producer in
                        let producer = try cast(producer) as (@escaping () throws -> Void) -> Void
                        return producer(operation)
                    }
                }
                enum Member: Mockable.Matchable, Mockable.CaseIdentifiable {
                    case m1_execute(operation: Parameter<() throws -> Void>)
                    func match(_ other: Member) -> Bool {
                        switch (self, other) {
                        case (.m1_execute(operation: let leftOperation), .m1_execute(operation: let rightOperation)):
                            return leftOperation.match(rightOperation)
                        }
                    }
                }
                struct ReturnBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func execute(operation: Parameter<() throws -> Void>) -> Mockable.FunctionReturnBuilder<MockTest, ReturnBuilder, Void, (@escaping () throws -> Void) -> Void> {
                        .init(mocker, kind: .m1_execute(operation: operation))
                    }
                }
                struct ActionBuilder: Mockable.EffectBuilder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                    func execute(operation: Parameter<() throws -> Void>) -> Mockable.FunctionActionBuilder<MockTest, ActionBuilder> {
                        .init(mocker, kind: .m1_execute(operation: operation))
                    }
                }
                struct VerifyBuilder: Mockable.AssertionBuilder {
                    private let mocker: Mocker
                    private let assertion: Mockable.MockableAssertion
                    init(mocker: Mocker, assertion: @escaping Mockable.MockableAssertion) {
                        self.mocker = mocker
                        self.assertion = assertion
                    }
                    func execute(operation: Parameter<() throws -> Void>) -> Mockable.FunctionVerifyBuilder<MockTest, VerifyBuilder> {
                        .init(mocker, kind: .m1_execute(operation: operation), assertion: assertion)
                    }
                }
            }
            #endif
            """
        }
    }
}
