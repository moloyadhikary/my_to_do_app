import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class TaskMovableBoardWidget extends StatelessWidget {
  const TaskMovableBoardWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: extensionColor.g3Border,
      )),
      width: 300,
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.album),
          title: Text(
            task.content ?? '',
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
                task.description ?? '',
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
                        .format(DateTime.parse(task.due!.datetime!)),
                    style: FontStyles.txtUbuntuBold.copyWith(
                      fontSize: getFontSize(18),
                      color: DateTime.parse(task.due!.datetime!)
                              .isAfter(DateTime.now())
                          ? Colors.green
                          : Colors.red,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
