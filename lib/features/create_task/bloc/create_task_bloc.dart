import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_to_do_app/core/data_access/repositories/repository_remote_data.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section.dart';
import 'package:my_to_do_app/helpers/constants/app_setting_constants.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(CreateTaskInitial()) {
    on<CreateTaskEvent>((event, emit) {});
    on<OnLoadPage>((event, emit) async {
      emit(const CreateTaskLoading());

      var sections = await _repositoryRemoteData
          .getProjectSections(AppSettingConstants.defaultProjectId);

      if (sections.hasError) {
        emit(CreateTaskFailed(message: sections.errorMessage));
        return;
      }

      emit(
        CreateTaskLoaded(
          sections: sections.proejctSection!,
        ),
      );
    });

    on<OnCreateTask>((event, emit) async {
      emit(const CreateTaskLoading());

      var createTask = await _repositoryRemoteData.createTask(
        event.content,
        event.description,
        event.dueDate,
        AppSettingConstants.defaultProjectId,
        event.sectionId,
      );

      if (createTask.hasError) {
        emit(const CreateTaskFailed(message: 'Failed to create comment'));
        return;
      }

      emit(const CreateTaskSuccess());
    });
  }

  final _repositoryRemoteData = RepositoryRemoteData();
}
