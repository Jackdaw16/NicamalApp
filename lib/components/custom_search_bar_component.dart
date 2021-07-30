import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSearchBarComponent extends StatefulWidget {
  final filterChange;
  final double width;
  final double verticalPadding;
  final double horizontalPadding;
  final bool filter;

  const CustomSearchBarComponent({Key key, this.filterChange, this.width, this.verticalPadding, this.horizontalPadding, this.filter}) : super(key: key);

  @override
  _CustomSearchBarComponentState createState() => _CustomSearchBarComponentState();
}

class _CustomSearchBarComponentState extends State<CustomSearchBarComponent> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  String textFilter;

  bool safeArea (double padding) {
    if (padding > 0) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding.top;
    return SafeArea(
      top: safeArea(padding),
      bottom: safeArea(0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
        child: Container(
          width: widget.width,
          height: 40,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.16),
              spreadRadius: 5,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ]),
          child: TextField(
            onChanged: (text) => {
              setState(() {
                textFilter = text;
                widget.filterChange(textFilter);
              })
            },
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: greenAccent),
                hintText: 'Search animals',
                suffixIcon: (widget.filter) ? IconButton(
                icon: Icon(Icons.filter_list),
            onPressed: () => {print('pressed')},
            color: greenAccent,
            splashRadius: 10,
          ) : null,
            contentPadding: EdgeInsets.only(
              bottom: 40 / 2,
            )),
          ),
        ),
      ),
    );
  }
}
