import '../../data/communication/response_data.dart';
import '../../data/communication/request_data.dart';

abstract class FetchStrategy<T> {
  Future<ResponseData<T>> fetch(RequestData requestData);


}
