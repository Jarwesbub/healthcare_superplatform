import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.rows, required this.items});
  final Map<String, List<String>> items;
  final int rows;

  @override
  Widget build(BuildContext context) {
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
      children: List.generate(items.keys.length, (columnIndex) {
        // Columns.
        if (columnIndex == 0) {
          return TableRow(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),

              color: Colors.greenAccent,
            ),
            children: List.generate(rows, (rowIndex) {
              // Rows.
              String title = items.entries.first.value[rowIndex];
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
            String text = items.entries.elementAt(columnIndex).value[rowIndex];
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
