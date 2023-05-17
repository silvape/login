import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tela_login/routes/app_routes.dart';

class MyMapa extends StatefulWidget {
  const MyMapa({Key? key, required String title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyMapaState createState() => _MyMapaState();
}

class _MyMapaState extends State<MyMapa> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-5.088544046019581, -42.81123803149089);

  Set<Marker> _marcadores = {};
  _carregarMarcadores() {
    Set<Marker> marcadoresLocal = {};
    Marker marcadoIfpi = const Marker(
        markerId: MarkerId('IFPI'),
        position: LatLng(-5.088544046019581, -42.81123803149089),
        infoWindow: InfoWindow(title: 'IFPI CENTRAL'));
    Marker marcadoAtacadao = const Marker(
        markerId: MarkerId('ATACADÃO'),
        position: LatLng(-5.0684959, -42.8130301),
        infoWindow: InfoWindow(title: 'ATACADÃO'));
    Marker marcadoIfpiSul = const Marker(
        markerId: MarkerId('IFPISUl'),
        position: LatLng(-5.101723, -42.813114),
        infoWindow: InfoWindow(title: 'IFPI SUL'));
    Marker marcadoUfpi = const Marker(
        markerId: MarkerId('UFPI'),
        position: LatLng(-5.088544, -42.811238),
        infoWindow: InfoWindow(title: 'UFPI'));
    Marker marcadoUespi = const Marker(
        markerId: MarkerId('UESPI'),
        position: LatLng(-5.083885, -42.8091849),
        infoWindow: InfoWindow(title: 'UESPI'));
    Marker marcadoTHESP = const Marker(
        markerId: MarkerId('THE SHOP'),
        position: LatLng(-5.0896159, -42.8056897),
        infoWindow: InfoWindow(title: 'THE SHOP'));
    marcadoresLocal.add(marcadoIfpiSul);
    marcadoresLocal.add(marcadoIfpi);
    marcadoresLocal.add(marcadoAtacadao);
    marcadoresLocal.add(marcadoUfpi);
    marcadoresLocal.add(marcadoUespi);
    marcadoresLocal.add(marcadoTHESP);
    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  _localizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Localização: ' + position.toString());
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _carregarMarcadores();
    _localizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Mapa'),
            backgroundColor: Colors.blue,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.HOME);
                  },
                  icon: const Icon(Icons.arrow_back))
            ]),
        body: Container(
          child: GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _marcadores,
          ),
        ),
      ),
    );
  }
}
