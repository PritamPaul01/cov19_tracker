// ignore_for_file: prefer_const_constructors, duplicate_ignore, unnecessary_import

// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cov19_tracker/maindata.dart';
import 'package:cov19_tracker/pages/countrydatapage.dart';
import 'package:cov19_tracker/widgets/panel1.dart';
import 'package:cov19_tracker/widgets/panel2.dart';
import 'package:cov19_tracker/widgets/panel3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map worldData = {"": ""};
  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'));
    setState(() {
      if (worldData.isNotEmpty) {
        worldData = jsonDecode(response.body);
      }
    });
  }

  late List countryData = [];
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://corona.lmao.ninja/v2/countries?sort=cases'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'COVID-19 LIVE TRACKER',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 110,
            padding: EdgeInsets.all(10),
            color: Colors.blue[100],
            child: Center(
              child: Text(
                MainData.quote,
                style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Worldwide',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountryDataPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: redOrange,
                        borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Regional',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          worldData == null || worldData.length == 0
              ? CircularProgressIndicator()
              : Panel1(
                  worldData: worldData,
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Top Affected Countries',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          countryData == null || countryData.length == 0
              ? Container()
              : Panel2(
                  countryData: countryData,
                ),
          Panel3(),
          SizedBox(height: 30),
          Center(
              child: Center(
            child: Text(
              "SPREAD FACTS, NOT FEAR.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green[800]),
            ),
          )),
          Center(
              child: Center(
            child: Text(
              "STAY AT HOME, SAVE LIVES",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green[800]),
            ),
          )),
          SizedBox(
            height: 45,
          ),
        ],
      )),
    );
  }
}
