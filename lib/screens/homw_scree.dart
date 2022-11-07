import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/screens/orders_screen.dart';
import 'package:ecom/services/firebase_firestore.dart';
import 'package:ecom/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeNmae = '/home-scren';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.grey[200],
          title: const Center(
            child: Text(
              'Search Product',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 16),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(220, 255, 255, 255),
                          borderRadius: BorderRadius.circular(8)),
                      child: const ListTile(
                        title: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search', border: InputBorder.none)),
                        leading: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(4),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_rounded),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Text(
                'Found 10 Results',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: FirestoreService().getProducts(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    return Expanded(
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75),
                          itemBuilder: ((context, index) {
                            return ProductCard(
                              prodName: snapshot.data!.docs[index]['Name'],
                              sub: snapshot.data!.docs[index]['Sub'],
                              price: snapshot.data!.docs[index]['Price']
                                  .toString(),
                              fav: snapshot.data!.docs[index]['Fav'],
                              docPath: snapshot.data!.docs[index].id,
                            );
                          })),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
