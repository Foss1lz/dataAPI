import 'package:flutter/material.dart';
import 'package:product_management/Repository/product_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_management/model/products/ProducResponse.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> productlist = [];
  final ProductRepository productRepository = ProductRepository();
  var _isloading = true;
  @override
  void initState() {
    getallProduct();
    super.initState();
  }

  void getallProduct() {
    setState(() {
      _isloading = true;
    });
    productRepository.getAllProducts().then((data) {
      setState(() {
        productlist = data.products;
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Products List"),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : ListView.builder(
              itemCount: productlist.length,
              itemBuilder: (BuildContext context, index) {
                var products = productlist[index];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(bottom: 16.0),
                        width: double.infinity,
                        color: const Color.fromARGB(255, 190, 190, 190),
                        child: Text(
                          products.title ?? "no product",
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
