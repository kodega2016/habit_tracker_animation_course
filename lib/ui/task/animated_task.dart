import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({
    Key? key,
    required this.iconName,
  }) : super(key: key);

  final String iconName;

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showCheckIcon = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    )..addStatusListener(_updateStatusChanges);
    _animation = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateStatusChanges(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() {
          _showCheckIcon = true;
        });
      }
      Future.delayed(
          Duration(seconds: 1),
          () => {
                if (mounted)
                  setState(() {
                    _showCheckIcon = false;
                  })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? size) {
          final themeData = AppTheme.of(context);
          final progress = _animationController.value;
          final isCompleted = progress == 1.0;
          final color =
              isCompleted ? themeData.accentNegative : themeData.taskIcon;
          return Stack(
            children: [
              TaskCompletionRing(
                progress: _animation.value,
              ),
              Positioned.fill(
                child: CenteredSvgIcon(
                  iconName: isCompleted && _showCheckIcon
                      ? AppAssets.check
                      : widget.iconName,
                  color: color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleTapDown(TapDownDetails tapDownDetails) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else if (!_showCheckIcon) {
      _animationController.value = 0;
    }
  }

  void _handleTapUp(TapUpDetails tapUpDetails) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }
}
