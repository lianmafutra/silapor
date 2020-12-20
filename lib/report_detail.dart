import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class ReportDetail extends StatefulWidget {
  final String title, content, createdAt, image;
// constructor

  const ReportDetail(
      {Key key, this.title, this.content, this.createdAt, this.image})
      : super(key: key);

  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  bool showImageWidget = false;

  @override
  void initState() {
    super.initState();
    var _image = NetworkImage(widget.image);

    _image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          setState(() {
             print('Networkimage is fully loaded and saved');
          showImageWidget = true;
          });
         
          // do something
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Report Detail"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        
        body: Container(
           padding: EdgeInsets.all(20),
          child: Column(
            
             mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
           Flexible(child: ListView(
             children: <Widget>[
                 Container(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                 Container(
                  child: Text("Tanggal Lapor : " + widget.createdAt,
                      style: TextStyle(fontSize: 14)),
                ),
                Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Material(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailScreen(img_url: widget.image);
                          }));
                        },
                        child: Container(
                          // child:  Image.network(widget.image,fit: BoxFit.fill ),
                          child: showImageWidget
                              ? Image.network(
                                  widget.image,
                                  width: MediaQuery.of(context).size.width,
                                  height: 400.0,
                                  fit: BoxFit.fill,
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400.0,
                                  child: Shimmer.fromColors(
                                    child: Card(
                                      color: Colors.grey,
                                    ),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    direction: ShimmerDirection.ltr,
                                  )),
                        ),
                      ))),
                      Container(
                        padding: EdgeInsets.only(top: 26),
                        child: Text(widget.content,
                            style: TextStyle(fontSize: 16)))
             ],
           ))
           
            
          ],),
          
        //   padding: EdgeInsets.all(20),
          
          
        //   child: 
          
          
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Flexible(
        //           child: ListView(children: <Widget>[
        //         Flexible(
        //             child: Container(
        //           padding: EdgeInsets.only(bottom: 6),
        //           child: Text(widget.title,
        //               style:
        //                   TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        //         )),
        //         Flexible(
        //             child: Container(
        //           child: Text("Tanggal Lapor : " + widget.createdAt,
        //               style: TextStyle(fontSize: 14)),
        //         )),
        //         Flexible(
        //           child: Container(
        //               padding: EdgeInsets.only(top: 20),
        //               child: Material(
        //                   child: InkWell(
        //                 onTap: () {
        //                   Navigator.push(context,
        //                       MaterialPageRoute(builder: (_) {
        //                     return DetailScreen(img_url: widget.image);
        //                   }));
        //                 },
        //                 child: Container(
        //                   // child:  Image.network(widget.image,fit: BoxFit.fill ),
        //                   child: showImageWidget
        //                       ? Image.network(
        //                           widget.image,
        //                           width: MediaQuery.of(context).size.width,
        //                           height: 400.0,
        //                           fit: BoxFit.fill,
        //                         )
        //                       : SizedBox(
        //                           width: MediaQuery.of(context).size.width,
        //                           height: 400.0,
        //                           child: Shimmer.fromColors(
        //                             child: Card(
        //                               color: Colors.grey,
        //                             ),
        //                             baseColor: Colors.grey[300],
        //                             highlightColor: Colors.grey[100],
        //                             direction: ShimmerDirection.ltr,
        //                           )),
        //                 ),
        //               ))),
        //         ),
        //         Flexible(
        //             child: Container(
        //                 padding: EdgeInsets.only(top: 26),
        //                 child: Text(widget.content,
        //                     style: TextStyle(fontSize: 16)))),
        //       ]))
        //     ],
        //   ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String img_url;
  DetailScreen({Key key, this.img_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(img_url),
          ),
        ),
        // onTap: () {
        //   Navigator.pop(context);
        // },
      ),
    );
  }
}
