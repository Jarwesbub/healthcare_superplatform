import 'package:flutter/material.dart';

// Widget that shows table data similar to Excel.

/* Example code:
  tableData[0][0]  | tableData[0][1]  | tableData[0][2] // Column headers
  _____________________________________________________
  tableData[1][0]  | tableData[1][1]  | tableData[1][2] // Row 1
  tableData[2][0]  | tableData[1][1]  | tableData[1][2] // Row 2
  tableData[3][0]  | tableData[1][1]  | tableData[1][2] // Row 3
  

  Example output:
  "First column"  | "Second column" | "Third column" // Column headers
  ____________________________________________________
      "Row1"      |     "data1"     |    "data2"
      "Row2"      |     "data1"     |    "data2"
      "Row3"      |     "data1"     |    "data2"
*/

class CustomTableWidget extends StatelessWidget {
  const CustomTableWidget({
    super.key,
    required this.tableContent,
    required this.columnFlexValues,
  });
  final List<List<String>> tableContent; // Table columns and rows.
  final List<double> columnFlexValues; // Table column flex values.

  @override
  Widget build(BuildContext context) {
    final int rows = tableContent.first.length; // Number of rows in table.
    Map<int, FlexColumnWidth> flexColumnWidths = {};
    // Set custom column widths by list indexes.
    for (int i = 0; i < columnFlexValues.length; i++) {
      flexColumnWidths.addAll({i: FlexColumnWidth(columnFlexValues[i])});
    }

    return Table(
      border: TableBorder.all(
        width: 1,
        style: BorderStyle.solid,
        borderRadius: BorderRadius.circular(5),
        color: Colors.black45,
      ),
      columnWidths: flexColumnWidths,
      children: List.generate(tableContent.length, (columnIndex) {
        // Columns.
        if (columnIndex == 0) {
          return TableRow(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),

              color: Colors.greenAccent,
            ),
            children: List.generate(rows, (rowIndex) {
              // Rows.
              String title = tableContent.first[rowIndex];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            }),
          );
        }

        return TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          children: List.generate(rows, (rowIndex) {
            // Rows.
            String text = tableContent.elementAt(columnIndex)[rowIndex];
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            );
          }),
        );
      }),
    );
  }
}
