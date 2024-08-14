class AppSettingConstants {
  static String apiBaseUrl = 'https://api.todoist.com/rest/v2/';
  static String apiBaseSyncUrl = 'https://api.todoist.com/sync/v9/sync';
  static String apiBearerToken = '8d536e2967596409dac851b8049f5bf9f10c4c62';
  static String defaultProjectId = '2337526004';
  static var baseApiHeaders = {
    'authorization': 'Bearer $apiBearerToken',
  };
}
