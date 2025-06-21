import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/app_colors.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.isToggled,
    required this.onToggle,
  });

  final bool isToggled;
  final ValueChanged<bool> onToggle;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.isToggled;
  }

  void _toggle() {
    setState(() {
      _isToggled = !_isToggled;
    });
    widget.onToggle(_isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 36.w,
        height: 21.h,
        decoration: BoxDecoration(
          color:
              _isToggled
                  ? Color(0xff65C466)
                  : Colors.grey, // Grey when unselected
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _isToggled ? 15 : 2,
              top: 1,
              child: CircleAvatar(backgroundColor: Colors.white, radius: 10.r),
            ),
          ],
        ),
      ),
    );
  }
}
