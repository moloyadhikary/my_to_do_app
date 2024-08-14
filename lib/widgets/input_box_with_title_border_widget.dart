import 'package:flutter/material.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class InputBoxWithTitleBorderWidget extends StatefulWidget {
  const InputBoxWithTitleBorderWidget({
    super.key,
    required this.textBoxController,
    this.isObsecure = false,
    required this.title,
    this.titleColor,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.height,
    this.keyboardType,
    this.onChanged,
    this.decoratorColor,
    this.fillColor,
    this.borderColor,
  });
  final TextEditingController textBoxController;
  final bool isObsecure;
  final String title;
  final Color? titleColor;
  final String? validationMessage;
  final TextInputAction? textInputAction;
  final String? Function(String?)? onChanged;
  final double? height;
  final TextInputType? keyboardType;
  final Color? decoratorColor;
  final Color? fillColor;
  final Color? borderColor;

  @override
  State<InputBoxWithTitleBorderWidget> createState() =>
      _InputBoxWithTitleBorderWidgetState();
}

class _InputBoxWithTitleBorderWidgetState
    extends State<InputBoxWithTitleBorderWidget> {
  bool isInvalid = false;
  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        color: widget.decoratorColor ?? Colors.grey,
        //color: ColorConstant.gray50,
        border: Border.all(
          color: widget.borderColor ?? Colors.grey.shade300,
        ),
      ),
      padding: getPadding(left: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: getPadding(
              bottom: 8,
            ),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: FontStyles.txtLatoSemiBold.copyWith(
                fontSize: getFontSize(13),
                // height: 0.09,
                letterSpacing: 1,
                //color: extensionColor.gray600,
                color: widget.titleColor ?? extensionColor.midEmphasize,
              ),
            ),
          ),
          SizedBox(
            height: widget.height ?? (isInvalid ? getSize(50) : getSize(24)),
            width: double.infinity,
            child: TextFormField(
              //autofocus: true,
              textAlignVertical: TextAlignVertical.top,
              obscureText: widget.isObsecure,
              obscuringCharacter: '▪',
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType ?? TextInputType.multiline,
              maxLines: null,
              expands: true,
              style: FontStyles.txtLatoSemiBold.copyWith(
                color: extensionColor.highEmphasize,
                fontSize: getFontSize(16),
              ),
              decoration: InputDecoration(
                isDense: false,
                focusColor: Colors.grey.shade50,
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    //color: extensionColor.gray100,
                    //color: Colors.transparent,
                    color: Colors.transparent,
                    width: getHorizontalSize(
                      0,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    //color: extensionColor.gray100,
                    color: Colors.transparent,
                    width: getHorizontalSize(
                      0,
                    ),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: getHorizontalSize(
                      0,
                    ),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: getHorizontalSize(
                      0,
                    ),
                  ),
                ),
                filled: true,
                //fillColor: ColorConstant.gray50,
                fillColor: widget.fillColor ?? Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: widget.textBoxController,
              validator: (value) {
                if (value == null) {
                  setState(() {
                    isInvalid = true;
                  });
                  return widget.validationMessage;
                }

                if (value.trim().isEmpty) {
                  setState(() {
                    isInvalid = true;
                  });
                  return widget.validationMessage;
                }

                setState(() {
                  isInvalid = false;
                });
                return null;
              },
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
