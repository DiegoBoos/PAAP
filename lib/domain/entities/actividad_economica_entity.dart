class ActividadEconomicaEntity {
  ActividadEconomicaEntity({
    this.actividadEconomicaId,
    this.nombre,
    this.descripcion,
  });

  String? actividadEconomicaId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "ActividadEconomicaId": actividadEconomicaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
