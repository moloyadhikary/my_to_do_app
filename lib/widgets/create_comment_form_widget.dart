import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/input_box_with_text_border_widget.dart';
import 'package:my_to_do_app/widgets/long_button_widget.dart';

class CreateCommentFormWidget extends StatefulWidget {
  const CreateCommentFormWidget({
    super.key,
    required this.onSubmit,
  });

  final Function(String) onSubmit;

  @override
  State<CreateCommentFormWidget> createState() =>
      _CreateCommentFormWidgetState();
}

class _CreateCommentFormWidgetState extends State<CreateCommentFormWidget> {
  var commentTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;

    return Container(
      color: extensionColor.groundPrimary,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: getPadding(all: 12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  'Create Comment',
                  style: FontStyles.txtOutfitBold.copyWith(
                    color: extensionColor.highEmphasize,
                    fontSize: getFontSize(20),
                  ),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: getSize(16)),
              InputBoxWithTextBorderWidget(
                title: 'Comment',
                hintText: 'Enter your comment here',
                iconText: FontAwesomeIcons.comment,
                textController: commentTextController,
                textInputType: TextInputType.text,
                validator: (p0) {
                  if (p0 == null) {
                    return "Please provide comment";
                  }
                  if (p0.trim().isEmpty) {
                    return "Please provide comment";
                  }
                  return null;
                },
              ),
              SizedBox(height: getSize(16)),
              LongButtonWidget(
                title: 'Save Comment',
                function: () {
                  if (formKey.currentState!.validate()) {
                    var comment = commentTextController.text.trim();
                    commentTextController.clear();
                    widget.onSubmit(comment);
                  }
                },
              ),
              SizedBox(height: getSize(30)),
            ],
          ),
        ),
      ),
    );
  }
}
