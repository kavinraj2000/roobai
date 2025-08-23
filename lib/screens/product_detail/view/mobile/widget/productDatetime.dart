import 'package:flutter/material.dart';

class ProductDatetime extends StatelessWidget {
  final DateTime? dateTime;

  const ProductDatetime({super.key, this.dateTime});

  @override
  Widget build(BuildContext context) {
    if (dateTime == null) return const SizedBox.shrink();

    // Format date/time however you want
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(
            "${dateTime!.day}/${dateTime!.month}/${dateTime!.year} ${dateTime!.hour}:${dateTime!.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(color: Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}