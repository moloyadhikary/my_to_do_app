import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class LabelBoxWithBorderWidget extends StatelessWidget {
  const LabelBoxWithBorderWidget({
    super.key,
    this.title = '',
    this.initialValue = '',
    this.iconText,
    this.titleColor,
  });

  final String title;
  final String initialValue;
  final Color? titleColor;
  final IconData? iconText;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      width: double.maxFinite,
      padding: getPadding(
        left: 16,
        top: 8,
        right: 10,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: extensionColor.g3Border,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            getSize(
              12,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 8,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotEmpty)
                    Padding(
                      padding: getPadding(bottom: 4),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          title,
                          style: FontStyles.txtLatoMedium.copyWith(
                            color: titleColor ?? extensionColor.midEmphasize,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  else
                    SizedBox(height: getSize(8)),
                  Row(
                    children: [
                      FaIcon(
                        iconText ?? FontAwesomeIcons.user,
                        color: extensionColor.midEmphasize,
                      ),
                      SizedBox(
                        width: getSize(13),
                      ),
                      Container(
                        height: getSize(15),
                        width: 1,
                        color: extensionColor.lowEmphasize,
                      ),
                      SizedBox(
                        width: getSize(12),
                      ),
                      Flexible(
                        child: Text(
                          initialValue,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyles.txtLatoSemiBold.copyWith(
                            color: extensionColor.highEmphasize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
