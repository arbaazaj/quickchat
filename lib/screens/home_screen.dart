import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  var onlineStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> updateStatusToOnline() {

    final docID = users.id;

    return users
        .doc(docID)
        .update({'online': true})
        .then((value) {
      onlineStatus = 'Online';
      if (kDebugMode) {
        print('Status changed to Online!');
      }
    });
  }

  Future<void> updateStatusToOffline() {

    final docID = users.id;

    return users
        .doc(docID)
        .update({'online': false})
        .then((value) {
      onlineStatus = 'Offline';
      if (kDebugMode) {
        print('Status changed to Offline!');
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      updateStatusToOnline();
    } else {
      updateStatusToOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quick Chat'),
          centerTitle: true,
          elevation: 16.0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Request',
              ),
              Tab(
                text: 'Chat',
              ),
              Tab(
                text: 'Friends',
              ),
            ],
            unselectedLabelColor: Colors.white30,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection('Users').snapshots();
    return TabBarView(
      children: [
        const Text('data'),
        StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.asset('assets/default_avatar.png'),
                    ),
                    title: Text(data['fname']),
                    subtitle: onlineStatus == null
                        ? const Text('Null value')
                        : Text(onlineStatus),
                  );
                }).toList(),
              );
            }),
        const Text('data'),
      ],
    );
  }
}
