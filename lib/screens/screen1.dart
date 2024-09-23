import 'package:flutter/material.dart';
import 'reservationScreen.dart';

// Klasa reprezentująca informacje o filmie
class Film {
  final String title;
  final String genre;
  final String director;
  final List<String> showtimes; // Godziny seansów
  String? selectedShowtime; // Dodane pole do przechowywania wybranej godziny

  Film({
    required this.title,
    required this.genre,
    required this.director,
    required this.showtimes,
    this.selectedShowtime,
  });
}

// Ekran 1 z listą dni i seansów
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final List<String> daysOfWeek = [
    'Poniedziałek',
    'Wtorek',
    'Środa',
    'Czwartek',
    'Piątek',
    'Sobota',
    'Niedziela',
  ];

  String? selectedDay;

  // Lista filmów z dodatkowymi informacjami
  final List<Film> films = [
    Film(
      title: 'Barbie',
      genre: 'Komedia',
      director: 'Greta Gerwig',
      showtimes: ['10:00', '12:30', '15:00', '17:30', '20:00'],
    ),
    Film(
      title: 'Oppenheimer',
      genre: 'Dramat',
      director: 'Christopher Nolan',
      showtimes: ['10:15', '13:00', '15:45', '18:30', '21:00'],
    ),
    Film(
      title: 'Mission: Impossible – Dead Reckoning Part One',
      genre: 'Akcja',
      director: 'Christopher McQuarrie',
      showtimes: ['10:30', '13:15', '16:00', '18:45', '21:30'],
    ),
    Film(
      title: 'The Marvels',
      genre: 'Sci-Fi',
      director: 'Nia DaCosta',
      showtimes: ['11:00', '13:30', '16:00', '18:30', '21:00'],
    ),
    Film(
      title: 'Dune: Part Two',
      genre: 'Sci-Fi',
      director: 'Denis Villeneuve',
      showtimes: ['10:00', '12:45', '15:30', '18:15', '21:00'],
    ),
    Film(
      title: 'Killers of the Flower Moon',
      genre: 'Dramat',
      director: 'Martin Scorsese',
      showtimes: ['11:15', '14:00', '16:45', '19:30', '21:30'],
    ),
    Film(
      title: 'Wonka',
      genre: 'Fantazja',
      director: 'Paul King',
      showtimes: ['10:30', '13:00', '15:30', '18:00', '20:30'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repertuar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Wybierz dzień',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedDay,
              hint: const Text('Wybierz dzień tygodnia'),
              isExpanded: true,
              dropdownColor: Colors.red,
              items: daysOfWeek.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedDay != null) ...[
              Text(
                'Repertuar na $selectedDay:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return Card(
                      color: const Color(0xFFFFE0B2),
                      child: ListTile(
                        title: Text(film.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rodzaj: ${film.genre}'),
                            Text('Reżyseria: ${film.director}'),
                            const SizedBox(height: 8),
                            const Text('Wybierz godzinę:'),
                            DropdownButton<String>(
                              value: film
                                  .selectedShowtime, // Przechowuje wybraną godzinę dla filmu
                              hint: const Text('Wybierz godzinę seansu'),
                              isExpanded: true,
                              items: film.showtimes.map((String time) {
                                return DropdownMenuItem<String>(
                                  value: time,
                                  child: Text(time),
                                );
                              }).toList(),
                              onChanged: (String? newTime) {
                                setState(() {
                                  film.selectedShowtime = newTime;
                                });
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          if (film.selectedShowtime != null) {
                            // Przejdź do ekranu rezerwacji z wybraną godziną
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationScreen(
                                  filmTitle: film.title,
                                  filmGenre: film.genre,
                                  filmDirector: film.director,
                                  selectedShowtime: film.selectedShowtime!,
                                  selectedDay: selectedDay!,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Wybierz godzinę seansu przed przejściem do rezerwacji.'),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50,
    );
  }
}
