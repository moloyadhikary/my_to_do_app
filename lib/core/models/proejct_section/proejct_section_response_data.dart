import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';

class ProejctSectionResponseData extends GenericResponseModel {
  ProejctSectionResponseData({
    this.proejctSection,
  }) : super(
          hasError: true,
          responseStr: '',
          errorMessage: MessageConstant.commonErrorMessage,
        );

  ProejctSection? proejctSection;
}
