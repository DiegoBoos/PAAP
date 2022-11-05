class AliadoEntity {
  AliadoEntity({
    required this.aliadoId,
    required this.nombre,
    required this.nombreContacto,
    required this.telefonoMovil,
    required this.correo,
    required this.ciudad,
    required this.aniosExperiencia,
    required this.estado,
  });

  String aliadoId;
  String nombre;
  String nombreContacto;
  String telefonoMovil;
  String correo;
  String ciudad;
  String aniosExperiencia;
  String estado;

  factory AliadoEntity.fromJson(Map<String, dynamic> json) => AliadoEntity(
        aliadoId: json["AliadoId"],
        nombre: json["Nombre"],
        nombreContacto: json["NombreContacto"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        ciudad: json["Ciudad"],
        aniosExperiencia: json["Años_x0020_Experiencia"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "AliadoId": aliadoId,
        "Nombre": nombre,
        "NombreContacto": nombreContacto,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "Ciudad": ciudad,
        "Años_x0020_Experiencia": aniosExperiencia,
        "Estado": estado,
      };
}
