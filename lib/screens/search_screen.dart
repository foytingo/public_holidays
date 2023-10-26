import 'package:flutter/material.dart';
import 'package:public_holidays/views/alert_view.dart';
import 'package:public_holidays/views/loading_view.dart';
import 'package:public_holidays/models/country_model.dart';
import 'package:public_holidays/screens/holidays_screen.dart';
import 'package:public_holidays/services/network_service.dart';


final currentYear =  DateTime.now().year;
List<String> yearList = ["$currentYear", "${currentYear+1}","${currentYear+2}","${currentYear+3}","${currentYear+4}"];


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();


  void completeWithFail(error) {
    _controller.clear();
    LoadingView(context).stopLoading();
    showAdaptiveDialog(context: context, builder: ( (context) {
      return AlertView(message: error.toString());
    }));
  }

  String selectedYear = yearList.first;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 124.0, horizontal: 24),
          child: Column(
        
            children: [
            Image.asset("assets/search.png", width: 125,),
            const SizedBox(height: 24,),
            Text("Public Holiday App", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 24,),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: "Search a country",
                      isDense: false,
                      suffixIcon: IconButton(onPressed: () {
                        _controller.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      }, icon: const Icon(Icons.clear),),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                SizedBox(
                  width: 100,

                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    value: selectedYear,
                    onChanged: (newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    items: yearList.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                  ),
                ),

              ],
            ),

            GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                LoadingView(context).startLoading();
                await NetworkService().getCountry(_controller.value.text).then((countryData) async {
                    try {
                      List publicHolidays = await NetworkService().getPublicHolidays(countryData[0]["cca2"], selectedYear);
                      final country = Country.fromjson(countryData, publicHolidays);            
                      if (context.mounted) {
                        LoadingView(context).stopLoading();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HolidaysScreen(country: country)));
                      }
                    } catch (error) {
                      completeWithFail(error);
                    }
                    
                }).onError((error, stackTrace) {
                  completeWithFail(error);

                });
                

              },
              child: Container(
                margin: const EdgeInsets.only(top: 36),
                padding: const EdgeInsets.only(bottom: 2),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                   color: Theme.of(context).colorScheme.primary,
                   borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Text(
                  "Search", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                )
               
              ),
            )
          ]),
        ),
      ),
    );
  }
}