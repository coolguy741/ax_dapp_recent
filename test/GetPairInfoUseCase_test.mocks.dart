// Mocks generated by Mockito 5.1.0 from annotations
// in ax_dapp/test/GetPairInfoUseCase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:ax_dapp/repositories/subgraph/SubGraphRepo.dart' as _i3;
import 'package:fpdart/fpdart.dart' as _i2;
import 'package:graphql_flutter/graphql_flutter.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [SubGraphRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubGraphRepo extends _i1.Mock implements _i3.SubGraphRepo {
  MockSubGraphRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>
      queryPairDataForTokenAddress(String? token0, String? token1) => (super
          .noSuchMethod(
              Invocation.method(
                  #queryPairDataForTokenAddress, [token0, token1]),
              returnValue:
                  Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>.value(
                      _FakeEither_0<Map<String, dynamic>?, _i5.OperationException>())) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>);
  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>
      queryAllPairs() => (super.noSuchMethod(
          Invocation.method(#queryAllPairs, []),
          returnValue:
              Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>.value(
                  _FakeEither_0<Map<String, dynamic>?,
                      _i5.OperationException>())) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i5.OperationException>>);
}
