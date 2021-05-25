import 'package:flutter/material.dart';
import 'package:nicamal_app/components/CustomSearchBar.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../components/CustomProgressIndicator.dart';
import '../../components/CustomProgressIndicator.dart';
import '../../components/ListItem.dart';
import '../../models/viewModels/PublicationViewModel.dart';
import '../../models/viewModels/PublicationViewModel.dart';

class AdopList extends StatefulWidget {
  @override
  _AdopListState createState() => _AdopListState();
}

class _AdopListState extends State<AdopList> {
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  Services services = Services();
  int page;
  PaginationViewType paginationViewType;
  GlobalKey<PaginationViewState> key;
  String filter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = -1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
  }

  Future<List<PublicationsResponseForList>> fetchPublications(int offset) async {
    var page = (offset / 6).round() + 1;

    return await services.getPublications(page);
  }

  Future<List<PublicationsResponseForList>> fetchPublicationsWithFilter(int offset) async {
    var page = (offset / 6).round() + 1;

    return await services.getPublicationsWithFilters(page, filter);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover
            )
        ),
        child: Column (
          children: [
            Padding(
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
                    filter = text;
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
          ),
            Expanded (
              child: PaginationView<PublicationsResponseForList> (
                key: key,
                paginationViewType: paginationViewType,
                pullToRefresh: true,
                pageFetch: (filter == null) ? fetchPublications : fetchPublicationsWithFilter,
                itemBuilder: (BuildContext context, PublicationsResponseForList publication, int index) =>
                    ListItems(context, index, publication.image, publication.name, publication.gender, publication.user.province, publication.user.country),
                onError: (dynamic error) => Center (
                  child: Text(error.toString()),
                ),
                onEmpty: Center(
                  child: Text('Sorry! This is empty'),
                ),
                bottomLoader: Center(
                  child: CustomProgressIndicator(),
                ),
                initialLoader: Center(
                  child: CustomProgressIndicator(),
                ),
              ),
            )

          ],
        )
      ),
    );
  }
}
