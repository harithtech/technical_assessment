import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technical_assessment/ContactModel.dart';
import 'package:technical_assessment/contactList.dart';

class ContactList extends StatefulWidget {
  // const ContactList({ Key? key }) : super(key: key);
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  int listCount = 15;
  List mainContactList;

  void initState() {
    mainContactList = Contacts.getContactList();
    mainContactList.sort((b, a) => -a.date.compareTo(b.date));
    mainContactList = mainContactList.reversed.toList();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // for (int i = 0; i < 5; i++) {
    mainContactList.add(ContactModel(
      name: 'Remi',
      phone: '0122838638',
      date: DateTime.now().toString(),
    ));
    mainContactList.add(ContactModel(
      name: 'Dybala',
      phone: '0123678902',
      date: DateTime.now().toString(),
    ));
    mainContactList.add(ContactModel(
      name: 'Jackie',
      phone: '0124456723',
      date: DateTime.now().toString(),
    ));
    mainContactList.add(ContactModel(
      name: 'Sabok',
      phone: '0139998014',
      date: DateTime.now().toString(),
    ));
    mainContactList.add(ContactModel(
      name: 'Ozil',
      phone: '0190876114',
      date: DateTime.now().toString(),
    ));
    // }
    mainContactList.sort((b, a) => -a.date.compareTo(b.date));
    mainContactList = mainContactList.reversed.toList();
    listCount = listCount + 5;
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    listCount = mainContactList.length;
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (listCount == mainContactList.length) {
              body = Text("You have reached end of the list");
            } else if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("pulling up the list");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(
            child: ListTile(
              title: Text(
                mainContactList[i].name,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mainContactList[i].phone),
                  Text(mainContactList[i].date),
                ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.share),
                onTap: () {
                  share(mainContactList[i].name, mainContactList[i].phone);
                },
              ),
            ),
          ),
          itemExtent: 100.0,
          itemCount: listCount,
        ),
      ),
    );
  }

  Future<void> share(title, body) async {
    await FlutterShare.share(
      title: title,
      text: body,
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Contact',
    );
  }
}
