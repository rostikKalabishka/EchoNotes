class Folder {
  final int? id;
  final String imageFolder;
  final String name;
  final List<dynamic> listInFolder;
  final String? password;

  Folder(
      {this.id,
      required this.imageFolder,
      required this.name,
      required this.listInFolder,
      this.password});
}
