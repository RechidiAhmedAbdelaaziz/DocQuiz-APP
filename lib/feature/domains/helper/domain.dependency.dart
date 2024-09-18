import 'package:app/core/types/di_function.dart';
import 'package:app/feature/domains/data/repo/domain.repo.dart';
import 'package:app/feature/domains/data/source/domain.api.dart';

DependencyFunction setupDomainDependency = (locator) async {
  locator.registerLazySingleton(() => DomainApi(locator()));
  locator.registerLazySingleton(() => DomainRepo());
};
