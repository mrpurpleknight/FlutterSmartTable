import '../../fetch/fetch_processor.dart';

abstract class DataSource<T> implements FetchProcessor<T>{
  get data;

}
