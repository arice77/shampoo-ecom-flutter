import 'package:ecom/services/firebase_firestore.dart';
import 'package:flutter/material.dart';

import 'homw_scree.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  double _total = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: BottomSheet(
            enableDrag: false,
            builder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text('\$99.9'),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(onPressed: () {}, child: Text('Buy now'))
                  ],
                ),
              );
            },
            onClosing: () {}),
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text('Home Screen'),
                  trailing: Icon(Icons.home),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeNmae),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text('My Orders'),
                  trailing: Icon(Icons.new_releases),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName),
                ),
              ],
            )),
        appBar: AppBar(
          title: Text('Orders'),
          backgroundColor: Colors.grey[200],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirestoreService().getOrder(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  if (snapshot.data!.docs.length == 0) {
                    return Center(
                      child: Text(
                        "You haven't placed any order yet",
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  return Container(
                    height: snapshot.data!.docs.length * 60,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]['Product']),
                          subtitle: Text(
                              'Quantity: ${snapshot.data!.docs[index]['Quantity']}'),
                          trailing: Image.network(
                              'https://images.unsplash.com/photo-1526947425960-945c6e72858f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoYW1wb298ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60'),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
