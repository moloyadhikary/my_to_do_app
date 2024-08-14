import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({
    super.key,
    required this.task,
  });

  final TaskRunningHistoryHiveModel task;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;

    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(
                task.taskId,
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
                    task.duration ?? '',
                    style: FontStyles.txtUbuntuRegular.copyWith(
                      fontSize: getFontSize(18),
                      color: extensionColor.highEmphasize,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: getSize(4)),
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.clock,
                        size: getSize(14),
                      ),
                      SizedBox(width: getSize(4)),
                      Text(
                        DateFormat('dd MMM, HH:mm')
                            .format(DateTime.parse(task.markCompletedOn!)),
                        style: FontStyles.txtUbuntuBold.copyWith(
                          fontSize: getFontSize(18),
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
