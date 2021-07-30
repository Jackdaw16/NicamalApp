import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/warning_empty_messagge.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/viewModels/publication_view_model.dart';
import 'package:pagination_view/pagination_view.dart';

import 'custom_progress_indicator_component.dart';
import 'custom_search_bar_component.dart';
import 'list_item_component.dart';

class ListOfAdoptsComponent extends StatefulWidget {
  final String shelterId;
  final bool isUrgent;

  const ListOfAdoptsComponent({Key key, this.shelterId, this.isUrgent}) : super(key: key);

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

  Future<List<PublicationsList>> fetchPublications(int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublications(page.toInt());
  }

  Future<List<PublicationsList>> fetchPublicationsWithFilter(int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getPublicationsWithFilters(page.toInt(), filter);
  }

  Future<List<PublicationsList>> fetchShelterPublications(int offset) async {
    var page = (offset / 6).ceil() + 1;
    print(widget.shelterId);

    return await services.getShelterPublications(
        widget.shelterId, page.toInt());
  }

  Future<List<PublicationsList>> fetchShelterPublicationsUrgent(int offset) async {
    var page = (offset / 6).ceil() + 1;
    print(widget.shelterId);

    return await services.getShelterPublicationsUrgent(
        widget.shelterId, page.toInt());
  }

  Future<List<PublicationsList>> fetchShelterPublicationsFilters(int offset) async {
    var page = (offset / 6).ceil() + 1;
    print(widget.shelterId);

    return await services.getShelterPublicationsFilters(
        widget.shelterId, page.toInt(), filter);
  }

  Future<List<PublicationsList>> fetchShelterPublicationsUrgentFilters(int offset) async {
    var page = (offset / 6).ceil() + 1;
    print(widget.shelterId);

    return await services.getShelterPublicationsUrgentFilters(
        widget.shelterId, page.toInt(), filter);
  }

  bool safeArea (double padding) {
    if (padding > 0) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (widget.shelterId != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(),

                CustomSearchBarComponent(
                    filterChange: filterChange,
                    width: MediaQuery.of(context).size.width * 0.75,
                  horizontalPadding: 0,
                  verticalPadding: 8,
                  filter: false,
                ),
              ],
            ),

          if (widget.shelterId == null)
            CustomSearchBarComponent(
                filterChange: filterChange,
                width: double.infinity,
              horizontalPadding: 16,
              verticalPadding: 8,
              filter: true,
            ),

          if (widget.shelterId == null)
            Expanded(
                child: Column(
              children: [
                listOfAdopts(),
                listOfAdoptFilter(),
              ],
            )),
          if (widget.shelterId != null)
            Expanded(
                child: Column(
              children: [
                listOfAdoptsShelter(),
                listOfAdoptsShelterFilter(),
                Container(
                  height: 40,
                )
              ],
            ))
        ],
      ),
    );
  }

  Widget listOfAdopts() {
    return Visibility(
        visible: (filter == null || filter.isEmpty) ? true : false,
        child: Expanded(
          child: PaginationView<PublicationsList>(
            key: key,
            paginationViewType: paginationViewType,
            pullToRefresh: true,
            pageFetch: fetchPublications,
            itemBuilder: (BuildContext context, PublicationsList publication,
                    int index) =>
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
        ));
  }

  Widget listOfAdoptFilter() {
    return Visibility(
        visible: (filter == null || filter.isEmpty) ? false : true,
        child: Expanded(
          child: PaginationView<PublicationsList>(
            key: keyFilter,
            paginationViewType: paginationViewType,
            pullToRefresh: true,
            pageFetch: fetchPublicationsWithFilter,
            itemBuilder: (BuildContext context, PublicationsList publication,
                    int index) =>
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
        ));
  }

  Widget listOfAdoptsShelter() {
    return Visibility(
        visible: (filter == null || filter.isEmpty) ? true : false,
        child: Expanded(
          child: PaginationView<PublicationsList>(
            key: key,
            paginationViewType: paginationViewType,
            pullToRefresh: true,
            pageFetch: (widget.isUrgent) ? fetchShelterPublicationsUrgent : fetchShelterPublications,
            itemBuilder: (BuildContext context, PublicationsList publication,
                int index) =>
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
        ));
  }

  Widget listOfAdoptsShelterFilter() {
    return Visibility(
        visible: (filter == null || filter.isEmpty) ? false : true,
        child: Expanded(
          child: PaginationView<PublicationsList>(
            key: keyFilter,
            paginationViewType: paginationViewType,
            pullToRefresh: true,
            pageFetch: (widget.isUrgent) ? fetchShelterPublicationsUrgentFilters : fetchShelterPublicationsFilters,
            itemBuilder: (BuildContext context, PublicationsList publication,
                int index) =>
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
        ));
  }

  Widget backButton() {
    return SafeArea(
        top: safeArea(MediaQuery.of(context).viewPadding.top),
        bottom: safeArea(0),
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.16),
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ]),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromRGBO(
                  255, 255, 255, 1),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_back),
                  color: Colors.green),
            ),
          ),
        )
    );
  }
}
