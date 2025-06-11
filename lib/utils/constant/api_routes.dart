/*In This class we maintain all our api routes*/
class ApiRoutes {
  factory ApiRoutes() {
    return _instance;
  }

  ApiRoutes._internal();

  static final ApiRoutes _instance = ApiRoutes._internal();

  static const String kBaseUrl = 'backend-cj4o057m.fctl.app';

  static const String fetchReelVideos = '/bytes/scroll';
}
