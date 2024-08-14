import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/local_storage/operation/task_running_history_hive_operation.dart';

part 'completed_tasks_event.dart';
part 'completed_tasks_state.dart';

class CompletedTasksBloc
    extends Bloc<CompletedTasksEvent, CompletedTasksState> {
  CompletedTasksBloc() : super(CompletedTasksInitial()) {
    on<CompletedTasksEvent>((event, emit) {});

    on<OnLoadPage>((event, emit) async {
      emit(const CompletedTaskLoading());

      // var response = await _repositoryRemoteData
      //     .getProjectTasks(AppSettingConstants.defaultProjectId);

      // if (response.hasError) {
      //   emit(const CompletedTaskLoaded(tasks: []));
      //   return;
      // }

      // var tasks = <VmCompletedTask>[];
      // var completedTasks = response.projectTask == null
      //     ? <Task>[]
      //     : response.projectTask!.tasks!.where((e) => e.isCompleted!).toList();
      // for (var element in completedTasks) {
      //   var taskRunningStatus = await ops.get(element.id!);
      //   if (taskRunningStatus != null) {
      //     if (taskRunningStatus.markCompletedOn != null) {
      //       tasks.add(
      //         VmCompletedTask(
      //             task: element, completionInformation: taskRunningStatus),
      //       );
      //     }
      //   }
      // }

      var ops = TaskRunningHistoryHiveOperation();
      var tasks = await ops.getCompletedTasks();

      emit(
        CompletedTaskLoaded(tasks: tasks),
      );
    });
  }
}
