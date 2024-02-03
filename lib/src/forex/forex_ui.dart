import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';

import '../calculator/ui/exchange_calculator_ui.dart';
import 'dbhelper/forex_api_state.dart';
import 'model/forex_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;
  getData() async {
    final state = Provider.of<CurrencyRateProvider>(context, listen: false);
    try {
      await state.fetchRates();
    } catch (e) {
      //  print("Error fetching rates: $e");
      await state.getDataFromDatabase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrencyRateProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Center(
          child: Text(
            'ELITE FOREX',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isLoading =
                    true; // Set loading to true to show the loading screen

                // Delay for 1 second and then call getData()
                Future.delayed(const Duration(seconds: 1), () {
                  getData();
                });
              });
            },
          ),
        ],
      ),

      // drawer: Drawer(
      //   backgroundColor: Colors.white70,
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 40),
      //       Container(
      //         height: 100,
      //         width: double.infinity,
      //         decoration: const BoxDecoration(
      //           borderRadius: BorderRadius.all(Radius.circular(80)),
      //           gradient: LinearGradient(
      //             colors: [Colors.blue, Colors.white],
      //             begin: Alignment.topRight,
      //             end: Alignment.bottomLeft,
      //           ),
      //         ),
      //         child: ElevatedButton(
      //           onPressed: () async {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const ExchangeCalculator(),
      //               ),
      //             );
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor:
      //                 Colors.transparent, // Set the button color to transparent
      //           ),
      //           child: const Text(
      //             'Forex Calculator',
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 25,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ExchangeCalculator(),
            // SizedBox(
            //   height: 10,
            // ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: Text(
                    "Updated at 2024/01/29",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Country",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Buy",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    textAlign: TextAlign.end,
                    "Sell",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.rates.length,
                itemBuilder: (context, index) {
                  Country country = state.rates[index];
                  double buy = double.parse(country.buy);
                  double sell = double.parse(country.sell);
                  double unit = double.parse(country.unit);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 10,
                              child: CountryFlag.fromCountryCode(
                                country.iso3.substring(0, 2),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              country.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Text(
                                (buy / unit).toString().length >= 5
                                    ? (buy / unit).toString().substring(0, 5)
                                    : (buy / unit).toString(),
                                style: const TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              (sell / unit).toString().length >= 5
                                  ? (sell / unit).toString().substring(0, 5)
                                  : (sell / unit).toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      //   title: Row(
                      //     //crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           CircleAvatar(
                      //             radius: 10,
                      //             child: CountryFlag.fromCountryCode(
                      //               country.iso3.substring(0, 2),
                      //             ),
                      //           ),
                      //           Text(
                      //             country.name,
                      //             style: TextStyle(
                      //               fontSize:
                      //                   MediaQuery.of(context).size.height * .013,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Text(
                      //         '${country.buy} ',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize:
                      //               MediaQuery.of(context).size.height * .015,
                      //         ),
                      //       ),
                      //       Text(
                      //         '${country.sell} ',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize:
                      //               MediaQuery.of(context).size.height * .015,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   // subtitle: Center(
                      //   //   child: Text(
                      //   //     "For every NEPALESE RS\t${country.unit}",
                      //   //     style: const TextStyle(
                      //   //       color: Colors.green,
                      //   //       fontSize: 14,
                      //   //     ),
                      //   //   ),
                      //   // ),
                      // ),
                      //
                      const Divider(), // Add a Divider between ListTiles
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
