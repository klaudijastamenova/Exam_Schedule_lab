import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final Exam exam;

  const DetailsScreen({super.key, required this.exam});

  String timeRemaining() {
    final nowUtc = DateTime.now().toUtc();
    final examUtc = exam.dateTime.isUtc ? exam.dateTime : exam.dateTime.toUtc();

    final difference = examUtc.difference(nowUtc);

    final isPast = difference.isNegative;

    final absDiff = difference.abs();
    final days = absDiff.inDays;
    final hours = absDiff.inHours - days * 24;
    final minutes = absDiff.inMinutes - absDiff.inHours * 60;

    final timeText = (days > 0)
        ? '$days дена, $hours часа'
        : (hours > 0)
        ? '$hours часа, $minutes минути'
        : '$minutes минути';

    return isPast ? 'Испитот помина пред $timeText' : 'Преостанува: $timeText';
  }

  @override
  Widget build(BuildContext context) {
    final localDateTime =
    exam.dateTime.isUtc ? exam.dateTime.toLocal() : exam.dateTime;

    final dateFormat = DateFormat('dd.MM.yyyy', 'mk_MK');
    final timeFormat = DateFormat('HH:mm', 'mk_MK');

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: Text(exam.subjectName.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                exam.subjectName,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8),
                          Text(
                            'Датум: ${dateFormat.format(localDateTime)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            'Време: ${timeFormat.format(localDateTime)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Простории: ${exam.classrooms.join(', ')}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          timeRemaining(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}