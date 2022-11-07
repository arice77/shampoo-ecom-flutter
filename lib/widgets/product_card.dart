import 'package:ecom/screens/product_scren.dart';
import 'package:ecom/services/firebase_firestore.dart';
import 'package:flutter/material.dart';

class ProdDetails {
  String prodName;
  String price;
  ProdDetails({required this.prodName, required this.price});
}

class ProductCard extends StatefulWidget {
  String prodName;
  String sub;
  String price;
  bool fav;
  String docPath;
  ProductCard(
      {required this.prodName,
      required this.sub,
      required this.price,
      required this.fav,
      required this.docPath,
      super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductScreen.routeNmae,
            arguments:
                ProdDetails(prodName: widget.prodName, price: widget.price));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.network(
                        'https://images.unsplash.com/photo-1526947425960-945c6e72858f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoYW1wb298ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
                        fit: BoxFit.cover),
                    height: 145,
                    width: 120,
                  )
                ],
              ),
              Text(
                widget.prodName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.sub,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF545C5C),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$ ${widget.price}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      widget.fav
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.fav = !widget.fav;
                      });

                      FirestoreService().setFav(widget.docPath, widget.fav);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
