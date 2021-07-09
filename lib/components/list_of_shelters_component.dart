import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/custom_progress_indicator_component.dart';
import 'package:nicamal_app/components/custom_search_bar_component.dart';
import 'package:nicamal_app/components/shelter_list_item_component.dart';
import 'package:nicamal_app/components/warning_empty_messagge.dart';
import 'package:nicamal_app/components/warning_messagge.dart';
import 'package:nicamal_app/io/services.dart';
import 'package:nicamal_app/models/viewModels/shelter_view_model.dart';
import 'package:pagination_view/pagination_view.dart';

class ListOfShelters extends StatefulWidget {
  const ListOfShelters({Key key}) : super(key: key);

  @override
  _ListOfSheltersState createState() => _ListOfSheltersState();
}

class _ListOfSheltersState extends State<ListOfShelters> {
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
    page = - 1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();

  }

  void refresh() {
    key = GlobalKey<PaginationViewState>();
    keyFilter = GlobalKey<PaginationViewState>();
  }

  void filterChange(newString) {
    setState(() {
      filter = newString;
      keyFilter = GlobalKey<PaginationViewState>();
    });
  }

  Future<List<UserShelterList>> fetchShelters(int offset) async {
    var page = (offset / 6).ceil() + 1;

    return await services.getShelters(page.toInt());
  }

  Future<List<UserShelterList>> fetchSheltersWithFilters(int offset) async{
    var page = (offset / 6).ceil() + 1;

    return await services.getSheltersWithFilters(page.toInt(), filter);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        CustomSearchBarComponent(filterChange: filterChange),
        Visibility(
            visible: (filter == null || filter.isEmpty) ? false : true,
            child: Expanded(
              child: PaginationView<UserShelterList>(
                key: keyFilter,
                paginationViewType: paginationViewType,
                pullToRefresh: true,
                pageFetch: fetchSheltersWithFilters,
                itemBuilder: (BuildContext context,
                    UserShelterList shelter, int index) =>
                    ShelterListItemComponent(
                      id: shelter.id,
                      name: shelter.name,
                      image: shelter.image,
                      address: shelter.address,
                      province: shelter.province,
                      publicationCount: shelter.publicationCount,
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
        Visibility (
          visible: (filter == null || filter.isEmpty) ? true : false,
          child: Expanded (
            child: PaginationView<UserShelterList> (
              key: key,
              paginationViewType: paginationViewType,
              pullToRefresh: true,
              pageFetch: fetchShelters,
              itemBuilder: (BuildContext context, UserShelterList shelter, int index) =>
                  ShelterListItemComponent(
                    id: shelter.id,
                    name: shelter.name,
                    image: shelter.image,
                    address: shelter.address,
                    province: shelter.province,
                    publicationCount: shelter.publicationCount,
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
          ),
        )
      ],
    ));
  }
}
