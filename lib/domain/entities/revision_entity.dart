class RevisionEntity {
  RevisionEntity({this.revisionId, this.nombre});

  String? revisionId;
  String? nombre;

  Map<String, dynamic> toJson() => {"RevisionId": revisionId, "Nombre": nombre};
}
