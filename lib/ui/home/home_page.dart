import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: Center(
        child: Container(
          width: 240,
          child: TaskWithName(
            taskPreset: TaskPreset(
              name: 'Walk the Dog',
              iconName: AppAssets.beer,
            ),
          ),
        ),
      ),
    );
  }
}
