import 'package:flutter/material.dart';

class LongButtonWidget extends StatelessWidget {
  const LongButtonWidget({
    required this.title,
    this.function,
    super.key,
    this.isDisabled = false,
    this.titleWeight,
    this.titleColor,
    this.width,
    this.backgroundColor,
    this.horizontalPadding,
    this.fontSize,
    this.borderColor,
  });

  final String title;
  final void Function()? function;
  final bool isDisabled;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final Color? backgroundColor;
  final double? width;
  final double? horizontalPadding;
  final double? fontSize;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    //final extensionColor = Theme.of(context).extension<SkyThemeProvider>()!;
    final backColor = isDisabled ? Colors.grey : Colors.green;
    return SizedBox(
      height: 48,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ?? backColor,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            Colors.black,
          ),
          elevation: WidgetStateProperty.all<double>(0),
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              vertical: 8,
              horizontal: horizontalPadding ?? 32,
            ),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: borderColor ?? backgroundColor ?? backColor,
              ),
            ),
          ),
        ),
        onPressed: () {
          if (function != null) {
            function!();
            return;
          }
          // else {
          //   CommonHelper.showCommonValidationMessage();
          // }
        },
        child: Text(
          title,
          style: TextStyle(
            color: isDisabled ? Colors.black : titleColor ?? Colors.black,
            fontSize: fontSize ?? 16,
            fontFamily: 'Outfit',
            fontWeight: titleWeight ?? FontWeight.w600,
          ),
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
