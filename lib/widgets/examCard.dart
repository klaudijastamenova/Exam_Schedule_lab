import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    final borderColor = exam.isPassed ? Colors.green.shade400 : Colors.blue.shade400;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: exam);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2.5),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  exam.subjectName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: exam.isPassed ? Colors.green.shade700 : Colors.blue.shade700,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              const Divider(),

              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 6),
                  Text('Датум: ${dateFormat.format(exam.dateTime)}'),
                ],
              ),
              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.access_time, size: 18),
                  const SizedBox(width: 6),
                  Text('Време: ${timeFormat.format(exam.dateTime)}'),
                ],
              ),
              const SizedBox(height: 4),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Простории: ${exam.classrooms.join(', ')}',
                      softWrap: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(),

              Center(
                child: Text(
                  exam.isPassed ? '✅ Испитот е поминат' : '🕒 Претстојува испит',
                  style: TextStyle(
                    color: exam.isPassed ? Colors.green : Colors.blue,
                    fontWeight: FontWeight.bold,
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
