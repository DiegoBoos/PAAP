class TipoIdentificacionEntity {
  TipoIdentificacionEntity(
      {required this.tipoIdentificacionId, required this.nombre});

  String tipoIdentificacionId;
  String nombre;

  Map<String, dynamic> toJson() => {
        "TipoIdentificacionId": tipoIdentificacionId,
        "Nombre": nombre,
      };
}
