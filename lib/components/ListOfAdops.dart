import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:pagination_view/pagination_view.dart';

import 'CustomProgressIndicator.dart';
import 'CustomSearchBar.dart';
import 'ListItem.dart';

class ListOfAdops extends StatefulWidget {
  const ListOfAdops({Key key}) : super(key: key);

  @override
  _ListOfAdopsState createState() => _ListOfAdopsState();
}

class _ListOfAdopsState extends State<ListOfAdops> {
  int page;
  String filter;
  Services services = Services();
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  PaginationViewType paginationViewType;
  PaginationViewType paginationViewTypeFilter;
  GlobalKey<PaginationViewState> key;
  GlobalKey<PaginationViewState> keyFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = -1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
  }

  void refresh() {
    setState(() {
      key = GlobalKey<PaginationViewState>();
      keyFilter = GlobalKey<PaginationViewState>();
    });
  }

  void filterChange(newString) {
    setState(() {
      filter = newString;
    });
  }

  Future<List<PublicationsResponseForList>> fetchPublications(
      int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublications(page.toInt());
  }

  Future<List<PublicationsResponseForList>> fetchPublicationsWithFilter(
      int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublicationsWithFilters(page.toInt(), filter);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomSearchBar(filterChange: filterChange),
          Visibility(
              visible: (filter == null || filter.isEmpty || filter.length > 3)
                  ? false
                  : true,
              child: Expanded(
                child: PaginationView<PublicationsResponseForList>(
                  key: keyFilter,
                  paginationViewType: paginationViewTypeFilter,
                  pullToRefresh: true,
                  pageFetch: fetchPublicationsWithFilter,
                  itemBuilder: (BuildContext context,
                          PublicationsResponseForList publication, int index) =>
                      ListItems(context, index, publication),
                  onError: (dynamic error) => Center(
                    child: MaterialButton(
                      onPressed: () {
                        refresh();
                      },
                      child: Text('Reset'),
                    ),
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
              )),
          Visibility(
              visible: (filter == null || filter.isEmpty || filter.length > 3)
                  ? true
                  : false,
              child: Expanded(
                child: PaginationView<PublicationsResponseForList>(
                  key: key,
                  paginationViewType: paginationViewType,
                  pullToRefresh: true,
                  pageFetch: fetchPublications,
                  itemBuilder: (BuildContext context,
                          PublicationsResponseForList publication, int index) =>
                      ListItems(context, index, publication),
                  onError: (dynamic error) => Center(
                    child: MaterialButton(
                      onPressed: () {
                        refresh();
                      },
                      child: Text('Reset'),
                    ),
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
              ))
        ],
      ),
    );
  }
}
