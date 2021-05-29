import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:nicamal_app/ui/HomeScreen.dart';
import 'package:pagination_view/pagination_view.dart';

import 'CustomProgressIndicatorComponent.dart';
import 'CustomSearchBarComponent.dart';
import 'ListItemComponent.dart';

class ListOfAdopsComponent extends StatefulWidget {
  const ListOfAdopsComponent({Key key}) : super(key: key);

  @override
  _ListOfAdopsComponentState createState() => _ListOfAdopsComponentState();
}

class _ListOfAdopsComponentState extends State<ListOfAdopsComponent> {
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
          CustomSearchBarComponent(filterChange: filterChange),
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
                      ListItemsComponent(context, index, publication),
                  onError: (dynamic error) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          informationWarning(greenPrimary, error.toString()),
                          TextButton(
                            onPressed: () {
                              refresh();
                            },
                            child: Text('Reset', style: TextStyle(fontFamily: 'Quicksand', color: greenAccent)),
                          ),
                        ],
                      )),
                  onEmpty: Center(
                    child: informationEmpty(),
                  ),
                  bottomLoader: Center(
                    child: CustomProgressIndicatorComponent(),
                  ),
                  initialLoader: Center(
                    child: CustomProgressIndicatorComponent(),
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
                      ListItemsComponent(context, index, publication),
                  onError: (dynamic error) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      informationWarning(greenPrimary, error.toString()),
                      TextButton(
                        onPressed: () {
                          refresh();
                        },
                        child: Text('Reset', style: TextStyle(fontFamily: 'Quicksand', color: greenAccent)),
                      ),
                    ],
                  )),
                  onEmpty: Center(
                    child: informationEmpty(),
                  ),
                  bottomLoader: Center(
                    child: CustomProgressIndicatorComponent(),
                  ),
                  initialLoader: Center(
                    child: CustomProgressIndicatorComponent(),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

Widget informationWarning(Color greenPrimary, String textError) {
  return Column(
    children: [
      Icon(Icons.info_outline_rounded, color: greenPrimary, size: 60),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(
          textError,
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      )
    ],
  );
}

Widget informationEmpty() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.info_outline_rounded, color: greenPrimary, size: 60),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(
          'Sorry, we have not found what you are looking for',
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      )
    ],
  );
}
