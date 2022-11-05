class RevisionEntity {
  RevisionEntity({required this.revisionId, required this.nombre});

  String revisionId;
  String nombre;

  factory RevisionEntity.fromJson(Map<String, dynamic> json) =>
      RevisionEntity(revisionId: json["RevisionId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() => {"RevisionId": revisionId, "Nombre": nombre};
}
