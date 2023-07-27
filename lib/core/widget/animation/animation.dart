import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Candel extends StatelessWidget {
  const Candel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  DataTable(
                    columns: buildDataTableColumns(),
                    rows: buildDataTableRows(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

List<DataColumn> buildDataTableColumns() {
  List<DataColumn> columns = [];
  columns.add(
    DataColumn(
      label: Text('Date'),
    ),
  );
  columns.add(
    DataColumn(
      label: Text('Day'),
    ),
  );
  return columns;
}

List<DataRow> buildDataTableRows() {
  List<DataRow> rows = [];
  DateTime now = DateTime.now();
  int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

  for (int i = 1; i <= daysInMonth; i++) {
    DateTime date = DateTime(now.year, now.month, i);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    rows.add(
      DataRow(
        cells: [
          DataCell(Text(formattedDate)),
          DataCell(Text(DateFormat('EEEE').format(date))),
        ],
      ),
    );
  }

  return rows;
}
