import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/helpers/constants/app_setting_constants.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';

class GenericClient {
  static Future<GenericResponseModel> dioGet({
    required String actionUrl,
    required String jsonName,
  }) async {
    var genericResponseModel = GenericResponseModel(
      responseStr: '',
      hasError: true,
      errorMessage: MessageConstant.commonErrorMessage,
    );

    final dio = Dio();
    final url = AppSettingConstants.apiBaseUrl + actionUrl;
    dio.options.responseType = ResponseType.json;

    try {
      final Response<dynamic> response = await dio
          .get<String>(
            url,
            options: Options(
              responseType: ResponseType.json,
              headers: AppSettingConstants.baseApiHeaders,
            ),
          )
          .timeout(const Duration(seconds: 120))
          .onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }

        throw Exception(error);
      });

      if (response.statusCode == 200) {
        //TO DO: implement server error check here
        genericResponseModel = GenericResponseModel(
          responseStr: "{\"$jsonName\":  ${response.toString()}}",
          hasError: false,
          errorMessage: '',
        );
      }
    } catch (error) {
      genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        //TO DO: test handle dio error for all the cases
        errorMessage: MessageConstant.commonErrorMessage,
      );
    }

    return genericResponseModel;
  }

  static Future<GenericResponseModel> dioPost({
    required String actionUrl,
    required String jsonName,
    required FormData formData,
  }) async {
    var genericResponseModel = GenericResponseModel(
      responseStr: '',
      hasError: true,
      errorMessage: 'Cannot fetch data.',
    );

    final dio = Dio();
    final url = actionUrl;
    dio.options.responseType = ResponseType.json;

    try {
      final Response<dynamic> response = await dio
          .post<String>(
            url,
            options: Options(
              responseType: ResponseType.json,
              headers: AppSettingConstants.baseApiHeaders,
            ),
            data: formData,
          )
          .timeout(const Duration(seconds: 120))
          .onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
        throw Exception(error);
      });

      print(response.toString());

      if (response.statusCode == 200) {
        genericResponseModel = GenericResponseModel(
          responseStr: "{\"$jsonName\":  ${response.toString()}}",
          hasError: false,
          errorMessage: '',
        );
      }
    } catch (error) {
      genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        //TO DO: test handle dio error for all the cases
        errorMessage: MessageConstant.commonErrorMessage,
      );
    }

    return genericResponseModel;
  }
}
