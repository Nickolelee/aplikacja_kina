import 'package:flutter/material.dart';
import 'bookingConfirmationScreen.dart'; // Import ekranu potwierdzenia rezerwacji

class ReservationScreen extends StatefulWidget {
  final String filmTitle;
  final String filmGenre; // Parametr wymagany dla rodzaju filmu
  final String filmDirector;
  final String selectedShowtime; // Parametr wymagany dla godziny seansu
  final String selectedDay;

  const ReservationScreen({
    super.key,
    required this.filmTitle,
    required this.filmGenre,
    required this.filmDirector,
    required this.selectedShowtime,
    required this.selectedDay,
  });

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<bool> selectedSeats =
      List.generate(36, (index) => false); // Lista wybranych miejsc

  // Nawigacja do ekranu potwierdzenia rezerwacji
  void _navigateToBookingConfirmation() {
    final selectedSeatNumbers = selectedSeats
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key + 1)
        .toList();

    if (selectedSeatNumbers.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            selectedSeats: selectedSeatNumbers,
            filmTitle: widget.filmTitle,
            selectedShowtime: widget.selectedShowtime,
            selectedDay: widget.selectedDay,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wybierz przynajmniej jedno miejsce przed rezerwacją.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double minButtonSize = 40;
    final double maxButtonSize = 80;
    final double maxWidthThreshold = 1200;

    double buttonSize;
    if (screenSize.width > maxWidthThreshold) {
      buttonSize = minButtonSize;
    } else {
      buttonSize = (screenSize.width - 40) / 6;
      buttonSize = buttonSize.clamp(minButtonSize, maxButtonSize);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Rezerwacja na ${widget.filmTitle}'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Wyświetlanie dodatkowych informacji o filmie
            Text(
              'Tytuł: ${widget.filmTitle}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rodzaj: ${widget.filmGenre}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Reżyseria: ${widget.filmDirector}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Dzień: ${widget.selectedDay}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Godzina seansu: ${widget.selectedShowtime}', // Wyświetlanie godziny seansu
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Wybierz miejsca:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Siatka z miejscami do wyboru
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: 36,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeats[index] = !selectedSeats[index];
                      });
                    },
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color:
                            selectedSeats[index] ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _navigateToBookingConfirmation, // Przejście do potwierdzenia rezerwacji
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Zarezerwuj miejsca',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50,
    );
  }
}
