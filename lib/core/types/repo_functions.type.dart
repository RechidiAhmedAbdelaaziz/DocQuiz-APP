import 'package:app/core/di/container.dart';

import 'api_result.type.dart';

typedef RepoResult<T> = Future<ApiResult<T>>;
typedef RepoListResult<T> = Future<ApiResult<List<T>>>;


/// Base class for all repositories 
/// [T] is the api class that the repository will use
abstract class RepoBase<T> {
  final api = locator<T>();
}
