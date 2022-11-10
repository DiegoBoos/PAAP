class OpcionEntity {
  OpcionEntity(
      {required this.opcionId,
      required this.nombre,
      required this.calificacion,
      required this.criterioId});

  String opcionId;
  String nombre;
  String calificacion;
  String criterioId;

  factory OpcionEntity.fromJson(Map<String, dynamic> json) => OpcionEntity(
        opcionId: json["OpcionId"],
        nombre: json["Nombre"],
        calificacion: json["Calificacion"],
        criterioId: json["CriterioId"],
      );

  Map<String, dynamic> toJson() => {
        "OpcionId": opcionId,
        "Nombre": nombre,
        "Calificacion": calificacion,
        "CriterioId": criterioId
      };
}
