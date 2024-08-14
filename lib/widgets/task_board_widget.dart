import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class TaskBoardWidget extends StatelessWidget {
  const TaskBoardWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouteHelper.taskDetail, arguments: {
          'taskDetail': task,
        });
      },
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(10)),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton.icon(
                    icon: FaIcon(FontAwesomeIcons.pencil, size: getSize(16)),
                    label: const Text('EDIT'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouteHelper.updateTask, arguments: {
                        'taskDetail': task,
                      });
                    },
                  ),
                  SizedBox(width: getSize(8)),
                  Row(
                    children: [
                      const Icon(
                        Icons.comment,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        (task.commentCount ?? 0).toString(),
                        style: FontStyles.txtLatoBold.copyWith(
                          fontSize: 18,
                          color: extensionColor.highEmphasize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getSize(8)),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
