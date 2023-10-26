import 'package:flutter/material.dart';
import 'package:public_holidays/models/country_model.dart';
import 'package:public_holidays/screens/country_screen.dart';
import 'package:public_holidays/views/loading_view.dart';
import 'package:public_holidays/services/network_service.dart';
import "package:intl/intl.dart";
class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({super.key, required this.country});

  final Country country;



  @override
  State<HolidaysScreen> createState() => HolidaysScreenState();
}

class HolidaysScreenState extends State<HolidaysScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Public Holidays"),),
      body: 
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text("Country Details",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),),
            ),
            GestureDetector(
              onTap: () async {
                LoadingView(context).startLoading();
                var borderFlags = await NetworkService().getBorderFlags(widget.country.borders);
                widget.country.borderFlags = borderFlags;
               
                if (context.mounted) {
                  LoadingView(context).stopLoading();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryScreen(country: widget.country)));
                }
              },

              child: Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                  
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(widget.country.name, 
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right,color: Colors.white,)
                  ]
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Holidays in ${DateFormat("y").format(widget.country.holidays[0].date)}",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,              
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Divider(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                  itemCount: widget.country.holidays.length,
                  itemBuilder: (context,index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedBox(
                            width: 200,
                            child: Text(widget.country.holidays[index].name,style: Theme.of(context).textTheme.bodyMedium,maxLines: 2,)
                          ),
                           SizedBox(
                            width: 200,
                            child: Text(widget.country.holidays[index].localName, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,)
                          ),

                          
                        ],),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                          Text(DateFormat("yMMMd").format(widget.country.holidays[index].date),style: Theme.of(context).textTheme.bodyMedium,),
                          Text(DateFormat("EEEE").format(widget.country.holidays[index].date), style: Theme.of(context).textTheme.bodySmall,)
                        ],),
                        
                      ]),
                      
                    );

                }),
            
              ),
            )
          ],
        ),
      ),

    );
  }
}