class VeredaEntity {
  VeredaEntity(
      {required this.veredaId,
      required this.nombre,
      required this.codigoDane,
      required this.municipioId});

  String veredaId;
  String nombre;
  String codigoDane;
  String municipioId;

  Map<String, dynamic> toJson() => {
        "VeredaId": veredaId,
        "Nombre": nombre,
        "CodigoDane": codigoDane,
        "MunicipioId": municipioId
      };
}
