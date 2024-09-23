import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final List<int> selectedSeats;
  final String filmTitle;
  final String selectedShowtime; // Parametr wymagany dla godziny seansu
  final String selectedDay;

  const BookingConfirmationScreen({
    super.key,
    required this.selectedSeats,
    required this.filmTitle,
    required this.selectedShowtime, // Przyjmujemy godzinę seansu
    required this.selectedDay,
  });

  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  String? _selectedOffer;
  final TextEditingController _surnameController = TextEditingController();

  void _submitBooking() {
    final surname = _surnameController.text;
    if (surname.isNotEmpty && _selectedOffer != null) {
      // Simulacja wysyłania e-maila
      print('Wysłanie informacji o rezerwacji na nazwisko: $surname');
      print('Miejsca: ${widget.selectedSeats}');
      print('Oferta: $_selectedOffer');
      print(
          'Dzień oraz godzina seansu: ${widget.selectedDay} ${widget.selectedShowtime}'); // Dodano godzinę seansu

      // Można dodać kod do faktycznego wysyłania e-maila tutaj

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Rezerwacja na nazwisko "$surname" została zaksięgowana')),
      );

      // Przejdź do strony głównej (Screen1) i usuń wszystkie poprzednie ekrany
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/', // Nazwa trasy głównej (Screen1)
        ModalRoute.withName(
            '/'), // Usuwa wszystkie trasy poza trasą '/'. Możesz dostosować, jeśli Twoja trasa główna ma inną nazwę.
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proszę wypełnić wszystkie pola')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Potwierdzenie rezerwacji'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Film: ${widget.filmTitle}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Miejsca: ${widget.selectedSeats.join(', ')}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Wyświetlenie wybranej godziny seansu
            Text(
              'Dzień oraz godzina seansu: ${widget.selectedDay}, ${widget.selectedShowtime}', // Wyświetlamy godzinę
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Wybierz ofertę:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedOffer,
              hint: const Text('Wybierz ofertę'),
              isExpanded: true,
              items: ['Standard', 'Student', 'Rodzinny'].map((String offer) {
                return DropdownMenuItem<String>(
                  value: offer,
                  child: Text(offer),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOffer = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Podaj nazwisko:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _surnameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Wpisz swoje nazwisko',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Zaakceptuj'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50,
    );
  }
}
