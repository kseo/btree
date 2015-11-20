# btree

This package provides an in-memory B-Tree implementation, useful as a
an ordered, mutable data structure.

It has a flatter structure than an equivalent red-black or other binary tree,
which in some cases yields better memory usage and/or performance.

The API is based on [BTree implementation for Go][btree-go]

[btree-go]: https://godoc.org/github.com/google/btree

## Usage

A simple usage example:

```dart
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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/kseo/btree/issues
