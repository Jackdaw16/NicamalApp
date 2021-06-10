import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/CustomProgressIndicatorComponent.dart';
import 'package:nicamal_app/components/ListItemComponent.dart';
import 'package:nicamal_app/components/WarningEmptyMessagge.dart';
import 'package:nicamal_app/components/WarningMessagge.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/viewModels/DisappearanceViewModel.dart';
import 'package:pagination_view/pagination_view.dart';

class ListDisappearancesComponent extends StatefulWidget {
  const ListDisappearancesComponent({Key key}) : super(key: key);

  @override
  _ListDisappearancesComponentState createState() => _ListDisappearancesComponentState();
}

class _ListDisappearancesComponentState extends State<ListDisappearancesComponent> {
  int page;
  Services services = Services();
  final Color greenPrimary = Color.fromARGB(255, 105, 198, 133);
  final Color greenAccent = Color.fromARGB(255, 24, 157, 139);
  PaginationViewType paginationViewTypeDisappearances;
  GlobalKey<PaginationViewState> keyDisappearances;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = -1;
    paginationViewTypeDisappearances = PaginationViewType.listView;
    keyDisappearances = GlobalKey<PaginationViewState>();
  }

  void refresh() {
    setState(() {
      keyDisappearances = GlobalKey<PaginationViewState>();
    });
  }

  Future<List<DisappearanceListResponse>> fetchPublications(
      int offset) async {
    print(offset.toString());
    var page = (offset / 6).ceil() + 1;
    print(page);

    return await services.getDisappearances(page.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
        Expanded(
        child: PaginationView<DisappearanceListResponse>(
          key: keyDisappearances,
          paginationViewType: paginationViewTypeDisappearances,
          pullToRefresh: true,
          pageFetch: fetchPublications,
          itemBuilder: (BuildContext context,
              DisappearanceListResponse publication, int index) =>
              ListItemsComponent(
                id: publication.id,
                name: publication.name,
                image: publication.image,
                province: publication.province,
                description: publication.description,
                isMissing: true,
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
                    child: Text('Reset', style: TextStyle(fontFamily: 'Quicksand', color: greenAccent)),
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
    )
          ],
        )
    );
  }
}
