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

  Map<String, dynamic> toJson() => {
        "OpcionId": opcionId,
        "Nombre": nombre,
        "Calificacion": calificacion,
        "CriterioId": criterioId
      };
}
