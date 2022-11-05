class TipoIdentificacionEntity {
  TipoIdentificacionEntity(
      {required this.tipoIdentificacionId, required this.nombre});

  String tipoIdentificacionId;
  String nombre;

  factory TipoIdentificacionEntity.fromJson(Map<String, dynamic> json) =>
      TipoIdentificacionEntity(
        tipoIdentificacionId: json["TipoIdentificacionId"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "TipoIdentificacionId": tipoIdentificacionId,
        "Nombre": nombre,
      };
}
