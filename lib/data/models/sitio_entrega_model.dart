import '../../domain/entities/sitio_entrega_entity.dart';

class SitioEntregaModel extends SitioEntregaEntity {
  SitioEntregaModel({required String sitioEntregaId, String? nombre})
      : super(sitioEntregaId: sitioEntregaId, nombre: nombre ?? '');

  factory SitioEntregaModel.fromJson(Map<String, dynamic> json) =>
      SitioEntregaModel(
        sitioEntregaId: json["SitioEntregaId"],
        nombre: json["Nombre"],
      );

  @override
  Map<String, dynamic> toJson() =>
      {"SitioEntregaId": sitioEntregaId, "Nombre": nombre};
}
