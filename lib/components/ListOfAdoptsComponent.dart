import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/WarningEmptyMessagge.dart';
import 'package:nicamal_app/components/WarningMessagge.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:nicamal_app/ui/HomeScreen.dart';
import 'package:pagination_view/pagination_view.dart';

import 'CustomProgressIndicatorComponent.dart';
import 'CustomSearchBarComponent.dart';
import 'ListItemComponent.dart';

class ListOfAdoptsComponent extends StatefulWidget {
  const ListOfAdoptsComponent({Key key}) : super(key: key);

  @override
  _ListOfAdoptsComponentState createState() => _ListOfAdoptsComponentState();
}

class _ListOfAdoptsComponentState extends State<ListOfAdoptsComponent> {
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
      keyFilter = GlobalKey<PaginationViewState>();
    });
  }

  Future<List<PublicationsList>> fetchPublications(
      int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublications(page.toInt());
  }

  Future<List<PublicationsList>> fetchPublicationsWithFilter(
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
              visible: (filter == null || filter.isEmpty) ? false : true,
              child: Expanded(
                child: PaginationView<PublicationsList>(
                  key: keyFilter,
                  paginationViewType: paginationViewTypeFilter,
                  pullToRefresh: true,
                  pageFetch: fetchPublicationsWithFilter,
                  itemBuilder: (BuildContext context,
                          PublicationsList publication, int index) =>
                      ListItemsComponent(
                    id: publication.id,
                    name: publication.name,
                    image: publication.image,
                    gender: publication.gender,
                    species: publication.species,
                    address: publication.user.address,
                    province: publication.user.province,
                        isMissing: false,
                  ),
                  onError: (dynamic error) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      informationWarning(greenPrimary, error.toString()),
                      TextButton(
                        onPressed: () {
                          refresh();
                        },
                        child: Text('Reset',
                            style: TextStyle(
                                fontFamily: 'Quicksand', color: greenAccent)),
                      ),
                    ],
                  )),
                  onEmpty: Center(
                    child: informationEmpty(greenPrimary),
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
              visible: (filter == null || filter.isEmpty) ? true : false,
              child: Expanded(
                child: PaginationView<PublicationsList>(
                  key: key,
                  paginationViewType: paginationViewType,
                  pullToRefresh: true,
                  pageFetch: fetchPublications,
                  itemBuilder: (BuildContext context,
                          PublicationsList publication, int index) =>
                      ListItemsComponent(
                        id: publication.id,
                        name: publication.name,
                        image: publication.image,
                        gender: publication.gender,
                        species: publication.species,
                        address: publication.user.address,
                        province: publication.user.province,
                        isMissing: false,
                      ),
                  onError: (dynamic error) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      informationWarning(greenPrimary, error.toString()),
                      TextButton(
                        onPressed: () {
                          refresh();
                        },
                        child: Text('Reset',
                            style: TextStyle(
                                fontFamily: 'Quicksand', color: greenAccent)),
                      ),
                    ],
                  )),
                  onEmpty: Center(
                    child: informationEmpty(greenPrimary),
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
