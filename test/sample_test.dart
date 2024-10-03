import 'package:flutter_test/flutter_test.dart';

void main() {
  test('2と3の加算結果が5であることを検証する', () {
    expect(2 + 3, 5);
  });

  test('"Hello"と"World"の結合結果が"HelloWorld"であることを検証する', () {
    const str1 = 'Hello';
    const str2 = 'World';
    expect('$str1$str2', 'HelloWorld');
  });
}
