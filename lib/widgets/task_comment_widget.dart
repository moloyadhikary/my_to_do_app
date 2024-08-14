import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_to_do_app/core/models/task_comments/comment.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class TestCommentWidget extends StatelessWidget {
  const TestCommentWidget({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Card(
      child: ListTile(
        //leading: const Icon(Icons.album),
        title: Text(
          comment.content ?? '',
          style: FontStyles.txtUbuntuBold.copyWith(
            fontSize: getFontSize(20),
            color: extensionColor.highEmphasize,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd MMM, HH:mm')
                  .format(DateTime.parse(comment.postedAt!.toString())),
              style: FontStyles.txtUbuntuRegular.copyWith(
                fontSize: getFontSize(18),
                color: extensionColor.highEmphasize,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
