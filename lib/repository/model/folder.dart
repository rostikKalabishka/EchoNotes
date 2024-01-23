import 'package:equatable/equatable.dart';

class Folder extends Equatable {
  final int? id;
  final String imageFolder;
  final String name;
  final List<dynamic> listInFolder;
  final String? password;

  const Folder(
      {this.id,
      required this.imageFolder,
      required this.name,
      required this.listInFolder,
      this.password});

  @override
  List<Object?> get props => [id, imageFolder, name, listInFolder, password];
}
