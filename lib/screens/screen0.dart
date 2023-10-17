// ignore_for_file: unnecessary_new, prefer_const_constructors, dead_code, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, non_constant_identifier_names, unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'api_file.dart' as api_file;
import 'package:http/http.dart' as http;

class Screen0 extends StatefulWidget {
  const Screen0({super.key});

  @override
  State<Screen0> createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  void showstuff() async {
    Map<String, dynamic> data =
        await getWeather(api_file.appid, api_file.defaltcity);
    print(data.toString());
  }

  // Inside _Screen0State class
  String _cityEntered = ''; // Initializing with an empty string

  Future _gotoNextScreen(BuildContext context) async {
    Map? results = await Navigator.of(context).push<Map>(MaterialPageRoute(
      builder: (BuildContext context) {
        return new changecity();
      },
    ));

    if (results != null && results.containsKey("enter")) {
      setState(() {
        _cityEntered = results["enter"];
      });
    }
  }

// Rest of the _Screen0State class remains the same

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            " Weather app ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
          backgroundColor: Color(0xFF1D71F2),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _gotoNextScreen(context);
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage("images/background.png"),
                height: 1200,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                _cityEntered.isEmpty ? api_file.defaltcity : _cityEntered,
                style: TextStyle(
                    color: Color(0XFFFFCD00),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: UpdateTempWidget(
                  _cityEntered), // Pass _cityEntered to UpdateTempWidget
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getWeather(String appid, String city) async {
    String apiurl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appid";

    final response = await http.get(Uri.parse(apiurl));
    final data = json.decode(response.body);
    return data;
  }

  // Map<String, String> temperatureImages = {
  //   'Freezing': 'images/freezing.webp',
  //   'Cold': 'images/cold.png',
  //   'Moderate': 'images/madratrat.png',
  //   'Warm': 'images/sun1.png',
  //   'Hot': 'images/tempracher.png',
  // };

  Widget UpdateTempWidget(String city) {
    return FutureBuilder<Map<String, dynamic>>(
      future:
          getWeather(api_file.appid, city == null ? api_file.defaltcity : city),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator while waiting for data
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Return an error message if there's an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic>? content = snapshot.data;

          if (content != null &&
              content.containsKey("main") &&
              content.containsKey("weather")) {
            final weatherList = content["weather"];
            final mainWeather = content["main"];
            final temperature = mainWeather["temp"];
            final humidity = mainWeather["humidity"];
            final tempMin = mainWeather["temp_min"];
            final tempMax = mainWeather["temp_max"];
            final presser = mainWeather["pressure"];
            final sea_level = mainWeather["sea_level"];
            final ground_level = mainWeather["grnd_level"];

            final weatherEntry = weatherList[0];
            final shortDescription = weatherEntry["main"];
            final longDescription = weatherEntry["description"];
            final weatherIcon = weatherEntry["icon"];

            var temperatureCelsius = (temperature - 273.15).toStringAsFixed(2);
            var tempMinCelsius = (tempMin - 273.15).toStringAsFixed(2);
            var tempMaxCelsius = (tempMax - 273.15).toStringAsFixed(2);

            // final temperatureCelsius1 =
            double.tryParse((mainWeather["temp"] - 273.15).toString()) ?? 0.0;
            // String temperatureRange = '';
            // if (temperatureCelsius1 < 1.0) {
            //   temperatureRange = 'images/freezing.webp';
            // } else if (temperatureCelsius1 >= 1.0 &&
            //     temperatureCelsius1 < 10.1) {
            //   temperatureRange = 'images/cold.png';
            // } else if (temperatureCelsius1 >= 10.1 &&
            //     temperatureCelsius1 < 20.0) {
            //   temperatureRange = 'images/madratrat.png';
            // } else if (temperatureCelsius1 >= 20.0 &&
            //     temperatureCelsius1 < 30.2) {
            //   temperatureRange = 'images/sun1.png';
            // } else {
            //   temperatureRange = 'images/tempracher.png';
            // }
            // Get the image path based on the temperature range
            // String? temperatureImagePath = temperatureImages[temperatureRange];
            // Check if the image path is valid
            // if (temperatureImagePath == null) {
            //   temperatureImagePath =
            //       'images/default.png'; // Provide a default image path
            // }
            String getImageForShortDescription(String shortDescription) {
              switch (shortDescription) {
                case 'Freezing':
                  return 'images/freezing.webp';
                case 'Cold':
                  return 'images/cold.png';
                case 'Moderate':
                  return 'images/madratrat.png';
                case 'Warm':
                  return 'images/sun1.png';
                case 'Hot':
                  return 'images/tempracher.png';
                  case 'Rain':
                  return 'images/Rain1.png';
                default:
                  return 'images/defalte1.png';
              }
            }
            String getIconForWeatherIcon(String weatherIcon) {
  switch (weatherIcon) {
    case '01d':
      return 'images/sun1.png';
    case '01n':
      return 'images/night_moon.png';
    case '02d':
      return 'images/few_cloude.png';
    case '02n':
      return 'images/few_moon_cloude.png';
    case '03d':
      return 'images/scattered_clouds.jpg';
    case '03n':
      return 'images/scattered_clouds_night..jpg';
    // Add more cases for other weather icons as needed
    default:
      return 'images/defalte1.png';
  }
}

            return Container(
              margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Temperature: $temperatureCelsius°C",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    //        ListTile(
                    //   title: Container(
                    //     height: 100,
                    //     width: MediaQuery.of(context).size.width * 0.9,
                    //     decoration: BoxDecoration(
                    //         color: Color(0xFF19C3FB),
                    //         borderRadius: BorderRadius.all(Radius.circular(8))),
                    //     child: Center(
                    //       child: Text(
                    //        "Short Description: $shortDescription",
                    //         style: TextStyle(
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.bold,
                    //             color: Color.fromARGB(255, 255, 255, 255)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      
                      title: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "Short Description: $shortDescription",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                          getImageForShortDescription(shortDescription)),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "longDescription: ${longDescription.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                  ListTile(
  title: Container(
    height: 100,
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      color: Color(0xFF19C3FB),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: Center(
      child: weatherIcon != null
          ? Image.asset(getIconForWeatherIcon(weatherIcon))
          : Container(), // No image if the weatherIcon is null
    ),
  ),
),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Humidity: ${humidity.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Pressure: $presser Pa",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Sea Level: $sea_level Pa",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Ground Level: $ground_level Pa",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Min: $tempMinCelsius°C",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xFF19C3FB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Max: $tempMaxCelsius°C",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Handle the case where the data does not have the expected structure
            return Text('Invalid data format');
          }
        } else {
          // Return a default widget (you can decide what you want here)
          return Text('No data available');
        }
      },
    );
  }
}

class changecity extends StatelessWidget {
  var _cityfildcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Change City",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Color(0xFF1D71F2),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              decoration: InputDecoration(hintText: "Enter city"),
              controller: _cityfildcontroler,
              keyboardType: TextInputType.text,
            ),
          ),
          ListTile(
            title: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0XFFFFCD00),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    {"enter": _cityfildcontroler.text},
                  );
                },
                child: Text(
                  "Find Weather",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
