import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var desc;
  var humidity;
  var windSpeed;
  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.weatherapi.com/v1/current.json?key=5c6812aee6754cca94c90805200712&q=Biratnagar");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['current']['temp_c'];
      this.desc = results['current']['condition']['text'];
      this.humidity = results['current']['humidity'];
      this.windSpeed = results['current']['wind_dir'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Serch location...",
                fillColor: Colors.black,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                HexColor("#f2709c"),
                HexColor("#ff9472"),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      "Biratnagar,Nepal",
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "°" : "Loading",
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      height: 10,
                      child: ListView(
                        children: [
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                            title: Text(
                              "Temprature",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              temp != null ? temp.toString() + "°" : "Loading",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.cloud),
                            title: Text(
                              "Weather",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              desc != null ? desc.toString() : "Loading",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.sun),
                            title: Text(
                              "Humidity",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              humidity != null
                                  ? humidity.toString()
                                  : "Loading",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.wind),
                            title: Text(
                              "WindSpeed",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              windSpeed != null
                                  ? windSpeed.toString()
                                  : "Loading",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
