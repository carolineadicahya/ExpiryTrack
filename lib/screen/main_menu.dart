import 'package:expiry_track/utils/palette.dart';
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
      DateTime.utc(2024, 9, 10): ['Produk 1 Kadaluarsa'],
      DateTime.utc(2024, 9, 12): ['Produk 2 Kadaluarsa'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ExpiryTrack',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Palette.textPrimaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.primaryColor,
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
                  color: Palette.primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Palette.accentColor,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Palette.errorColor,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Palette.errorColor),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  // Daftar peringatan
                  if (_getEventsForDay(_selectedDay ?? _focusedDay).isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peringatan:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              _getEventsForDay(_selectedDay ?? _focusedDay)
                                  .length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _getEventsForDay(
                                    _selectedDay ?? _focusedDay)[index],
                                style:
                                    TextStyle(color: Palette.textPrimaryColor),
                              ),
                              leading: Icon(Icons.warning,
                                  color: Palette.errorColor),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  Text(
                    'Produk Mendekati Kadaluarsa:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Palette.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3, // Placeholder untuk jumlah produk
                    itemBuilder: (ctx, i) => Card(
                      color: Palette.secondaryColor,
                      child: ListTile(
                        title: Text(
                          'Produk ${i + 1}',
                          style: TextStyle(color: Palette.textPrimaryColor),
                        ),
                        subtitle: Text(
                          'Kadaluarsa: 2024-09-10',
                          style: TextStyle(color: Palette.textSecondaryColor),
                        ),
                        leading: Icon(Icons.calendar_today,
                            color: Palette.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_product');
        },
        backgroundColor: Palette.accentColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
