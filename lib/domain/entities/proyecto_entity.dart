class ProyectoEntity {
  ProyectoEntity(
      {required this.proyectoId,
      required this.nombre,
      required this.objetivo,
      required this.fechaInicial,
      required this.fechaFinal,
      required this.fechaRegistro,
      required this.yearInicial,
      required this.yearFinal});

  String proyectoId;
  String nombre;
  String objetivo;
  String fechaInicial;
  String fechaFinal;
  String fechaRegistro;
  String yearInicial;
  String yearFinal;

  factory ProyectoEntity.fromJson(Map<String, dynamic> json) => ProyectoEntity(
      proyectoId: json["ProyectoId"],
      nombre: json["Nombre"],
      objetivo: json["Objetivo"],
      fechaInicial: json["FechaInicial"],
      fechaFinal: json["FechaFinal"],
      fechaRegistro: json["FechaRegistro"],
      yearInicial: json["YearInicial"],
      yearFinal: json["YearFinal"]);

  Map<String, dynamic> toJson() => {
        "ProyectoId": proyectoId,
        "Nombre": nombre,
        "Objetivo": objetivo,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "FechaRegistro": fechaRegistro,
        "YearInicial": yearInicial,
        "YearFinal": yearFinal
      };
}
