import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/core/models/task_comments/comment.dart';
import 'package:my_to_do_app/features/task_detail/bloc/task_detail_bloc.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/local_storage/operation/task_running_history_hive_operation.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/create_comment_form_widget.dart';
import 'package:my_to_do_app/widgets/horizontal_line_widget.dart';
import 'package:my_to_do_app/widgets/input_box_with_text_border_widget.dart';
import 'package:my_to_do_app/widgets/long_button_widget.dart';
import 'package:my_to_do_app/widgets/selection_widget.dart';
import 'package:my_to_do_app/widgets/task_comment_widget.dart';
import 'package:my_to_do_app/widgets/task_runner_information_widget.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.task,
  });

  final Task task;

  static Widget builder(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    var taskDetails = routeArgs['taskDetail'] as Task;
    return BlocProvider<TaskDetailBloc>(
      create: (context) => TaskDetailBloc()
        ..add(
          OnLoadTaskComments(
            taskId: taskDetails.id!,
          ),
        ),
      child: TaskDetailPage(
        task: taskDetails,
      ),
    );
  }

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  var comments = <Comment>[];
  var isCommentLoaded = false;
  TaskRunningHistoryHiveModel? _taskRunningStatus;
  var istaskRunningInfoLoaded = false;
  final _txtContentController = TextEditingController();
  final _txtDescriptionController = TextEditingController();
  DateTime? _reportingDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    loadRunningStatus();
    _txtContentController.text = widget.task.content!;
    _txtDescriptionController.text = widget.task.description!;
    _reportingDate = DateTime.parse(widget.task.due!.string!);
    super.initState();
  }

  void loadRunningStatus() async {
    var ops = TaskRunningHistoryHiveOperation();
    var taskRunningStatus = await ops.get(widget.task.id!);
    if (taskRunningStatus != null) {
      setState(() {
        _taskRunningStatus = taskRunningStatus;
      });
    }
    setState(() {
      istaskRunningInfoLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(child: CircularProgressIndicator());
      },
      overlayWholeScreen: true,
      overlayColor: Colors.black.withOpacity(0.8),
      child: Scaffold(
        backgroundColor: extensionColor.groundPrimary,
        appBar: AppBar(
          backgroundColor: extensionColor.groundSecondary,
          centerTitle: true,
          title: Text(
            'To Do App',
            style: FontStyles.txtLatoBold.copyWith(
              color: extensionColor.highEmphasize,
            ),
          ),
          foregroundColor: extensionColor.highEmphasize,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                BlocListener<TaskDetailBloc, TaskDetailState>(
                  listener: (context, state) {
                    if (state is TaskDetailLoading) {
                      context.loaderOverlay.show();
                    } else {
                      context.loaderOverlay.hide();
                    }
                    if (state is TaskDetailFailed) {}
                    if (state is TaskCommentsLoaded) {
                      setState(() {
                        comments = state.comments;
                        isCommentLoaded = true;
                      });
                    }
                    if (state is TaskStartStopSuccess) {
                      if (state.shouldReload) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouteHelper.home,
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          _taskRunningStatus = state.taskRunningStatus;
                        });
                      }
                    }
                  },
                  child: Container(),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Task Details',
                    style: FontStyles.txtOutfitBold.copyWith(
                      color: extensionColor.highEmphasize,
                      fontSize: getFontSize(20),
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Selected task details appear here',
                    style: FontStyles.txtLatoRegular.copyWith(
                      color: extensionColor.midEmphasize,
                      fontSize: getFontSize(18),
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: getSize(24)),
                if (_taskRunningStatus == null && istaskRunningInfoLoaded)
                  LongButtonWidget(
                    title: 'Start Task',
                    function: () {
                      BlocProvider.of<TaskDetailBloc>(context).add(
                        OnTaskStart(taskId: widget.task.id!),
                      );
                    },
                  ),
                if (_taskRunningStatus != null && istaskRunningInfoLoaded)
                  TaskRunnerInformationWidget(
                    information: _taskRunningStatus!,
                    onStop: () {
                      BlocProvider.of<TaskDetailBloc>(context).add(
                        OnStopTask(taskId: widget.task.id!),
                      );
                    },
                    onMarkComplete: () {
                      BlocProvider.of<TaskDetailBloc>(context).add(
                        OnTaskMarkedCompleted(taskId: widget.task.id!),
                      );
                    },
                  ),
                SizedBox(height: getSize(24)),
                InputBoxWithTextBorderWidget(
                  title: 'Content',
                  hintText: 'Enter task name/content here',
                  iconText: FontAwesomeIcons.solidMessage,
                  textController: _txtContentController,
                  textInputType: TextInputType.text,
                  enabled: false,
                  validator: (p0) {
                    return null;
                  },
                ),
                SizedBox(height: getSize(24)),
                SelectionWidget(
                  topLabel: 'Due Date',
                  description: _reportingDate != null
                      ? formatter.format(_reportingDate!)
                      : 'Select date',
                  isHideBar: true,
                  rightIcon: FontAwesomeIcons.calendar,
                  descriptionColor: extensionColor.highEmphasize,
                ),
                SizedBox(height: getSize(24)),
                InputBoxWithTextBorderWidget(
                  title: 'Description',
                  hintText: 'Enter task description here',
                  iconText: FontAwesomeIcons.message,
                  textController: _txtDescriptionController,
                  textInputType: TextInputType.text,
                  validator: (p0) {
                    return null;
                  },
                  enabled: false,
                ),
                SizedBox(height: getSize(24)),
                if (!isCommentLoaded)
                  const Center(
                    child: Column(
                      children: [
                        CupertinoActivityIndicator(),
                        SizedBox(height: 6),
                        Text('Loading Comments'),
                      ],
                    ),
                  ),
                if (isCommentLoaded)
                  Container(
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
                                    FontAwesomeIcons.comments,
                                  ),
                                  SizedBox(width: getSize(8)),
                                  Text(
                                    'Comments',
                                    style: FontStyles.txtLatoBold.copyWith(
                                      fontSize: getFontSize(18),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: _showCreateCommentForm,
                                icon: const FaIcon(
                                  FontAwesomeIcons.squarePlus,
                                ),
                              )
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
                            children: getTaskComments(),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getTaskComments() {
    var widgets = <Widget>[];
    for (var item in comments) {
      widgets.add(TestCommentWidget(comment: item));
    }
    return widgets;
  }

  void _showCreateCommentForm() {
    showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return Wrap(
          children: [
            CreateCommentFormWidget(
              onSubmit: (p0) {
                BlocProvider.of<TaskDetailBloc>(context).add(
                  OnCreateComment(
                    taskId: widget.task.id!,
                    comment: p0,
                  ),
                );
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
