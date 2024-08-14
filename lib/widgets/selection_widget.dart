import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({
    super.key,
    required this.topLabel,
    this.topLabelColor,
    required this.description,
    this.icon,
    this.iconColor,
    this.isHideBar = false,
    this.isRightIconVisible = true,
    this.descriptionWidget,
    this.rightIcon = FontAwesomeIcons.arrowDown,
    this.backGroundColor,
    this.descriptionColor,
    this.letterSpacing,
    this.style,
    this.rightIconColor,
    this.fontSize = 16,
    this.borderColor,
  });

  final String topLabel;
  final Color? topLabelColor;
  final String description;
  final IconData? icon;
  final double fontSize;
  final Color? iconColor;
  final bool isHideBar;
  final bool isRightIconVisible;
  final Widget? descriptionWidget;
  final IconData? rightIcon;
  final Color? rightIconColor;
  final Color? backGroundColor;
  final Color? descriptionColor;
  final double? letterSpacing;
  final TextStyle? style;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
        right: 10,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: backGroundColor ?? extensionColor.groundPrimary,
        border: Border.all(
          color: borderColor ?? extensionColor.g3Border,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      topLabel,
                      style: FontStyles.txtLatoMedium.copyWith(
                        color: topLabelColor ?? extensionColor.midEmphasize,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (icon != null)
                        FaIcon(
                          icon,
                          color: iconColor ?? extensionColor.midEmphasize,
                        ),
                      if (isHideBar == false) const SizedBox(width: 13),
                      if (isHideBar == false)
                        Container(
                          height: 15,
                          width: 1,
                          color: extensionColor.lowEmphasize,
                        ),
                      if (isHideBar == false) const SizedBox(width: 12),
                      Flexible(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: descriptionWidget ??
                              Text(
                                description,
                                style: style ??
                                    FontStyles.txtLatoSemiBold.copyWith(
                                        color: descriptionColor ??
                                            extensionColor.lowEmphasize,
                                        letterSpacing: letterSpacing ?? 0,
                                        fontSize: fontSize),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isRightIconVisible) const SizedBox(width: 10),
          if (isRightIconVisible)
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                top: 8,
                right: 4,
                bottom: 4,
              ),
              child: FaIcon(
                rightIcon,
                color: rightIconColor ?? extensionColor.midEmphasize,
              ),
            ),
        ],
      ),
    );
  }
}
