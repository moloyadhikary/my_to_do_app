import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/task_comments/task_comments.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';

class TaskCommentsResponseData extends GenericResponseModel {
  TaskCommentsResponseData({
    this.taskComments,
  }) : super(
          hasError: true,
          responseStr: '',
          errorMessage: MessageConstant.commonErrorMessage,
        );

  TaskComments? taskComments;
}
