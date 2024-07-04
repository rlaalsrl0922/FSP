import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Indicators extends StatefulWidget {
  Indicators({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    try {
      return _IndicatorsState();
    } catch (e) {
      throw Exception('Create failed, $e');
    }
  }
}

class _IndicatorsState extends State<Indicators> {
  @override
  void initState() {
    super.initState();
    downloadCSV();
  }

  Future<void> downloadCSV() async {
    final _url =
        "https://projects.fivethirtyeight.com/soccer-api/international/spi_global_rankings_intl.csv";
    try {
      var CSVRead = await http.read(Uri.parse(_url));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyDataTable(csvString: CSVRead)));
    } catch (e) {
      print('$e file download Fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}

class MyDataTable extends StatefulWidget {
  final csvString;
  MyDataTable({Key? key, @required this.csvString}) : super(key: key);
  @override
  _DataTableState createState() => _DataTableState();
}

class _DataTableState extends State<MyDataTable> {
  late List<String> CSVRows;
  late List<String> CSVHeadRow;

  @override
  void initState() {
    super.initState();
    List<String> CSVSplit = widget.csvString.split('\n');
    CSVHeadRow = CSVSplit[0].split(',');
    CSVSplit.removeAt(0);
    CSVRows = CSVSplit;
  }

  void _dataColumnSort(int columnIndex, bool ascending) {
    print('_dataColumnSort() $columnIndex, $ascending');
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumn = [];
    for (var i in CSVHeadRow) {
      if (i == 'rank') {
        dataColumn.add(DataColumn(
            label: Text(i),
            tooltip: i,
            numeric: true,
            onSort: _dataColumnSort));
      } else {
        dataColumn.add(DataColumn(label: Text(i), tooltip: i));
      }
    }
    return dataColumn;
  }

  List<DataRow> _getRows() {
    List<DataRow> dataRow = [];
    for (var i = 0; i < CSVRows.length - 1; i++) {
      var csvDataCells = CSVRows[i].split(',');
      List<DataCell> cells = [];
      for (var j = 0; j < csvDataCells.length; j++) {
        cells.add(DataCell(Text(csvDataCells[j])));
      }
      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }

  Widget _getDataTable() {
    return DataTable(
      horizontalMargin: 1.0,
      columnSpacing: 14.0,
      columns: _getColumns(),
      rows: _getRows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              child: Container(
                width: 400,
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: _getDataTable(),
                  ),
                ),
              ))
        ]));
  } /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      width: 412,
      height: 412,
    )));
  }*/
}
