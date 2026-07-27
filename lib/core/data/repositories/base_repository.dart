/// Base class for repositories providing common functionality.
abstract class BaseRepository {
  Future<T> execute<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      rethrow;
    }
  }
}
