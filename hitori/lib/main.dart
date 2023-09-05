import 'package:flutter/material.dart';
import 'dart:math';

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

  final List<List<int>> grid = [];
  final List<List<Color>> gridColor = [];


  void initializeGrid() {
    var random = Random();

    for(int i = 0; i < 5; i++) {
      List<int> row = [];
      for (int j = 0; j < 5; j++) {
        row.add(random.nextInt(5) + 1);
      }
      grid.add(row);
    }

    for(int i = 0; i < 5; i++) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Set the number of items in each row
        crossAxisCount: grid.length,
        // Adjust other grid attributes as needed
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
      itemCount: grid.length != 0 ? grid.length * grid[0].length : 0,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: GestureDetector(
              onTap: () {
                  setState(() {
                    gridColor[index ~/ gridColor[0].length][index % gridColor[0].length] = gridColor[index ~/ gridColor[0].length][index % gridColor[0].length] == Colors.black ? Colors.white : Colors.black;
                  });
                },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  color: gridColor[index ~/ gridColor[0].length][index % gridColor[0].length]
                ),
                child: Center(
                  child: Text(
                    (grid[index ~/ grid[0].length][index % grid[0].length]).toString(),
                  style: TextStyle(color: gridColor[index ~/ gridColor[0].length][index % gridColor[0].length] == Colors.white ? Colors.black : Colors.white),
                ),
              ),
              ),
            ),
        );
      }
        )
      )
    );
  }
}