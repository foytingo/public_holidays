import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:public_holidays/models/country_model.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key, required this.country});

  final Country country;
  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
   late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.country.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Flag"),
                    const SizedBox(height: 4,),
                    Container(
                      height: 78,
                      width: 124,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(widget.country.flagUrl)
                    )
                    
                  ],
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Official Name"),
                      const SizedBox(height: 4,),
                      Container(
                        height: 78,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text(widget.country.officialName, style: Theme.of(context).textTheme.bodyLarge,))
                        ),
                    ],
                  ),
                ),
              ],
            ), 
            
            const SizedBox(height: 12,),

            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Currency"),
                  const SizedBox(height: 4,),
                  Container(
                    height: 78,
                    width: 124,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.country.currencies.values.first["name"]),
                        Text(widget.country.currencies.keys.first)
                      ],
                    )
                  )

                ],
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Capital"),
                    const SizedBox(height: 4,),
                    Container(
                      height: 78,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(widget.country.capital),
                      )
                    )
              
                  ],
                ),
              ),
            ],),
            

            const SizedBox(height: 12,),
            const Text("Borders"),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.country.borders.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 72,
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.network(widget.country.borderFlags![widget.country.borders[index]]!, height: 25, width: 50, fit: BoxFit.scaleDown,),
                        Text(widget.country.borders[index])
                      ],
                    ),
                  );

              })

            ),
            const SizedBox(height: 12,),
            const Text("Map"),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 4, bottom: 48),
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target:  LatLng(widget.country.latlng["lat"]!, widget.country.latlng["lng"]!),
                    zoom: 5,
                  ),
                ),

              ),
            )
            
            ],),
      ),
      );

  }
}