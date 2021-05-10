import './search_strategy.dart';

class NoSearchStrategy<T> implements SearchStrategy<T> {
  @override
  Function(String query, List<T> elements) getSearchFunction() {
    return null;
  }
}
