class EstadoVisitaEntity {
  EstadoVisitaEntity({
    required this.estadoVisitaId,
    required this.nombre,
    required this.descripcion,
  });

  String estadoVisitaId;
  String nombre;
  String descripcion;

  factory EstadoVisitaEntity.fromJson(Map<String, dynamic> json) =>
      EstadoVisitaEntity(
        estadoVisitaId: json["EstadoVisitaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "EstadoVisitaId": estadoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
