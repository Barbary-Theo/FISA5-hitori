import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hitori',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HitoriPage(title: 'Hitori FISA5'),
    );
  }
}

class HitoriPage extends StatefulWidget {
  const HitoriPage({super.key, required this.title});

  final String title;

  @override
  State<HitoriPage> createState() => _HitoriPageState();
}

class _HitoriPageState extends State<HitoriPage> {
  List<List<int>> grid = [];
  final List<List<Color>> gridColor = [];

  void initializeGrid() {
    var random = Random();
    final List<List<int>> grid1 = [
      [4, 4, 5, 5, 3],
      [3, 1, 5, 4, 4],
      [4, 2, 1, 3, 2],
      [2, 3, 5, 1, 1],
      [2, 2, 3, 4, 1]
    ];
    final List<List<int>> grid2 = [
      [2, 3, 2, 1, 3],
      [2, 1, 1, 3, 4],
      [1, 4, 3, 4, 2],
      [3, 3, 5, 4, 4],
      [5, 1, 2, 2, 3]
    ];

    final List<List<int>> grid3 = [
      [3, 1, 5, 5, 4],
      [5, 5, 4, 4, 2],
      [2, 3, 4, 5, 3],
      [4, 5, 1, 3, 5],
      [4, 4, 2, 5, 3]
    ];

    final List<List<int>> grid4 = [
      [1, 1, 2, 5, 5],
      [5, 4, 4, 2, 1],
      [1, 5, 1, 5, 3],
      [3, 5, 4, 1, 5],
      [4, 1, 5, 1, 2]
    ];

    int rdm = random.nextInt(4);
    switch (rdm) {
      case 1:
        {
          grid = grid1;
        }
        break;

      case 2:
        {
          grid = grid2;
        }
        break;

      case 3:
        {
          grid = grid3;
        }
        break;

      case 4:
        {
          grid = grid4;
        }
        break;
    }
    /*int tmp = 1;
    for (int i = 0; i < 5; i++) {
      tmp = i + 1;
      List<int> row = [];
      for (int j = 0; j < 5; j++) {
        row.add(tmp);
        tmp++;
        if (tmp > 5) {
          tmp = 1;
        }
      }

      grid.add(row);
    }*/

    for (int i = 0; i < 5; i++) {
      List<Color> rowColor = [];
      for (int j = 0; j < 5; j++) {
        rowColor.add(Colors.white);
      }
      gridColor.add(rowColor);
    }
  }

  @override
  void initState() {
    initializeGrid();
  }

  bool isExistBlackAround(int i, int j) {
    try {
      if (i == 0 && j == 0) {
        return gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      } else if (i == 0 && j == grid.length - 1) {
        return gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black;
      } else if (i == grid.length - 1 && j == 0) {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      } else if (i == grid.length - 1 && j == grid.length - 1) {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black;
      } else if (i == 0) {
        return gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      } else if (i == grid.length - 1) {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      } else if (j == 0) {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      } else if (j == grid.length - 1) {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black;
      } else {
        return gridColor[i - 1][j] == Colors.black ||
            gridColor[i + 1][j] == Colors.black ||
            gridColor[i][j - 1] == Colors.black ||
            gridColor[i][j + 1] == Colors.black;
      }
    } on Exception catch (_) {
      return false;
    }
    return false;
  }

  void checkGrid() {
    bool isPossible = true;

    for (int i = 0; i < gridColor.length; i++) {
      for (int j = 0; j < gridColor[0].length; j++) {
        if (gridColor[i][j] == Colors.black) {
          if (isExistBlackAround(i, j)) isPossible = false;
        }
      }
    }

    print(isPossible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: GridView.builder(
                    // Your existing GridView.builder configuration
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: grid.length,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                    ),
                    itemCount:
                        grid.length != 0 ? grid.length * grid[0].length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              gridColor[index ~/ gridColor[0].length]
                                      [index % gridColor[0].length] =
                                  gridColor[index ~/ gridColor[0].length]
                                              [index % gridColor[0].length] ==
                                          Colors.black
                                      ? Colors.white
                                      : Colors.black;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              color: gridColor[index ~/ gridColor[0].length]
                                  [index % gridColor[0].length],
                            ),
                            child: Center(
                              child: Text(
                                (grid[index ~/ grid[0].length]
                                        [index % grid[0].length])
                                    .toString(),
                                style: TextStyle(
                                    color: gridColor[index ~/
                                                    gridColor[0].length]
                                                [index % gridColor[0].length] ==
                                            Colors.white
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF150C09), // Shadow color
                              offset:
                                  Offset(5, 5), // Offset (horizontal, vertical)
                              blurRadius: 0, // Blur radius (0 means no blur)
                            ),
                          ],
                        ),
                        child: TextButton(
                            onPressed: () {
                              checkGrid();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  240, 123, 0, 1), // Background color
                              onPrimary: Colors.white, // Text color
                              padding: EdgeInsets.all(16), // Button padding
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              'Check',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )),
                      )),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF150C09), // Shadow color
                              offset:
                                  Offset(5, 5), // Offset (horizontal, vertical)
                              blurRadius: 0, // Blur radius (0 means no blur)
                            ),
                          ],
                        ),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                for (int i = 0; i < grid.length; i++) {
                                  for (int j = 0; j < grid[0].length; j++) {
                                    gridColor[i][j] = Colors.white;
                                  }
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  240, 123, 0, 1), // Background color
                              onPrimary: Colors.white, // Text color
                              padding: EdgeInsets.all(16), // Button padding
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
