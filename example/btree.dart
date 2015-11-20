// Copyright (c) 2015, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library btree.example;

import 'package:btree/btree.dart';

main() {
  final btree = new BTree<int>(3);
  for (var i = 0; i < 10; i++) {
    btree.replaceOrInsert(i);
  }
  print('len:       ${btree.length}');
  // len:       10
  print('get3:      ${btree[3]}');
  // get3:      3
  print('get100:    ${btree[100]}');
  // get100:    null
  print('del4:      ${btree.remove(4)}');
  // del4:      4
  print('del100:    ${btree.remove(100)}');
  // del100:    null
  print('replace5:  ${btree.replaceOrInsert(5)}');
  // replace5:  5
  print('replace100:${btree.replaceOrInsert(100)}');
  // replace100:null
  print('delmin:    ${btree.removeMin()}');
  // delmin:    0
  print('delmax:    ${btree.removeMax()}');
  // delmax:    100
  print('len:       ${btree.length}');
  // len:       8
}
