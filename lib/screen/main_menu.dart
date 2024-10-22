import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
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
    _events = {
      DateTime.utc(2024, 10, 21): ['Produk 1 Kadaluarsa'],
      DateTime.utc(2024, 10, 29): ['Produk 2 Kadaluarsa'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  Widget greetingMessage() {
    var hour = DateTime.now().hour;
    String greeting;
    IconData icon;
    Color iconColor;
    Color textColor;
    double iconSize = 35;

    if (hour >= 0 && hour < 12) {
      greeting = 'Hi! Selamat Pagi';
      textColor = Palette.accentColor;
      icon = CupertinoIcons.cloud_sun_fill;
      iconColor = Color(0xFFFFEB8317);
    } else if (hour >= 12 && hour < 15) {
      greeting = 'Hi! Selamat Siang';
      textColor = Color(0xFFFFAF45);
      icon = CupertinoIcons.sun_max_fill;
      iconColor = Color(0xFFFFA732);
    } else if (hour >= 15 && hour < 18) {
      greeting = 'Hi! Selamat Sore';
      textColor = Color(0xFFE0144C);
      icon = CupertinoIcons.sun_haze_fill;
      iconColor = Color(0xFFB51B75);
    } else {
      greeting = 'Hi! Selamat Malam';
      textColor = Color(0xFF003285);
      icon = CupertinoIcons.moon_stars_fill;
      iconColor = Color(0xFF090580);
    }

    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          greeting,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Palette.scaffoldBackgroundColor,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: greetingMessage(),
        // toolbarHeight: 100,
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        height: double.infinity,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(3000, 12, 31),
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
                  // color: Palette.primaryColor.withOpacity(0.7),
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
                // defaultTextStyle: TextStyle(color: Palette.textPrimaryColor),
                defaultTextStyle: TextStyle(color: Palette.primaryColor),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Palette.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                leftChevronIcon: Container(
                  decoration: BoxDecoration(
                    // color: Palette.scaffoldBackgroundColor,
                    color: Palette.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: Palette.textPrimaryColor,
                  ),
                ),
                rightChevronIcon: Container(
                  decoration: BoxDecoration(
                    color: Palette.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Palette.textPrimaryColor,
                  ),
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  if (_getEventsForDay(_selectedDay ?? _focusedDay).isNotEmpty)
                    Card(
                      elevation: 0,
                      color: Palette.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Palette.errorColor,
                          // color: Palette.secondaryBackgroundColor,
                          width: 0.5,
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Peringatan:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  _getEventsForDay(_selectedDay ?? _focusedDay)
                                      .length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        _getEventsForDay(
                                            _selectedDay ?? _focusedDay)[index],
                                        style: TextStyle(
                                          color: Palette.textPrimaryColor,
                                        ),
                                      ),
                                      leading: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Palette.errorColor
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.warning_amber_rounded,
                                          color: Palette.errorColor,
                                        ),
                                      ),
                                    ),
                                    if (index <
                                        _getEventsForDay(
                                                    _selectedDay ?? _focusedDay)
                                                .length -
                                            1)
                                      Divider(),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 14),
                  Text(
                    'Produk Mendekati Kadaluarsa:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.textPrimaryColor,
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, i) => Card(
                      elevation: 0,
                      color: const Color.fromARGB(81, 183, 224, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Palette.secondaryColor,
                          width: 0.7,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          'Produk ${i + 1}',
                          style: TextStyle(
                            color: Palette.textPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Kadaluarsa: 2024-09-10',
                          style: TextStyle(color: Palette.textSecondaryColor),
                          // style: TextStyle(color: Color(0xFFD1E9F6)),
                        ),
                        leading: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Palette.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: Icon(
                            CupertinoIcons.alarm,
                            color: Palette.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_product');
        },
        backgroundColor: Palette.accentColor,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambahkan Produk',
        splashColor: Palette.primaryColor,
      ),
    );
  }
}
