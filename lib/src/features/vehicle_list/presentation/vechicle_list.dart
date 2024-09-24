import 'package:flutter/material.dart';

import '../../../widgets/atoms/vehicel_card.dart';
import '../modal/vehilce_list_response.dart';

class VehicleList extends StatefulWidget {
  static const String routeName = "/";
  final VehicleResponseData vehicleResponseData;

  const VehicleList({super.key, required this.vehicleResponseData});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  List<Vehicle> vehicleList = [];

  @override
  void initState() {
    vehicleList = widget.vehicleResponseData.data.vehicles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: vehicleList.length,
        itemBuilder: (context, index) {
          return VehicleCard(vehicle: vehicleList[index]);
        },
      ),
    );
  }
}
