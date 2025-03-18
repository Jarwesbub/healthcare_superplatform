// Model for creating tables in eyesight page.

class TableModel {
  TableModel(this.titles, this.items);
  final List<String> titles;
  final Map<String, List<String>> items;
}
