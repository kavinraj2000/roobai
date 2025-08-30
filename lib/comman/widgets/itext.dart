import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartProductInfoDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<String>? storeNames; // Optional list of store names to highlight

  const SmartProductInfoDialog({
    super.key,
    required this.title,
    required this.description,
    this.storeNames,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.info, color: Colors.blue, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20, color: Colors.grey),
              Flexible(
                child: SingleChildScrollView(
                  child: _buildRichDescription(description),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  RichText _buildRichDescription(String text) {
    final RegExp priceRegex = RegExp(r'₹\s?\d+(\.\d+)?');
    final RegExp dateRegex = RegExp(r'\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b'); 
    final RegExp timeRegex = RegExp(r'\b\d{1,2}:\d{2}\s?(?:AM|PM|am|pm)?\b');

    final List<TextSpan> spans = [];

    text.split(' ').forEach((word) {
      if (priceRegex.hasMatch(word)) {
        spans.add(_highlight(word, color: Colors.green));
      } else if (dateRegex.hasMatch(word)) {
        spans.add(_highlight(word, color: Colors.orange));
      } else if (timeRegex.hasMatch(word)) {
        spans.add(_highlight(word, color: Colors.orange));
      } else if (storeNames != null &&
          storeNames!.any((store) => word.contains(store))) {
        spans.add(_highlight(word, color: Colors.blue));
      } else {
        spans.add(_normal(word));
      }
      spans.add(const TextSpan(text: " ")); // Add space
    });

    return RichText(text: TextSpan(children: spans));
  }

  TextSpan _highlight(String text, {Color color = Colors.blue}) {
    return TextSpan(
      text: text,
      style: GoogleFonts.sora(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  TextSpan _normal(String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.sora(
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }
}
