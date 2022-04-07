import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/task/ring_painter.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainer(
          progress: progress,
          taskCompletedColor: themeData.accent,
          taskNotCompletedColor: themeData.taskRing,
        ),
      ),
    );
  }
}
