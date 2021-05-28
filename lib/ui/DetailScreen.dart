import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Color greyBackground = Color.fromARGB(255, 245, 245, 245);
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: greyBackground,
      body: FutureBuilder<PublicationDetail>(
          future: services.getPublication(widget.id),
          builder: (BuildContext context, AsyncSnapshot<PublicationDetail> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget> [
                Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: 'image' + widget.id.toString(),
                          child: Container(
                              width: double.infinity,
                              height: height * 0.5,
                              decoration: BoxDecoration (
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data.image), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100)
                                  )
                              )
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.greenAccent,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    icon: Icon(Icons.arrow_back), color: Colors.red,),
                                )

                              ],
                            ),
                        )

                      ],
                    )

                  ],
                ),
              ];
            } else if(snapshot.hasError) {
              children = <Widget> [
                Center(
                  child: Text(snapshot.error.toString()),
                )
              ];
            } else {
              children = <Widget> [
                Center(
                  child: CircularProgressIndicator(),
                )
              ];
            }

            return Container(
              child: Column(
                children: children,
              ),
            );
          }
      ),
    );
  }
}
