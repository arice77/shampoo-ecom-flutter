import 'package:ecom/services/firebase_firestore.dart';
import 'package:ecom/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const routeNmae = '/product-screen';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _cartNo = 0;
  void _inc() {
    setState(() {
      _cartNo = _cartNo + 1;
    });
  }

  void _dec() {
    setState(() {
      if (_cartNo == 0) return;

      _cartNo = _cartNo - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prod = ModalRoute.of(context)!.settings.arguments as ProdDetails;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: Column(
        children: [
          Container(
              height: 300,
              child: Image.network(
                  'https://images.unsplash.com/photo-1526947425960-945c6e72858f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoYW1wb298ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60')),
          Spacer(),
          Card(
            elevation: 30,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text(
                          prod.prodName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Spacer(),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star_half)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Size 225ml',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      Spacer(),
                      Text('[132 Reviews]')
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        prod.price,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 163, 155, 155)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.linear_scale_outlined),
                              onPressed: (() {
                                _dec();
                              }),
                            ),
                            Text(_cartNo.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _inc();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: _cartNo == 0
                              ? null
                              : () {
                                  FirestoreService().placeOrder(prod.prodName,
                                      _cartNo.toString(), prod.price, context);
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
