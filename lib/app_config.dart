
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Flavor ref: https://sebastien-arbogast.com/2022/05/02/multi-environment-flutter-projects-with-flavors/

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError();
});

enum AppEnvironment{dev, prod}

class AppConfig{
  final AppEnvironment environment;
  final String baseUrl;
  const AppConfig({
    required this.environment,
    required this.baseUrl
  });

}

