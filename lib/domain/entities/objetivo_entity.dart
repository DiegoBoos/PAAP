class ObjetivoEntity {
  ObjetivoEntity(
      {required this.objetivoId,
      required this.nombre,
      required this.fechaRegistro,
      required this.proyectoId,
      required this.proyecto});

  String objetivoId;
  String nombre;
  String fechaRegistro;
  String proyectoId;
  String proyecto;

  factory ObjetivoEntity.fromJson(Map<String, dynamic> json) => ObjetivoEntity(
      objetivoId: json["ObjetivoId"],
      nombre: json["Nombre"],
      fechaRegistro: json["FechaRegistro"],
      proyectoId: json["ProyectoId"],
      proyecto: json["Proyecto"]);

  Map<String, dynamic> toJson() => {
        "ObjetivoId": objetivoId,
        "Nombre": nombre,
        "FechaRegistro": fechaRegistro,
        "ProyectoId": proyectoId,
        "Proyecto": proyecto,
      };
}
