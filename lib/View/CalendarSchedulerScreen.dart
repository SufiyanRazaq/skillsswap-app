import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSchedulerScreen extends StatefulWidget {
  @override
  _CalendarSchedulerScreenState createState() =>
      _CalendarSchedulerScreenState();
}

class _CalendarSchedulerScreenState extends State<CalendarSchedulerScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events = {
      DateTime.utc(2024, 12, 30): ['Guitar Lesson at 3:00 PM'],
      DateTime.utc(2025, 1, 2): ['Web Development at 11:00 AM'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEvent() {
    if (_eventController.text.isNotEmpty) {
      setState(() {
        if (_events[_selectedDay!] != null) {
          _events[_selectedDay!]!.add(_eventController.text);
        } else {
          _events[_selectedDay!] = [_eventController.text];
        }
      });
      _eventController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Scheduler",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF043927), Color(0xFF00796B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildEventList(),
            const Spacer(),
            _buildAddSwapButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              headerStyle: HeaderStyle(
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
                formatButtonTextStyle: GoogleFonts.poppins(color: Colors.black),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.white70),
                rightChevronIcon:
                    const Icon(Icons.chevron_right, color: Colors.white70),
                formatButtonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                outsideTextStyle: const TextStyle(color: Colors.white70),
                weekendTextStyle: const TextStyle(color: Colors.white70),
                defaultTextStyle: GoogleFonts.poppins(color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                weekendStyle: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay!);
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            tileColor: Colors.white.withOpacity(0.1),
            leading: const Icon(Icons.event, color: Colors.white),
            title: Text(
              events[index],
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white70),
              onPressed: () {
                _eventController.text = events[index];
                _showAddEventDialog(editMode: true);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddSwapButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: Text(
        "Add New Swap",
        style: GoogleFonts.poppins(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      ),
      onPressed: _showAddEventDialog,
    );
  }

  void _showAddEventDialog({bool editMode = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            editMode ? "Edit Event" : "Add Swap",
            style: GoogleFonts.poppins(),
          ),
          content: TextField(
            controller: _eventController,
            decoration: InputDecoration(
              hintText: 'Enter Swap or Event',
              hintStyle: GoogleFonts.poppins(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.pop(context);
                _eventController.clear();
              },
            ),
            ElevatedButton(
              child: Text('Save', style: GoogleFonts.poppins()),
              onPressed: _addEvent,
            ),
          ],
        );
      },
    );
  }
}
