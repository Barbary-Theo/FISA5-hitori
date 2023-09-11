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
  final List<List<bool>> gridCheck = [];
  bool isGameTerminated = false;

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

    for (int i = 0; i < 5; i++) {
      List<bool> rowBool = [];
      for (int j = 0; j < 5; j++) {
        rowBool.add(false);
      }
      gridCheck.add(rowBool);
    }
  }

  void resetGridCheck() {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        gridCheck[i][j] = false;
      }
    }
  }

  @override
  void initState() {
    initializeGrid();
  }

  bool isAllWhiteCaseHasBeenVisited() {
    for (int m = 0; m < gridColor.length; m++) {
      for (int n = 0; n < gridColor[m].length; n++) {
        if (gridColor[m][n] == Colors.white && gridCheck[m][n] == false)
          return false;
      }
    }
    return true;
  }

  void findPath(int i, int j) {
    gridCheck[i][j] = true;
    try {
      if (gridColor[i - 1][j] == Colors.white && gridCheck[i - 1][j] == false)
        findPath(i - 1, j);
    } catch (e) {}
    try {
      if (gridColor[i + 1][j] == Colors.white && gridCheck[i + 1][j] == false)
        findPath(i + 1, j);
    } catch (e) {}
    try {
      if (gridColor[i][j - 1] == Colors.white && gridCheck[i][j - 1] == false)
        findPath(i, j - 1);
    } catch (e) {}
    try {
      if (gridColor[i][j + 1] == Colors.white && gridCheck[i][j + 1] == false)
        findPath(i, j + 1);
    } catch (e) {}
  }

  bool isPossibleToAccessToAllWhiteCase(int i, int j) {
    findPath(i, j);
    bool result = isAllWhiteCaseHasBeenVisited();
    resetGridCheck();
    return result;
  }

  bool existSameWhiteNumberOnRowOrColumn(int i, int j) {
    int numberToCheck = grid[i][j];

    //check row
    for (int m = 0; m < gridColor.length; m++) {
      if (m == i) {
        for (int n = 0; n < gridColor[m].length; n++) {
          if (n != j &&
              gridColor[m][n] == Colors.white &&
              grid[m][n] == numberToCheck) return true;
        }
      }
    }

    //check column
    for (int m = 0; m < gridColor.length; m++) {
      for (int n = 0; n < gridColor[m].length; n++) {
        if (n == j) {
          if (m != i &&
              gridColor[m][n] == Colors.white &&
              grid[m][n] == numberToCheck) {
            return true;
          }
        }
      }
    }

    return false;
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
    } catch (e) {
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
        } else if (gridColor[i][j] == Colors.white) {
          if (existSameWhiteNumberOnRowOrColumn(i, j)) isPossible = false;
          if (!isPossibleToAccessToAllWhiteCase(i, j)) isPossible = false;
        }
      }
    }
    setState(() {
      isGameTerminated = isPossible;
      if (isGameTerminated) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Victory ! 🚀',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text('You can start a new game, have fun !'),
                  SizedBox(height: 16),
                  Padding(
                      padding: EdgeInsets.all(3.0),
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
                              isGameTerminated = false;
                              Navigator.of(context).pop();
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
                                  229, 179, 55, 1), // Background color
                              onPrimary: Colors.white, // Text color
                              padding: EdgeInsets.all(16), // Button padding
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              'Again !',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )),
                      )),
                ],
              ),
            ); // Use your custom modal content widget here
          },
        );
      }
    });
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
                                  121, 208, 106, 1), // Background color
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
                                  255, 81, 81, 1), // Background color
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
