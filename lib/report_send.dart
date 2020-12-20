import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class ReportSend extends StatefulWidget {
  @override
  _ReportSendState createState() => _ReportSendState();
}

class _ReportSendState extends State<ReportSend> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Send Report"),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: ListView(
                children: <Widget>[
                  Container(
                    height: 500,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        
                        SizedBox(
                          height: 20.0,
                        ),
                        showImage(),
                        SizedBox(
                          height: 20.0,
                        ),
                        OutlineButton(
                          onPressed: chooseImage,
                          child: Text('Choose Image'),
                        ),
                       
                        Text(
                          status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Content',
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: DropdownSearch(
                      items: ["Banjir", "Kecelakaan", "Lampu Merah", "Sampah"],
                      label: "Category",
                      mode: Mode.DIALOG,
                      onChanged: print,
                      selectedItem: "Select Category",
                      validator: (String item) {
                        if (item == null)
                          return "Required field";
                        else if (item == "Brazil")
                          return "Invalid item";
                        else
                          return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            onPressed: () {
                              print("tes");
                            },
                            textColor: Colors.white,
                            color: Colors.green,
                            padding: EdgeInsets.all(13),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.green,
                                      child: Text(
                                        'Send Report',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                )))),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
