import 'package:flutter/material.dart';

class ProductDatetime extends StatelessWidget {
  final String? dateTime; // date string from API

  const ProductDatetime({super.key, required this.dateTime});

  String _timeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} min ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hr ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        return "${(difference.inDays / 7).floor()} weeks ago";
      } else if (difference.inDays < 365) {
        return "${(difference.inDays / 30).floor()} months ago";
      } else {
        return "${(difference.inDays / 365).floor()} years ago";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dateTime == null || dateTime!.isEmpty) {
      return const SizedBox(); // return empty if no date
    }

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 10,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 2),
        Text(
          _timeAgo(dateTime!),
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
