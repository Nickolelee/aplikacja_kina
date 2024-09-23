import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String selectedOffer = 'Standard';
  final Map<String, String> offerDetails = {
    'Standard': 'Oferta Standard: Bilet na każdy seans kosztuje 25zł.',
    'Student': 'Oferta Student: Bilet na każdy seans kosztuje 18zł.',
    'Rodzinny':
        'Oferta Rodzinny: Bilet dla posiadaczy karty dużej rodziny kosztuje 20zł.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oferty',
          style: TextStyle(
            color: Color.fromARGB(255, 3, 3, 0), // Kolor tekstu
            fontSize: 25, // Rozmiar czcionki
            fontWeight: FontWeight.bold, // Pogrubienie czcionki (opcjonalne)
          ),
        ),
        centerTitle: true, // Wyśrodkowanie tytułu
        backgroundColor: Colors.red, // Kolor tła AppBar),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red, // Kolor obramowania
                  width: 2.0, // Grubość obramowania
                ),
                borderRadius: BorderRadius.circular(8), // Zaokrąglone rogi
              ),
              child: DropdownButton<String>(
                value: selectedOffer,
                dropdownColor:
                    Colors.red, // Pomarańczowy kolor rozwijanego menu
                items: <String>['Standard', 'Student', 'Rodzinny']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOffer = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                offerDetails[selectedOffer] ?? '',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50, // Jasnopomarańczowe tło aplikacji
    );
  }
}
