class ActividadEntity {
  ActividadEntity(
      {required this.actividadId,
      required this.nombre,
      required this.indicadorId,
      required this.indicador});

  String actividadId;
  String nombre;
  String indicadorId;
  String indicador;

  factory ActividadEntity.fromJson(Map<String, dynamic> json) =>
      ActividadEntity(
        actividadId: json["ActividadId"],
        nombre: json["Nombre"],
        indicadorId: json["IndicadorId"],
        indicador: json["Indicador"],
      );

  Map<String, dynamic> toJson() => {
        "ActividadId": actividadId,
        "Nombre": nombre,
        "IndicadorId": indicadorId,
        "Indicador": indicador,
      };
}
