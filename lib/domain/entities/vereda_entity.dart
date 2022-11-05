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

  factory VeredaEntity.fromJson(Map<String, dynamic> json) => VeredaEntity(
        veredaId: json["VeredaId"],
        nombre: json["Nombre"],
        codigoDane: json["CodigoDane"],
        municipioId: json["MunicipioId"],
      );

  Map<String, dynamic> toJson() => {
        "VeredaId": veredaId,
        "Nombre": nombre,
        "CodigoDane": codigoDane,
        "MunicipioId": municipioId
      };
}
