class ActividadEconomicaEntity {
  ActividadEconomicaEntity({
    required this.actividadEconomicaId,
    required this.nombre,
    required this.descripcion,
  });

  String actividadEconomicaId;
  String nombre;
  String descripcion;

  factory ActividadEconomicaEntity.fromJson(Map<String, dynamic> json) =>
      ActividadEconomicaEntity(
        actividadEconomicaId: json["ActividadEconomicaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "ActividadEconomicaId": actividadEconomicaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
