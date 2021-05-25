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
  Services services = Services();
  int page;
  PaginationViewType paginationViewType;
  GlobalKey<PaginationViewState> key;

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
            CustomSearchBar(),
            Expanded (
              child: PaginationView<PublicationsResponseForList> (
                key: key,
                paginationViewType: paginationViewType,
                pullToRefresh: true,
                pageFetch: fetchPublications,
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
