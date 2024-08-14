import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/core/models/view_models.dart';
import 'package:my_to_do_app/features/home/bloc/home_bloc.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/app_drawer.dart';
import 'package:my_to_do_app/widgets/section_board_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(const OnLoadPage()),
        child: const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var projectSections = <VmSectionDetail>[];
  ScrollController con = ScrollController();
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
            'My To Do App',
            style: FontStyles.txtLatoBold.copyWith(
              color: extensionColor.highEmphasize,
            ),
          ),
          foregroundColor: extensionColor.highEmphasize,
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create Task',
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouteHelper.createTask);
          },
          child: const Icon(Icons.add),
        ),
        drawer: const AppDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (state is HomeFailed) {}
                  if (state is HomeLoaded) {
                    setState(() {
                      projectSections = state.sections;
                    });
                  }
                },
                child: Container(),
              ),
              SingleChildScrollView(
                controller: con,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: getSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getSection() {
    var widgetList = <Widget>[];

    for (var item in projectSections) {
      widgetList.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DragTarget(
          onAcceptWithDetails: (details) {
            var targgetedTask = details.data as Task;
            if (targgetedTask.sectionId != item.section.id) {
              BlocProvider.of<HomeBloc>(context).add(
                OnMoveTask(
                  taskId: targgetedTask.id!,
                  newSectionId: item.section.id!,
                ),
              );
            }
          },
          builder: (context, candidateData, rejectedData) {
            return SectionBoardWidget(
              sectionDetail: item,
            );
          },
        ),
      ));
    }

    return widgetList;
  }
}
