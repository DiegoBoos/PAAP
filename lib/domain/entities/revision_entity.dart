class RevisionEntity {
  RevisionEntity({required this.revisionId, required this.nombre});

  String revisionId;
  String nombre;

  Map<String, dynamic> toJson() => {"RevisionId": revisionId, "Nombre": nombre};
}
