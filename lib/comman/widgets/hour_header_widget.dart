import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/constants/color_constansts.dart';

class HourDealHeader extends StatefulWidget {
  final DateTime endTime;

  const HourDealHeader({Key? key, required this.endTime}) : super(key: key);

  @override
  _HourDealHeaderState createState() => _HourDealHeaderState();
}

class _HourDealHeaderState extends State<HourDealHeader> {
  Duration _remaining = const Duration(minutes: 60);
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _ticker = Ticker((elapsed) {
      final newRemaining = const Duration(minutes: 60) - elapsed;

      if (newRemaining.isNegative || newRemaining == Duration.zero) {
        _ticker.stop();
        setState(() => _remaining = Duration.zero);
      } else {
        setState(() => _remaining = newRemaining);
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = twoDigits(_remaining.inHours.remainder(24));
  final minutes = twoDigits(_remaining.inMinutes.remainder(60));
  final seconds = twoDigits(_remaining.inSeconds.remainder(60));

  return Row(
    mainAxisSize: MainAxisSize.min, // shrink wrap
    children: [
      const Icon(
        Icons.timer,
        color: ColorConstants.white,
        size: 16, // smaller icon
      ),
      const SizedBox(width: 4), // tighter spacing
      Text(
        'Hour Deal $hours:$minutes:$seconds',
        style: AppConstants.headerwhite.copyWith(
          fontSize: 12,  // smaller font size
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

}
