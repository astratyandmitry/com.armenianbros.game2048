import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game2048_app/models/box.dart';
import 'package:game2048_app/widgets/score.dart';
import 'package:game2048_app/widgets/controls.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<List<Box>> _items = [
    [Box(), Box(), Box(), Box()],
    [Box(), Box(), Box(), Box()],
    [Box(), Box(), Box(), Box()],
    [Box(), Box(), Box(), Box()],
  ];

  int _step = 0;
  int get _scoreCurrent {
    addRandom(value: 2);

    return _items.fold<int>(0, (sum, row) {
      return sum + row.fold<int>(0, (rowSum, item) => rowSum + item.value);
    });
  }

  bool get _lose {
    return _items.length ==
        _items.where((row) {
          return row.where((item) => item.value != 0).length == _items.length;
        }).length;
  }

  @override
  void initState() {
    super.initState();
    addRandom(value: 2);
  }

  void addRandom({int value = 2, bool updated = false}) {
    if (_lose) {
      return;
    }

    var matrix = _items
        .map((row) {
          return row
              .asMap()
              .entries
              .where((entry) => entry.value.value == 0)
              .map((entry) => entry.key)
              .toList();
        })
        .where((element) => element.isNotEmpty)
        .toList();

    var row = (matrix.where((element) => element.isNotEmpty).toList()
          ..shuffle())
        .first;

    var rowIndex = matrix.indexOf(row);
    var columnIndex = (row..shuffle()).first;

    var index = 0;

    while (_items[rowIndex][columnIndex].value != 0) {
      matrix[rowIndex].removeAt(columnIndex);
      columnIndex = (row..shuffle()).first;

      index++;

      if (index > 10) {
        print('overload');
        return;
      }
    }

    setState(() {
      _items[rowIndex][columnIndex].value = value;
    });

    if (updated) {
      _step++;
    }
  }

  void handleUp() {
    var updated = false;

    for (var rowIndex = 1; rowIndex < _items.length; rowIndex++) {
      for (var itemIndex = 0; itemIndex < _items.length; itemIndex++) {
        if (_items[rowIndex][itemIndex].value == 0) {
          continue;
        }

        for (var nextIndex = rowIndex; nextIndex > 0; nextIndex--) {
          var box = _items[nextIndex][itemIndex];
          var nextBox = _items[nextIndex - 1][itemIndex];

          if (box.movable(nextBox, _step)) {
            setState(() => box.move(nextBox, _step));
            updated = true;
          }
        }
      }
    }

    if (updated) {
      addRandom(updated: true);
    }
  }

  void handleDown() {
    var updated = false;

    for (var rowIndex = _items.length - 2; rowIndex >= 0; rowIndex--) {
      for (var itemIndex = 0; itemIndex < _items.length; itemIndex++) {
        if (_items[rowIndex][itemIndex].value == 0) {
          continue;
        }

        for (var nextIndex = rowIndex;
            nextIndex < _items.length - 1;
            nextIndex++) {
          var box = _items[nextIndex][itemIndex];
          var nextBox = _items[nextIndex + 1][itemIndex];

          if (box.movable(nextBox, _step)) {
            setState(() => box.move(nextBox, _step));
            updated = true;
          }
        }
      }
    }

    if (updated) {
      addRandom(updated: true);
    }
  }

  void handleRight() {
    var updated = false;

    for (var rowIndex = 0; rowIndex < _items.length; rowIndex++) {
      var row = _items[rowIndex];

      for (var itemIndex = row.length - 2; itemIndex >= 0; itemIndex--) {
        if (row[itemIndex].value == 0) {
          continue;
        }

        for (var nextIndex = itemIndex;
            nextIndex < row.length - 1;
            nextIndex++) {
          var box = row[nextIndex];
          var nextBox = row[nextIndex + 1];

          if (box.movable(nextBox, _step)) {
            setState(() => box.move(nextBox, _step));
            updated = true;
          }
        }
      }
    }

    if (updated) {
      addRandom(updated: true);
    }
  }

  void handleLeft() {
    var updated = false;

    for (var rowIndex = 0; rowIndex < _items.length; rowIndex++) {
      var row = _items[rowIndex];

      for (var itemIndex = 1; itemIndex < row.length; itemIndex++) {
        if (row[itemIndex].value == 0) {
          continue;
        }

        for (var nextIndex = itemIndex; nextIndex > 0; nextIndex--) {
          var box = row[nextIndex];
          var nextBox = row[nextIndex - 1];

          if (box.movable(nextBox, _step)) {
            setState(() => box.move(nextBox, _step));
            updated = true;
          }
        }
      }
    }

    if (updated) {
      addRandom(updated: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        details.primaryVelocity! >= 0 ? handleRight() : handleLeft();
      },
      onVerticalDragEnd: (details) {
        return details.primaryVelocity! >= 0 ? handleDown() : handleUp();
      },
      child: Column(
        children: [
          Text(_lose ? 'lose' : 'falase'),
          Score(current: _scoreCurrent, step: _step),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.12),
            ),
            child: Column(
              children: _items.map((row) {
                return Row(
                  children: row.map((box) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.50),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FittedBox(
                            child: Text(
                              box.value > 0 ? box.value.toString() : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.64),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Controls(
            rightHandler: handleRight,
            leftHandler: handleLeft,
            downHandler: handleDown,
            upHandler: handleUp,
          ),
        ],
      ),
    );
  }
}
