class GenericResponseModel {
  GenericResponseModel({
    required this.responseStr,
    required this.hasError,
    required this.errorMessage,
  });
  String responseStr;
  bool hasError;
  String errorMessage;
}
