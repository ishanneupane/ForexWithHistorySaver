import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../forex/model/forex_model.dart';
import '../dbhelper/sql_history.dart';
import '../provider/forex_calculator_provider.dart';

class ExchangeCalculator extends StatefulWidget {
  const ExchangeCalculator({Key? key}) : super(key: key);

  @override
  ExchangeCalculatorState createState() => ExchangeCalculatorState();
}

class ExchangeCalculatorState extends State<ExchangeCalculator> {
  TextEditingController converting = TextEditingController();

  // Country selectedCountry1 = Country.fromJson({});
  // Country selectedCountry2 = Country.fromJson({});
  // List<Country> countryList = [];
  //
  // int converted = 0;
  // Future<void> getCountryList() async {
  //   countryList = await Sql helper.getItems();
  //   selectedCountry1 = countryList[0];
  //   selectedCountry2 = countryList[01];
  //   setState(() {});
  // }
  //
  double inputOfUser() {
    String given = converting.text;
    try {
      return double.parse(given);
    } catch (e) {
      return 1; // or any default value
    }
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  getCountry() async {
    await context.read<ForexCalculatorState>().getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1922,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: Consumer<ForexCalculatorState>(
        builder: (_, state, child) {
          double finalOutput() {
            double output = state.calculation() * inputOfUser();
            return output;
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      DropdownButton<Country>(
                        value: state.selectedCountry1,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 10,
                          color: Colors.blue,
                        ),
                        onChanged: (Country? value1) {
                          if (value1 != null) {
                            setState(() {
                              state.selectedCountry1 = value1;
                            });
                          }
                        },
                        items: state.countryList
                            .map<DropdownMenuItem<Country>>((Country value) {
                          return DropdownMenuItem<Country>(
                            value: value,
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 10,
                                    child: CountryFlag.fromCountryCode(
                                      value.iso3.substring(0, 2),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(value.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const Divider(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: TextFormField(
                          controller: converting,
                          keyboardType: TextInputType.number,
                          // onChanged: (value) {
                          //  setState(() {});
                          // },
                          decoration: const InputDecoration(
                            hintText: '1',
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Column(
                    children: [
                      DropdownButton<Country>(
                        value: state.selectedCountry2,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 10,
                          color: Colors.blue,
                        ),
                        onChanged: (
                          Country? value2,
                        ) {
                          if (value2 != null) {
                            setState(() {
                              SqlHistory.createItem(
                                  inputOfUser(),
                                  finalOutput(),
                                  state.selectedCountry1.name,
                                  state.selectedCountry2.name);
                              state.selectedCountry2 = value2;
                              // state.calculation();
                            });
                          }
                        },
                        items: state.countryList
                            .map<DropdownMenuItem<Country>>((Country value) {
                          return DropdownMenuItem<Country>(
                            value: value,
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 10,
                                    child: CountryFlag.fromCountryCode(
                                      value.iso3.substring(0, 2),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(value.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const Divider(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Text(
                          (finalOutput()).toStringAsFixed(3),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade900),
                      ),
                      onPressed: () {
                        SqlHistory.createItem(
                            inputOfUser(),
                            finalOutput(),
                            state.selectedCountry1.name,
                            state.selectedCountry2.name);
                        setState(() {});
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
