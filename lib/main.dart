import 'package:flutter/material.dart';
import 'dart:io';

import 'screens/screen1.dart';
import 'screens/screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikacja Kina',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String imagePath = '';

    if (Platform.isWindows) {
      imagePath = 'lib/images/bgwindows.jpeg'; // Obraz dla Windowsa
    } else if (Platform.isAndroid) {
      imagePath = 'lib/images/bgandroid.jpeg'; // Obraz dla Androida
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aplikacja Kina',
          style: TextStyle(
            color: Color.fromARGB(255, 3, 3, 0), // Kolor tekstu
            fontSize: 25, // Rozmiar czcionki
            fontWeight: FontWeight.bold, // Pogrubienie czcionki (opcjonalne)
          ),
        ),
        centerTitle: true, // Wyśrodkowanie tytułu
        backgroundColor: Colors.red, // Kolor tła AppBar),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Opcja 1':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen1()),
                  );
                  break;
                case 'Opcja 2':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen2()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Opcja 1',
                child: Text('Repertuar'),
              ),
              const PopupMenuItem<String>(
                value: 'Opcja 2',
                child: Text('Oferty'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.orange.shade50, // Jasnopomarańczowe tło
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Expanded, aby obraz wypełniał całą dostępną przestrzeń poniżej AppBara
            Expanded(
              child: Container(
                width: double.infinity, // Zapewnia pełną szerokość
                height: double.infinity, // Zapewnia pełną wysokość
                child: FittedBox(
                  fit: BoxFit.cover, // Dopasuj obraz do dostępnej przestrzeni
                  child: Image.asset(imagePath),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
