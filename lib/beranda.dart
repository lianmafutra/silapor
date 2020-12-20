import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silapor/report_detail.dart';
import 'package:silapor/report_send.dart';
import 'dart:async';
import 'dart:convert';
import 'model/reportmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => new _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final String sUrl = "http://sisamsul.jambikota.go.id/flutter/";
  List<ReportModel> listReport;

  @override
  void initState() {
    super.initState();
  }

  Future<List<ReportModel>> _fetchData() async {
    var params = "allReport.php";
    try {
      var jsonResponse = await http.get(sUrl + params);
      if (jsonResponse.statusCode == 200) {
        final jsonItems =
            json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

        listReport = jsonItems.map<ReportModel>((json) {
          return ReportModel.fromJson(json);
        }).toList();
      }
    } catch (e) {}
    return listReport;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listReport) {
      setState(() => listReport = _listReport);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text('Beranda-Silapor'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show Snackbar',
              onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<ReportModel>>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return Container(
              margin: EdgeInsets.only(bottom: 0.0),
              child: ListView(
                padding: EdgeInsets.only(bottom: 160.0),
                children: snapshot.data
                    .map(
                      (_data) => Column(children: <Widget>[
                        Card(
                            child: new InkWell(
                                onTap: () {
                                  // Fluttertoast.showToast(
                                  //     msg: "judul laopran "+_data.title,
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportDetail(
                                              title: _data.title.toString(),
                                              content: _data.content.toString(),
                                              createdAt:
                                                  _data.createdAt.toString(),
                                              image: _data.image.toString())));
                                },
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.perm_media, size: 50),
                                      title: Text(_data.title),
                                      subtitle: Text(_data.category +
                                          ' / ' +
                                          _data.createdAt),
                                    ),
                                  ],
                                ))),
                      ]),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
            Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ReportSend();
                          }));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
