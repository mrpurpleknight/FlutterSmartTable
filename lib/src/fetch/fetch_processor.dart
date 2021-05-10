

import 'strategy/fetch_strategy.dart';
import '../data/data_source_processor.dart';

abstract class FetchProcessor<T> {
    FetchStrategy<T> processDataSource(DataProcessor<T> dataSourceProcessor);
}
