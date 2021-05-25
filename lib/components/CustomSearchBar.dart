import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String textA;
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key key}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 36,
          bottom: 8,
          left: 16,
          right: 16,
        ),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration (
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.16),
                spreadRadius: 5,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: TextField(
          onChanged: (text) {
            setState(() {
              textA = text;
            });
          },
          textInputAction: TextInputAction.send,
          decoration: InputDecoration (
            border: OutlineInputBorder (
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search, color: greenAccent),
            hintText: 'Search animals',
            suffixIcon: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => {print('pressed')},
              color: greenAccent,
            ),
            contentPadding: EdgeInsets.only(
              bottom: 40 / 2,  // HERE THE IMPORTANT PART
            )

          ),
        ),
      ),
    );
  }
}
