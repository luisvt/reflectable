// Copyright (c) 2015, the Dart Team. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in
// the LICENSE file.

// File being transformed by the reflectable transformer.
// Uses `reflectedType` to access a `Type` value for the type annotation
// of various declarations.

library test_reflectable.test.reflected_type_test;

import 'package:reflectable/reflectable.dart';
import 'package:unittest/unittest.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(reflectedTypeCapability, invokingCapability,
            declarationsCapability);
}

const reflector = const Reflector();

@reflector
class A {
  int arg0() => null;
  int arg1(int x) => null;
  int arg2to4(A x, int y, [Reflector z, w = 41.99999999]) => null;
  int argNamed(int x, y, {num z}) => null;

  int operator +(int x) => null;
  int operator [](int x) => null;
  void operator []=(int x, v) {}

  String get getset => "42";
  void set getset(String string) {}

  static int noArguments() => null;
  static int oneArgument(String x) => null;
  static int optionalArguments(A x, double y, [Reflector z, dynamic w = 42]) =>
      null;
  static int namedArguments(String x, List y, {String z: "4" + "2"}) => null;

  static List get staticGetset => ["42"];
  static void set staticGetset(List list) {}
}

final throwsNoCapability = throwsA(const isInstanceOf<NoSuchCapabilityError>());

main() {
  ClassMirror aMirror = reflector.reflectType(A);
  Map<String, DeclarationMirror> declarations = aMirror.declarations;

  MethodMirror arg0Mirror = declarations["arg0"];
  MethodMirror arg1Mirror = declarations["arg1"];
  MethodMirror arg2to4Mirror = declarations["arg2to4"];
  MethodMirror argNamedMirror = declarations["argNamed"];
  MethodMirror opPlusMirror = declarations["+"];
  MethodMirror opBracketMirror = declarations["[]"];
  MethodMirror opBracketEqualsMirror = declarations["[]="];
  MethodMirror getsetMirror = declarations["getset"];
  MethodMirror getsetEqualsMirror = declarations["getset="];
  MethodMirror noArgumentsMirror = declarations["noArguments"];
  MethodMirror oneArgumentMirror = declarations["oneArgument"];
  MethodMirror optionalArgumentsMirror = declarations["optionalArguments"];
  MethodMirror namedArgumentsMirror = declarations["namedArguments"];
  MethodMirror staticGetsetMirror = declarations["staticGetset"];
  MethodMirror staticGetsetEqualsMirror = declarations["staticGetset="];

  test('parameter reflected types, instance methods', () {
    expect(arg0Mirror.parameters.length, 0);

    expect(arg1Mirror.parameters.length, 1);
    expect(arg1Mirror.parameters[0].reflectedType, int);

    expect(arg2to4Mirror.parameters.length, 4);
    expect(arg2to4Mirror.parameters[0].reflectedType, A);
    expect(arg2to4Mirror.parameters[1].reflectedType, int);
    expect(arg2to4Mirror.parameters[2].reflectedType, Reflector);
    expect(arg2to4Mirror.parameters[3].reflectedType, dynamic);

    expect(argNamedMirror.parameters.length, 3);
    expect(argNamedMirror.parameters[0].reflectedType, int);
    expect(argNamedMirror.parameters[1].reflectedType, dynamic);
    expect(argNamedMirror.parameters[2].reflectedType, num);
  });

  test('parameter reflected types, operators', () {
    expect(opPlusMirror.parameters.length, 1);
    expect(opPlusMirror.parameters[0].reflectedType, int);

    expect(opBracketMirror.parameters.length, 1);
    expect(opBracketMirror.parameters[0].reflectedType, int);

    expect(opBracketEqualsMirror.parameters.length, 2);
    ParameterMirror opBracketEqualsParameter0 =
        opBracketEqualsMirror.parameters[0];
    ParameterMirror opBracketEqualsParameter1 =
        opBracketEqualsMirror.parameters[1];
    expect(opBracketEqualsParameter0.reflectedType, int);
    expect(opBracketEqualsParameter1.reflectedType, dynamic);
  });

  test('parameter reflected types, getters and setters', () {
    expect(getsetMirror.parameters.length, 0);
    expect(getsetEqualsMirror.parameters.length, 1);
    ParameterMirror getsetEqualsParameter0 = getsetEqualsMirror.parameters[0];
    expect(getsetEqualsParameter0.reflectedType, String);
  });

  test('parameter reflected types, static methods', () {
    expect(noArgumentsMirror.parameters.length, 0);

    expect(oneArgumentMirror.parameters.length, 1);
    expect(oneArgumentMirror.parameters[0].reflectedType, String);

    expect(optionalArgumentsMirror.parameters.length, 4);
    ParameterMirror optionalArgumentsParameter0 =
        optionalArgumentsMirror.parameters[0];
    ParameterMirror optionalArgumentsParameter1 =
        optionalArgumentsMirror.parameters[1];
    ParameterMirror optionalArgumentsParameter2 =
        optionalArgumentsMirror.parameters[2];
    ParameterMirror optionalArgumentsParameter3 =
        optionalArgumentsMirror.parameters[3];
    expect(optionalArgumentsParameter0.reflectedType, A);
    expect(optionalArgumentsParameter1.reflectedType, double);
    expect(optionalArgumentsParameter2.reflectedType, Reflector);
    expect(optionalArgumentsParameter3.reflectedType, dynamic);

    expect(namedArgumentsMirror.parameters.length, 3);
    ParameterMirror namedArgumentsParameter0 =
        namedArgumentsMirror.parameters[0];
    ParameterMirror namedArgumentsParameter1 =
        namedArgumentsMirror.parameters[1];
    ParameterMirror namedArgumentsParameter2 =
        namedArgumentsMirror.parameters[2];
    expect(namedArgumentsParameter0.reflectedType, String);
    expect(namedArgumentsParameter1.reflectedType, List);
    expect(namedArgumentsParameter2.reflectedType, String);
  });

  test('parameter reflected types, static getters and setters', () {
    expect(staticGetsetMirror.parameters.length, 0);
    expect(staticGetsetEqualsMirror.parameters.length, 1);
    ParameterMirror staticGetsetEqualsParameter0 =
        staticGetsetEqualsMirror.parameters[0];
    expect(staticGetsetEqualsParameter0.reflectedType, List);
  });

  test('reflected return types, methods', () {
    expect(arg0Mirror.reflectedReturnType, int);
    expect(arg1Mirror.reflectedReturnType, int);
    expect(arg2to4Mirror.reflectedReturnType, int);
    expect(argNamedMirror.reflectedReturnType, int);
    expect(opPlusMirror.reflectedReturnType, int);
    expect(opBracketMirror.reflectedReturnType, int);
    expect(opBracketEqualsMirror.hasReflectedReturnType, false);
    expect(getsetMirror.reflectedReturnType, String);
    expect(getsetEqualsMirror.hasReflectedReturnType, false);
    expect(noArgumentsMirror.reflectedReturnType, int);
    expect(oneArgumentMirror.reflectedReturnType, int);
    expect(optionalArgumentsMirror.reflectedReturnType, int);
    expect(namedArgumentsMirror.reflectedReturnType, int);
    expect(staticGetsetMirror.reflectedReturnType, List);
    expect(staticGetsetEqualsMirror.hasReflectedReturnType, false);
  });
}
