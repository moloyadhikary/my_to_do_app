import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_to_do_app/core/models/proejct_section/section_datum.dart';
import 'package:my_to_do_app/features/create_task/bloc/create_task_bloc.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/helpers/size_utility_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/input_box_with_text_border_widget.dart';
import 'package:my_to_do_app/widgets/long_button_widget.dart';
import 'package:my_to_do_app/widgets/section_list_option_widget.dart';
import 'package:my_to_do_app/widgets/selection_widget.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateTaskBloc>(
        create: (context) => CreateTaskBloc()..add(const OnLoadPage()),
        child: const CreateTaskPage());
  }

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  var sections = <SectionDatum>[];
  SectionDatum? _selectedSource;
  bool _isFtInputDataValid = false;
  final _txtContentController = TextEditingController();
  final _txtDescriptionController = TextEditingController();
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  BlocListener<CreateTaskBloc, CreateTaskState>(
                    listener: (context, state) {
                      if (state is CreateTaskLoading) {
                        context.loaderOverlay.show();
                      } else {
                        context.loaderOverlay.hide();
                      }
                      if (state is CreateTaskSuccess) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouteHelper.home,
                          (Route<dynamic> route) => false,
                        );
                      }
                      if (state is CreateTaskFailed) {}
                      if (state is CreateTaskLoaded) {
                        setState(() {
                          sections = state.sections.sectionData ?? [];
                        });
                      }
                    },
                    child: Container(),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      'Create Task',
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
                      'Please enter the task details',
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<Widget>(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        builder: (context) {
                          return SectionListOptionWidget(
                            sections: sections,
                            onSelect: (selectedSource) {
                              setState(() {
                                _selectedSource = selectedSource;
                              });
                              _validateFtInputData();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    child: SelectionWidget(
                      topLabel: 'Section',
                      description: _selectedSource != null
                          ? _selectedSource!.name ?? ''
                          : 'Select task section',
                      icon: FontAwesomeIcons.listCheck,
                      style: FontStyles.txtLatoSemiBold.copyWith(
                        color: _selectedSource != null
                            ? extensionColor.highEmphasize
                            : extensionColor.lowEmphasize,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: getSize(24)),
                  InputBoxWithTextBorderWidget(
                    title: 'Content',
                    hintText: 'Enter task name/content here',
                    iconText: FontAwesomeIcons.solidMessage,
                    textController: _txtContentController,
                    textInputType: TextInputType.text,
                    onChanged: (p0) {
                      _validateFtInputData();
                      return p0;
                    },
                    validator: (p0) {
                      return null;
                    },
                  ),
                  SizedBox(height: getSize(24)),
                  InkWell(
                    onTap: () => dueDateTimePicker(extensionColor),
                    child: SelectionWidget(
                      topLabel: 'Due Date',
                      description: reportingDate != null
                          ? formatter.format(reportingDate!)
                          : 'Select date',
                      isHideBar: true,
                      rightIcon: FontAwesomeIcons.calendar,
                      descriptionColor: reportingDate != null
                          ? extensionColor.highEmphasize
                          : extensionColor.lowEmphasize,
                    ),
                  ),
                  SizedBox(height: getSize(24)),
                  InputBoxWithTextBorderWidget(
                    title: 'Description',
                    hintText: 'Enter task description here',
                    iconText: FontAwesomeIcons.message,
                    textController: _txtDescriptionController,
                    textInputType: TextInputType.text,
                    onChanged: (p0) {
                      _validateFtInputData();
                      return p0;
                    },
                    validator: (p0) {
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 34,
            ),
            child: LongButtonWidget(
              title: 'Next',
              function: _isFtInputDataValid ? _onTapNext : null,
              isDisabled: !_isFtInputDataValid,
            ),
          ),
        ),
      ),
    );
  }

  void _validateFtInputData() {
    if (_selectedSource != null) {
      if (_txtContentController.text.trim().isNotEmpty) {
        if (reportingDate != null) {
          if (_txtDescriptionController.text.trim().isNotEmpty) {
            setState(() {
              _isFtInputDataValid = true;
            });
          } else {
            setState(() {
              _isFtInputDataValid = false;
            });
          }
        } else {
          setState(() {
            _isFtInputDataValid = false;
          });
        }
      } else {
        setState(() {
          _isFtInputDataValid = false;
        });
      }
    } else {
      setState(() {
        _isFtInputDataValid = false;
      });
    }
  }

  DateTime currentDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  DateTime? reportingDate;
  DateTime reportingDateStore = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );

  void dueDateTimePicker(
    AppThemeProvider extensionColor,
  ) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height * 0.40,
          child: Container(
            width: double.infinity,
            color: extensionColor.groundPrimary,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      brightness: Brightness.light,
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      backgroundColor: extensionColor.groundPrimary,
                      onDateTimeChanged: (value) {
                        reportingDateStore = value;
                      },
                      minimumDate: currentDate,
                      initialDateTime: reportingDate ?? currentDate,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: LongButtonWidget(
                      title: 'Done',
                      function: () {
                        Navigator.of(context).pop();
                        setState(() {
                          reportingDate = reportingDateStore;
                        });
                        _validateFtInputData();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTapNext() {
    if (_isFtInputDataValid) {
      BlocProvider.of<CreateTaskBloc>(context).add(
        OnCreateTask(
          content: _txtContentController.text.trim(),
          dueDate: formatter.format(reportingDate!),
          sectionId: _selectedSource!.id!,
          description: _txtDescriptionController.text.trim(),
        ),
      );
    }
  }
}
