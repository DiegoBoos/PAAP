class ActividadEconomicaEntity {
  ActividadEconomicaEntity({
    required this.actividadEconomicaId,
    required this.nombre,
    required this.descripcion,
  });

  String actividadEconomicaId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "ActividadEconomicaId": actividadEconomicaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
