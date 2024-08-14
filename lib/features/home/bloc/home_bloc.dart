import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_to_do_app/core/data_access/repositories/repository_remote_data.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/core/models/view_models.dart';
import 'package:my_to_do_app/helpers/constants/app_setting_constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<OnLoadPage>((event, emit) async {
      emit(const HomeLoading());

      var sections = await _repositoryRemoteData
          .getProjectSections(AppSettingConstants.defaultProjectId);

      if (sections.hasError) {
        emit(HomeFailed(message: sections.errorMessage));
        return;
      }

      var tasks = await _repositoryRemoteData
          .getProjectTasks(AppSettingConstants.defaultProjectId);
      var activeTasks = tasks.projectTask == null
          ? <Task>[]
          : tasks.projectTask!.tasks!.where((e) => !e.isCompleted!).toList();

      var data = <VmSectionDetail>[];
      for (var element in sections.proejctSection!.sectionData!) {
        var thisItemTasks = <Task>[];
        if (!tasks.hasError) {
          if (tasks.projectTask != null) {
            thisItemTasks =
                activeTasks.where((e) => e.sectionId == element.id!).toList();
          }
        }
        var task = VmSectionDetail(section: element, tasks: thisItemTasks);
        data.add(task);
      }

      emit(
        HomeLoaded(
          sections: data,
        ),
      );
    });

    on<OnMoveTask>((event, emit) async {
      emit(const HomeLoading());

      var task = await _repositoryRemoteData.moveTask(
        event.taskId,
        event.newSectionId,
      );

      if (task.hasError) {
        emit(HomeFailed(message: task.errorMessage));
        return;
      }

      var sections = await _repositoryRemoteData
          .getProjectSections(AppSettingConstants.defaultProjectId);

      if (sections.hasError) {
        emit(HomeFailed(message: sections.errorMessage));
        return;
      }

      var tasks = await _repositoryRemoteData
          .getProjectTasks(AppSettingConstants.defaultProjectId);
      var activeTasks = tasks.projectTask == null
          ? <Task>[]
          : tasks.projectTask!.tasks!.where((e) => !e.isCompleted!).toList();

      var data = <VmSectionDetail>[];
      for (var element in sections.proejctSection!.sectionData!) {
        var thisItemTasks = <Task>[];
        if (!tasks.hasError) {
          if (tasks.projectTask != null) {
            thisItemTasks =
                activeTasks.where((e) => e.sectionId == element.id!).toList();
          }
        }
        var task = VmSectionDetail(section: element, tasks: thisItemTasks);
        data.add(task);
      }

      emit(
        HomeLoaded(
          sections: data,
        ),
      );
    });
  }

  final _repositoryRemoteData = RepositoryRemoteData();
}
