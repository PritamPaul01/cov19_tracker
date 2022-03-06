import 'package:cov19_tracker/pages/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryDataPage extends StatefulWidget {
  @override
  State<CountryDataPage> createState() => _CountryDataPageState();
}

class _CountryDataPageState extends State<CountryDataPage> {
  late List countryData = [];
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://corona.lmao.ninja/v2/countries?sort=cases'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchBar(countryData));
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400]!,
                          blurRadius: 10,
                          offset: Offset(0, 10)),
                    ]),
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                countryData[index]['country'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 55,
                                width: 65,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFIRMED:  ' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVE:  ' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'RECOVERED:  ' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DEATHS:  ' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
