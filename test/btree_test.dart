// Copyright (c) 2015, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library btree.test;

import 'package:btree/btree.dart';
import 'package:test/test.dart';

dynamic identity(dynamic a) => a;

/// Returns an ordered list of int items in the range [0, n).
List<int> rang(int n) => new List<int>.generate(n, identity);

/// Returns a random permutation of [n] int items in the range [0, n).
List<int> perm(int n) => rang(n)..shuffle();

/// Extracts all items from a tree in order as a list.
List<int> all(BTree<int> t) {
  final out = [];
  t.ascend((item) {
    out.add(item);
    return true;
  });
  return out;
}

void main() {
  group('BTree tests', () {
    const int btreeDegree = 32;

    test('TestBTree', () {
      final btree = new BTree<int>(btreeDegree);
      const int treeSize = 1000;
      for (int i = 0; i < 10; i++) {
        for (final item in perm(treeSize)) {
          expect(btree.replaceOrInsert(item), isNull);
        }
        for (final item in perm(treeSize)) {
          expect(btree.replaceOrInsert(item), isNotNull);
        }
        expect(all(btree), equals(rang(treeSize)));
        for (final item in perm(treeSize)) {
          expect(btree.remove(item), isNotNull);
        }
        expect(all(btree), isEmpty);
      }
    });

    test('TestRemoveMin', () {
      final btree = new BTree<int>(3);
      for (final v in perm(100)) {
        btree.replaceOrInsert(v);
      }
      final got = [];
      var v;
      while ((v = btree.removeMin()) != null) {
        got.add(v);
      }
      expect(got, equals(rang(100)));
    });

    test('TestRemoveMax', () {
      final btree = new BTree<int>(3);
      for (final v in perm(100)) {
        btree.replaceOrInsert(v);
      }
      final got = [];
      var v;
      while ((v = btree.removeMax()) != null) {
        got.add(v);
      }
      expect(got, equals(rang(100).reversed));
    });

    test('TestAscendRange', () {
      final btree = new BTree<int>(2);
      for (final v in perm(100)) {
        btree.replaceOrInsert(v);
      }
      final got = [];
      btree.ascendRange(40, 60, (a) {
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(40, 60)));
      got.clear();
      btree.ascendRange(40, 60, (a) {
        if (a > 50) {
          return false;
        }
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(40, 51)));
    });

    test('TestAscendLessThan', () {
      final btree = new BTree(btreeDegree);
      for (final v in perm(100)) {
        btree.replaceOrInsert(v);
      }
      final got = [];
      btree.ascendLessThan(60, (a) {
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(0, 60)));
      got.clear();
      btree.ascendLessThan(60, (a) {
        if (a > 50) {
          return false;
        }
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(0, 51)));
    });

    test('AscendGreaterOrEqual', () {
      final btree = new BTree(btreeDegree);
      for (final v in perm(100)) {
        btree.replaceOrInsert(v);
      }
      final got = [];
      btree.ascendGreaterOrEqual(40, (a) {
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(40)));
      got.clear();
      btree.ascendGreaterOrEqual(40, (a) {
        if (a > 50) {
          return false;
        }
        got.add(a);
        return true;
      });
      expect(got, equals(rang(100).sublist(40, 51)));
    });
  });
}
