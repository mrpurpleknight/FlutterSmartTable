library smart_table;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/search/no_search_strategy.dart';
import 'src/search/search_strategy.dart';
import 'src/data/communication/request_data.dart';
import 'src/data/communication/response_data.dart';
import 'src/data/smart_table_data_source_processor.dart';
import 'src/data/sources/data_source.dart';
import 'src/fetch/strategy/fetch_strategy.dart';
import 'src/smart_table_theme.dart';
import 'src/table_structure/header.dart';
import 'src/table_structure/headers.dart';
import 'src/table_structure/rows.dart';
import 'src/table_structure/smart_table_source.dart';
import 'src/widgets/search_bar.dart';

export 'src/smart_table_theme.dart';
export 'src/cell_content_selector.dart';
export 'src/response_formats/response_format.dart';
export 'src/data/sources/local_source.dart';
export 'src/data/sources/http_source.dart';
export 'src/table_structure/header.dart';
export 'src/table_structure/headers.dart';
export 'src/query_parameters/query_parameters.dart';
export 'src/search/no_search_strategy.dart';
export 'src/search/simple_search_strategy.dart';

// ignore: must_be_immutable
class SmartTable<T> extends StatelessWidget {
  //// NOT CONFIGURABLE ////
  FetchStrategy<T> _fetchStrategy;
  RequestData _requestData;

  /////////////////////////

  //// CONFIGURABLE ////
  final Headers _headers;
  final bool _searchEnabled;
  final Function(T) _callback;
  final Function(T, Header) _getCellContent;
  final SearchStrategy<T> _searchStrategy;
  //final SmartTableTheme _smartTableTheme;
  final bool _paginationEnabled;
  final List<int> _rowsPerPage;

  //////////////////////

  SmartTable({
    @required DataSource<T> dataSource,
    @required Headers headers,
    @required Function(T) callback,
    @required Function(T, Header) getCellContent,
    @required SearchStrategy<T> searchStrategy,
    //SmartTableTheme smartTableTheme,
    bool paginationEnabled = false,
    List<int> rowsPerPage = const [5, 10, 25, 50],
  })  : _headers = headers,
        _searchEnabled = (searchStrategy is NoSearchStrategy) ? false : true,
        _callback = callback,
        _getCellContent = getCellContent,
        //_smartTableTheme = smartTableTheme,
        _searchStrategy = searchStrategy,
        _paginationEnabled = paginationEnabled,
        _rowsPerPage = rowsPerPage {
    _requestData = RequestData(
      pageElements: 10,
    );
    _fetchStrategy = _getFetchStrategy(dataSource);
  }

  FetchStrategy<T> _getFetchStrategy(DataSource<T> dataSource) {
    return dataSource.processDataSource(
      SmartTableDataProcessor(
        requestData: _requestData,
      ),
    );
  }

  Widget _buildPaginatedSmartTable(BuildContext context,
      RequestData requestData, Future<ResponseData<T>> responseFuture) {
    return FutureBuilder<ResponseData<T>>(
        future: responseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<T> toDisplay = _searchStrategy
                .getSearchFunction()
                .call(requestData.searchString, snapshot.data.elementsList);
            return PaginatedDataTable(
              sortColumnIndex: _requestData.sortColumnIndex,
              sortAscending: _requestData.sortAscending,
              // dataRowColor: _smartTableTheme.rowColor,
              // dataTextStyle: _smartTableTheme.rowsTextStyle,
              // headingRowColor: _smartTableTheme.headingColor,
              // headingTextStyle: _smartTableTheme.headingTextStyle,
              availableRowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) {
                requestData.pageElements = value;
              },
              rowsPerPage: _requestData.pageElements,
              columns: _headers.getDataColumns(_requestData, snapshot.data),
              source: SmartTableSource(
                  elementsList: toDisplay,
                  headers: _headers,
                  getCellContent: _getCellContent),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.red,
              child: Center(),
            );
          } else {
            return Center();
          }
        });
  }

  Widget _buildSmartTable(BuildContext context, RequestData requestData,
      Future<ResponseData<T>> responseFuture) {
    return FutureBuilder<ResponseData<T>>(
      future: responseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<T> toDisplay = _searchStrategy
              .getSearchFunction()
              .call(requestData.searchString, snapshot.data.elementsList);
          return DataTable(
            // dataRowColor: _smartTableTheme.rowColor,
            // dataTextStyle: _smartTableTheme.rowsTextStyle,
            // headingRowColor: _smartTableTheme.headingColor,
            // headingTextStyle: _smartTableTheme.headingTextStyle,
            sortColumnIndex: requestData.sortColumnIndex,
            sortAscending: requestData.sortAscending,
            columns: _headers.getDataColumns(requestData, snapshot.data),
            rows: Rows<T>(
                    list: toDisplay,
                    getCellContent: _getCellContent,
                    headers: _headers)
                .getDataRows(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center();
        } else {
          return Center();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _requestData,
      child: Consumer<RequestData>(
        builder: (context, requestData, child) {
          Future<ResponseData<T>> responseFuture =
              _fetchStrategy.fetch(requestData);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (_searchEnabled) ? child : Center(),
              (_paginationEnabled)
                  ? _buildPaginatedSmartTable(
                      context, requestData, responseFuture)
                  : _buildSmartTable(context, requestData, responseFuture),
            ],
          );
        },
        child: SearchBar(),
      ),
    );
  }

  Headers get headers => _headers;

  bool get searchEnabled => _searchEnabled;

  Function get callback => _callback;
}
