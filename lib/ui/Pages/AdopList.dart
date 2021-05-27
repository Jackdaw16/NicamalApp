import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nicamal_app/components/CustomSearchBar.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/ui/HomePage.dart';
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
  PaginationViewType paginationViewTypeFilter;
  GlobalKey<PaginationViewState> key;
  GlobalKey<PaginationViewState> keyFilter;
  String filter;

  void filterChange(newString) {
    setState(() {
      filter = newString;
    });
  }

  /*void refresh() {
    setState(() {
      key = GlobalKey<PaginationViewState>();
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = -1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
  }

  Future<List<PublicationsResponseForList>> fetchPublications(int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublications(page.toInt());
  }

  Future<List<PublicationsResponseForList>> fetchPublicationsWithFilter(int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublicationsWithFilters(page.toInt(), filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          CustomSearchBar(filterChange: filterChange),
          Visibility(
              visible: (filter == null || filter.isEmpty || filter.length > 3) ? false : true,
              child: TypeList(context, fetchPublications, fetchPublicationsWithFilter,paginationViewTypeFilter, keyFilter, filter)
          ),
          Visibility(
              visible: (filter == null || filter.isEmpty || filter.length > 3) ? true : false,
              child: TypeList(context, fetchPublications, fetchPublicationsWithFilter,paginationViewTypeFilter, keyFilter, filter)
          )

        ],
      )
    );
  }
}

Widget TypeList(BuildContext context, Future<List<PublicationsResponseForList>> fetch(int offset), Future<List<PublicationsResponseForList>> fetchFilter(int offset),PaginationViewType paginationViewType, GlobalKey<PaginationViewState> key, String filter) {
  if (filter != null){
    return Expanded (
      child: PaginationView<PublicationsResponseForList> (
        key: key,
        paginationViewType: paginationViewType,
        pullToRefresh: true,
        pageFetch: fetchFilter,
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
    );
  } else {
    return Expanded (
      child: PaginationView<PublicationsResponseForList> (
        key: key,
        paginationViewType: paginationViewType,
        pullToRefresh: true,
        pageFetch: fetch,
        itemBuilder: (BuildContext context, PublicationsResponseForList publication, int index) =>
            ListItems(context, index, publication.image, publication.name, publication.gender, publication.user.province, publication.user.country),
        onError: (dynamic error) => Center (
          child: MaterialButton(
            onPressed: () {
              print('hello');
            },
            child: Text('Reset'),
          ),
        ),
        onEmpty: Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomLoader: Center(
          child: CircularProgressIndicator(color: greenAccent),
        ),
        initialLoader: Center(
          child: CustomProgressIndicator(),
        ),
      ),
    );
  }
}


