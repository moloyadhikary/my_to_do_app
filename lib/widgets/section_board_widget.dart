import 'package:flutter/material.dart';
import 'package:my_to_do_app/core/models/view_models.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/task_board_widget.dart';
import 'package:my_to_do_app/widgets/task_movable_board_widget.dart';

class SectionBoardWidget extends StatefulWidget {
  const SectionBoardWidget({
    super.key,
    required this.sectionDetail,
  });

  final VmSectionDetail sectionDetail;

  @override
  State<SectionBoardWidget> createState() => _SectionBoardWidgetState();
}

class _SectionBoardWidgetState extends State<SectionBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: extensionColor.g2Divider,
        ),
      ),
      height: MediaQuery.of(context).size.height - kToolbarHeight - 30,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
        backgroundColor: extensionColor.groundPrimary,
        appBar: AppBar(
          backgroundColor: extensionColor.g3Border,
          title: Text(
            widget.sectionDetail.section.name ?? '',
            style: FontStyles.txtUbuntuBold.copyWith(
              color: extensionColor.highEmphasize,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: getSectionBoards(extensionColor),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getSectionBoards(AppThemeProvider extensionColor) {
    var widgets = <Widget>[];

    for (var item in widget.sectionDetail.tasks) {
      var task = TaskBoardWidget(task: item);
      widgets.add(
        Draggable(
          data: item,
          feedback: TaskMovableBoardWidget(task: item),
          childWhenDragging: Container(),
          onDraggableCanceled: (_, __) {
            print('Drag Canceled');
          },
          child: task,
        ),
      );
    }

    return widgets;
  }
}
