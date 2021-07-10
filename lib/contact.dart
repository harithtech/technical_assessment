import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactList extends StatefulWidget {
  // const ContactList({ Key? key }) : super(key: key);
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  int listCount = 2;
  List users = ['Syauqi', 'Amin', 'Luqman', 'Ikram', 'Azri', 'Abu', 'Salman'];
  List phones = [
    '0198765431',
    '0168975634',
    '019548790',
    '0198762811',
    '0198765431',
    '1234567890',
    '1234565171',
  ];
  List dates = [
    '2021-07-17 10:02:46.501222',
    '2021-02-10 10:01:46.501222',
    '2021-07-12 10:03:46.501222',
    '2021-07-10 10:11:46.506722',
    '2021-05-10 10:03:46.501222',
    '2021-07-11 10:03:46.501222',
    '2021-04-10 10:12:46.501222',
  ];

  void init() {}

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    users.add('Kamal');
    phones.add('999');
    dates.add(DateTime.now().toString());
    dates.sort((a, b) => a.compareTo(b));
    listCount = listCount + 1;
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    listCount = users.length;
    users.sort((a, b) => a.compareTo(b));

    items.add((items.length + 1).toString());
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
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
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
                users[i],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(phones[i]),
                  Text(dates[i]),
                ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.share),
                onTap: () {
                  share(users[i], phones[i]);
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
