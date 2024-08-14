import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class InputBoxWithTextBorderWidget extends StatefulWidget {
  const InputBoxWithTextBorderWidget({
    super.key,
    this.title = '',
    this.hintText = 'Enter Card Holder Name',
    this.iconText,
    this.isHideIcon = false,
    this.isHideBar = false,
    required this.textController,
    required this.validator,
    this.onTapRight,
    this.keyVal,
    this.onChanged,
    this.rightText,
    this.rightIconPath,
    this.rightIconColor,
    this.formats,
    this.rightIconWidth,
    this.rightIconHeight,
    this.autoValidateMode,
    this.textInputType,
    this.enabled = true,
    this.autoFocus = false,
    this.textInputAction = TextInputAction.done,
    this.isObscureText = false,
    this.letterSpacing,
    this.maxLength,
    this.titleColor,
    this.obscuringCharacter,
    this.focusNode,
    this.enableInteractiveSelection,
  });

  final String title;
  final String hintText;
  final IconData? iconText;
  final bool? isHideIcon;
  final bool? isHideBar;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formats;
  final GlobalKey<FormFieldState<String>>? keyVal;
  final String? Function(String?)? onChanged;
  final String? rightText;
  final IconData? rightIconPath;
  final Color? rightIconColor;
  final double? rightIconWidth;
  final double? rightIconHeight;
  final VoidCallback? onTapRight;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? textInputType;
  final bool enabled;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final bool isObscureText;
  final double? letterSpacing;
  final int? maxLength;
  final Color? titleColor;
  final String? obscuringCharacter;
  final FocusNode? focusNode;
  final bool? enableInteractiveSelection;

  @override
  State<InputBoxWithTextBorderWidget> createState() =>
      _InputBoxWithTextBorderWidgetState();
}

class _InputBoxWithTextBorderWidgetState
    extends State<InputBoxWithTextBorderWidget> {
  @override
  void initState() {
    super.initState();
  }

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
                  if (widget.title.isNotEmpty)
                    Padding(
                      padding: getPadding(bottom: 4),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          widget.title,
                          style: FontStyles.txtLatoMedium.copyWith(
                            color: widget.titleColor ??
                                extensionColor.midEmphasize,
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
                      if (widget.isHideIcon == false)
                        FaIcon(
                          widget.iconText ?? FontAwesomeIcons.user,
                          color: extensionColor.midEmphasize,
                        ),
                      if (widget.isHideIcon == false)
                        SizedBox(
                          width: getSize(13),
                        ),
                      if (widget.isHideBar == false)
                        Container(
                          height: getSize(15),
                          width: 1,
                          color: extensionColor.lowEmphasize,
                        ),
                      if (widget.isHideBar == false)
                        SizedBox(
                          width: getSize(12),
                        ),
                      Flexible(
                        child: TextFormField(
                          enableInteractiveSelection:
                              widget.enableInteractiveSelection,
                          scrollPadding: EdgeInsets.zero,
                          autofocus: widget.autoFocus,
                          focusNode: widget.focusNode,
                          keyboardType:
                              widget.textInputType ?? TextInputType.text,
                          style: FontStyles.txtLatoSemiBold.copyWith(
                            color: extensionColor.highEmphasize,
                            letterSpacing: widget.letterSpacing,
                          ),
                          maxLength: widget.maxLength,
                          textInputAction: widget.textInputAction,
                          enabled: widget.enabled,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: widget.hintText,
                            hintMaxLines: 1,
                            hintStyle: FontStyles.txtLatoSemiBold.copyWith(
                              color: extensionColor.lowEmphasize,
                            ),
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            filled: false,
                          ),
                          controller: widget.textController,
                          key: widget.keyVal,
                          validator: widget.validator,
                          onChanged: (value) {
                            if (widget.onChanged != null) {
                              widget.onChanged!(value);
                            }
                          },
                          inputFormatters: widget.formats,
                          autovalidateMode: widget.autoValidateMode,
                          obscureText: widget.isObscureText,
                          obscuringCharacter: widget.obscuringCharacter ?? '•',
                          buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  if (widget.title.isEmpty)
                    SizedBox(height: getSize(4))
                  else
                    Container(),
                ],
              ),
            ),
          ),
          widget.rightIconPath != null || widget.rightText != null
              ? Flexible(
                  flex: 4,
                  child: GestureDetector(
                    onTap: widget.onTapRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        if (widget.rightText != null)
                          Column(
                            children: [
                              Padding(
                                padding: getPadding(top: 3),
                                child: Text(
                                  widget.rightText ?? 'ID Sample',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: FontStyles.txtLatoMedium,
                                ),
                              ),
                              SizedBox(
                                width: getSize(6),
                              ),
                            ],
                          ),
                        if (widget.rightIconPath != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 5, 0, 0),
                            child: FaIcon(
                              widget.rightIconPath ?? FontAwesomeIcons.envelope,
                              color: widget.rightIconColor ??
                                  extensionColor.midEmphasize,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
