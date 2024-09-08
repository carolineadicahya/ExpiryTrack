// import 'package:expiry_track/screen/add_product.dart';
// import 'package:expiry_track/screen/profil.dart';
// import 'package:expiry_track/utils/palette.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // CalendarFormat _calendarFormat = CalendarFormat.week;
//   // DateTime _focusedDay = DateTime.now();
//   // DateTime? _selectedDay;
//   // Map<DateTime, List<String>> _events =
//   //     {}; // Menyimpan event (produk) pada tanggal tertentu

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ExpiryTrack'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.account_circle),
//             onPressed: () {
//               Navigator.of(context).pushNamed(Profil.routeName);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: CalendarCarousel(
//                 onDayPressed: (date, events) {
//                   // Implement logic for when a date is pressed
//                 },
//                 weekendTextStyle: TextStyle(
//                   color: Colors.red,
//                 ),
//                 thisMonthDayBorderColor: Colors.grey,
//                 markedDateWidget: Container(
//                   color: Colors.red,
//                   height: 4,
//                   width: 4,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Produk Mendekati Kadaluarsa:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 3, // Hardcoded for example
//                 itemBuilder: (ctx, i) => Card(
//                   child: ListTile(
//                     title: Text('Produk ${i + 1}'),
//                     subtitle: Text('Kadaluarsa: 2024-09-10'),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => AddProduct(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();

    // Contoh event pada tanggal tertentu
    _events = {
      DateTime.utc(2024, 9, 10): ['Produk A Kadaluarsa'],
      DateTime.utc(2024, 9, 12): ['Produk B Kadaluarsa'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpiryTrack'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed('/profil');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        _getEventsForDay(_selectedDay ?? _focusedDay)[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Produk Mendekati Kadaluarsa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Placeholder for the number of products
                itemBuilder: (ctx, i) => Card(
                  child: ListTile(
                    title: Text('Produk ${i + 1}'),
                    subtitle: Text('Kadaluarsa: 2024-09-10'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_product');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
