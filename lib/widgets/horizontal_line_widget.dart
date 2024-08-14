import 'package:flutter/material.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class HorizontalLineWidget extends StatelessWidget {
  const HorizontalLineWidget({
    super.key,
    required this.height,
    required this.width,
    this.color,
  });

  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color ?? extensionColor.g2Divider,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
