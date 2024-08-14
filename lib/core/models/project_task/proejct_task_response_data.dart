import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/project_task/project_task.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';

class ProejctTaskResponseData extends GenericResponseModel {
  ProejctTaskResponseData({
    this.projectTask,
  }) : super(
          hasError: true,
          responseStr: '',
          errorMessage: MessageConstant.commonErrorMessage,
        );

  ProjectTask? projectTask;
}
