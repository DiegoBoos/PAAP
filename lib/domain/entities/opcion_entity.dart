class OpcionEntity {
  OpcionEntity(
      {this.opcionId, this.nombre, this.calificacion, this.criterioId});

  String? opcionId;
  String? nombre;
  String? calificacion;
  String? criterioId;

  Map<String, dynamic> toJson() => {
        "OpcionId": opcionId,
        "Nombre": nombre,
        "Calificacion": calificacion,
        "CriterioId": criterioId
      };
}
