class Note {
  final int? id;
  final String name;
  final String description;
  final String createDate;
  final bool isDone;

  Note(
      {this.id,
      required this.name,
      required this.description,
      required this.createDate,
      required this.isDone});
}
