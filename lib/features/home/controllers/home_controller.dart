import '../models/health_response.dart';
import '../repository/home_repository.dart';

class HomeController {
  HomeController(this.repository);

  final HomeRepository repository;

  HealthResponse? health;

  bool loading = false;

  Future<void> loadHealth() async {
    loading = true;

    health = await repository.health();

    loading = false;
  }

  bool get backendOnline {
  final status = health?.status;
  if (status == null) return false;

  return status.toUpperCase() == 'UP';
}

  String get backendStatus {
    return health?.status ?? 'OFFLINE';
  }

  String get applicationName {
    return health?.application ?? 'Backend Offline';
  }

  String get version {
    return health?.version ?? '--';
  }

  String get timestamp {
    if (health?.timestamp == null) {
      return '--';
    }

    return health!.timestamp.toString();
  }
}