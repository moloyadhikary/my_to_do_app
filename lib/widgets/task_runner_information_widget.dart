import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:humanize_duration/humanize_duration.dart';
import 'package:intl/intl.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/horizontal_line_widget.dart';
import 'package:my_to_do_app/widgets/label_box_with_border_widget.dart';
import 'package:my_to_do_app/widgets/long_button_widget.dart';

class TaskRunnerInformationWidget extends StatefulWidget {
  const TaskRunnerInformationWidget({
    super.key,
    required this.information,
    required this.onStop,
    required this.onMarkComplete,
  });

  final TaskRunningHistoryHiveModel information;
  final void Function() onStop;
  final void Function() onMarkComplete;

  @override
  State<TaskRunnerInformationWidget> createState() =>
      _TaskRunnerInformationWidgetState();
}

class _TaskRunnerInformationWidgetState
    extends State<TaskRunnerInformationWidget> {
  Timer? timer;
  var durationString = '';

  @override
  void initState() {
    if (widget.information.endedOn == null) {
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => handleDuration());
    } else {
      stopTimer();
      setState(() {
        durationString = widget.information.duration!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  void stopTimer() {
    if (timer != null) timer!.cancel();
  }

  handleDuration() {
    var startedDate = DateTime.parse(widget.information.startedOn);
    var diff = DateTime.now().difference(startedDate);
    setState(() {
      durationString = humanizeDuration(
        diff,
        options: const HumanizeOptions(
          units: [Units.day, Units.hour, Units.minute, Units.second],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: extensionColor.groundSecondary,
          border: Border.all(color: extensionColor.g3Border),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidClock,
                    ),
                    SizedBox(width: getSize(8)),
                    Text(
                      'Task is Running',
                      style: FontStyles.txtLatoBold.copyWith(
                        fontSize: getFontSize(18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: getPadding(top: 6, bottom: 6),
              child: HorizontalLineWidget(
                  color: Colors.blue,
                  height: getSize(2),
                  width: double.infinity),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelBoxWithBorderWidget(
                  title: 'Started On',
                  iconText: FontAwesomeIcons.clock,
                  initialValue: DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(widget.information.startedOn)),
                ),
                SizedBox(height: getSize(8)),
                LabelBoxWithBorderWidget(
                  title: 'Duration',
                  iconText: FontAwesomeIcons.personRunning,
                  initialValue: durationString,
                ),
                if (widget.information.endedOn == null)
                  SizedBox(height: getSize(8)),
                if (widget.information.endedOn == null)
                  LongButtonWidget(
                    title: 'Stop',
                    function: () {
                      stopTimer();
                      widget.onStop();
                    },
                  ),
                if (widget.information.markCompletedOn == null &&
                    widget.information.endedOn != null)
                  SizedBox(height: getSize(8)),
                if (widget.information.markCompletedOn == null &&
                    widget.information.endedOn != null)
                  LongButtonWidget(
                    title: 'Mark Completed',
                    function: () {
                      widget.onMarkComplete();
                    },
                  ),
                if (widget.information.markCompletedOn != null)
                  SizedBox(height: getSize(8)),
                if (widget.information.markCompletedOn != null)
                  const LongButtonWidget(
                    title: 'Marked As Completed',
                    isDisabled: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
