import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_to_do_app/features/completed_tasks/bloc/completed_tasks_bloc.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/completed_task_widget.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<CompletedTasksBloc>(
        create: (context) => CompletedTasksBloc()..add(const OnLoadPage()),
        child: const CompletedTasksPage());
  }

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  var tasks = <TaskRunningHistoryHiveModel>[];
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
                BlocListener<CompletedTasksBloc, CompletedTasksState>(
                  listener: (context, state) {
                    if (state is CompletedTaskLoading) {
                      context.loaderOverlay.show();
                    } else {
                      context.loaderOverlay.hide();
                    }
                    if (state is CompletedaskFailed) {}
                    if (state is CompletedTaskLoaded) {
                      setState(() {
                        tasks = state.tasks;
                      });
                    }
                  },
                  child: Container(),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Completed Tasks',
                    style: FontStyles.txtOutfitBold.copyWith(
                      color: extensionColor.highEmphasize,
                      fontSize: getFontSize(20),
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: getSize(24)),
                Column(
                  children: getCompletedTaskWidgets(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getCompletedTaskWidgets() {
    var widgets = <Widget>[];

    for (var item in tasks) {
      widgets.add(CompletedTaskWidget(task: item));
    }

    return widgets;
  }
}
