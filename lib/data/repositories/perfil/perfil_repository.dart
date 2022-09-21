import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PerfilRepository {
  final _uri = Uri.parse('/ConsultarPerfil');

  final body = ''' 
  <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarPerfil xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>string</UsuarioId>
            <Nombre>string</Nombre>
            <Apellido>string</Apellido>
            <Direccion>string</Direccion>
            <TelefonoFijo>string</TelefonoFijo>
            <TelefonoMovil>string</TelefonoMovil>
            <Correo>string</Correo>
            <Contrasena>string</Contrasena>
            <FechaActivacion>dateTime</FechaActivacion>
            <FechaDesactivacion>dateTime</FechaDesactivacion>
            <FechaCambio>dateTime</FechaCambio>
            <Activo>boolean</Activo>
          </usuario>
          <rol>
            <RolId>int</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>int</PerfilId>
            <ConvocatoriaId>int</ConvocatoriaId>
            <Nombre>string</Nombre>
            <Abreviatura>string</Abreviatura>
            <MunicipioId>int</MunicipioId>
            <Direccion>string</Direccion>
            <Contacto>string</Contacto>
            <TelefonoFijo>string</TelefonoFijo>
            <TelefonoMovil>string</TelefonoMovil>
            <Correo>string</Correo>
            <TipoProyectoId>int</TipoProyectoId>
            <ProductoId>int</ProductoId>
            <ProductoAsociadoId>int</ProductoAsociadoId>
            <ValorTotalProyecto>decimal</ValorTotalProyecto>
            <IncentivoModular>decimal</IncentivoModular>
          </objeto>
        </ConsultarPerfil>
      </soap:Body>
    </soap:Envelope>
  ''';

  Future<dynamic> getPerfil() async {
    final resp = await http.post(_uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction":
              "http://alianzasproductivas.minagricultura.gov.co/ConsultarPerfil"
        },
        body: body);

    if (resp.statusCode == 200) {
      final parseXml = xml.XmlDocument.parse(resp.body).innerText;

      final decodedResp = json.decode(parseXml) as List;
    } else {
      log("Error!");
    }
  }
}
