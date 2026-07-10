import '../repository/home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController(this.repository);

  bool backendOnline = false;

  Future<void> loadHealth() async {
    backendOnline = await repository.health();
  }
}