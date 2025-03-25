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
  const CustomTableWidget({super.key, required this.items});
  final List<List<String>> items;

  @override
  Widget build(BuildContext context) {
    final int rows = items.first.length; // Number of rows in table.
    return Table(
      border: TableBorder.all(
        width: 1,
        style: BorderStyle.solid,
        borderRadius: BorderRadius.circular(5),
        color: Colors.black45,
      ),
      columnWidths:
          rows > 2
              ? const {0: FlexColumnWidth(2)}
              : const {0: FlexColumnWidth()},
      children: List.generate(items.length, (columnIndex) {
        // Columns.
        if (columnIndex == 0) {
          return TableRow(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),

              color: Colors.greenAccent,
            ),
            children: List.generate(rows, (rowIndex) {
              // Rows.
              String title = items.first[rowIndex];
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
            String text = items.elementAt(columnIndex)[rowIndex];
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
