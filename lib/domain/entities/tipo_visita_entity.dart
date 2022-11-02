class TipoVisitaEntity {
  TipoVisitaEntity({
    required this.tipoVisitaId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoVisitaId;
  String nombre;
  String descripcion;

  factory TipoVisitaEntity.fromJson(Map<String, dynamic> json) =>
      TipoVisitaEntity(
        tipoVisitaId: json["TipoVisitaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoVisitaId": tipoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
