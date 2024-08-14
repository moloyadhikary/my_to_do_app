import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_to_do_app/core/data_access/repositories/repository_remote_data.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section.dart';
import 'package:my_to_do_app/helpers/constants/app_setting_constants.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc() : super(UpdateTaskInitial()) {
    on<UpdateTaskEvent>((event, emit) {});
    on<OnLoadPage>((event, emit) async {
      emit(const UpdateTaskLoading());

      var sections = await _repositoryRemoteData
          .getProjectSections(AppSettingConstants.defaultProjectId);

      if (sections.hasError) {
        emit(UpdateTaskFailed(message: sections.errorMessage));
        return;
      }

      emit(
        UpdateTaskLoaded(
          sections: sections.proejctSection!,
        ),
      );
    });

    on<OnUpdateTask>((event, emit) async {
      emit(const UpdateTaskLoading());

      var updateTask = await _repositoryRemoteData.updateTask(
        event.taskId,
        event.content,
        event.description,
        event.dueDate,
        AppSettingConstants.defaultProjectId,
      );

      if (updateTask.hasError) {
        emit(const UpdateTaskFailed(message: 'Failed to update task'));
        return;
      }

      emit(const UpdateTaskSuccess());
    });
  }
  final _repositoryRemoteData = RepositoryRemoteData();
}
