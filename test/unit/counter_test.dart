// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/counter.dart';

void main() {
  group('Group testing', () {
    test('Counter value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });
    test('counter should be decreased ', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });

    //-----
  });
}
