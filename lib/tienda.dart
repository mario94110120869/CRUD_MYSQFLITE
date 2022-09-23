

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud1234/models/data_model.dart';
import 'package:flutter_application_crud1234/pedido_listaCart.dart';
import 'package:flutter_application_crud1234/search_delegate.dart';
import 'package:flutter_application_crud1234/services/db_service.dart';
import 'package:flutter_application_crud1234/utils/form_helper.dart';

class Tienda extends StatefulWidget {
  @override
  State<Tienda> createState() => _Tienda();
}

class _Tienda extends State<Tienda> {
  DBService dbService;
  List<ProductModel> listaCarro = [];
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                  child: Container(
                      padding: EdgeInsets.only(left: 1.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextField(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: SearchCountryDelegate(products));
                        },
                        decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            fillColor: Colors.white.withOpacity(0.5),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.white)),
                      ))),
              //centerTitle: true,
              backgroundColor: Colors.purple,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 1.0, top: 8.0),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 38,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Colors.red,
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ),
                        ),
                        if (listaCarro.length > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: CircleAvatar(
                              radius: 8.0,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                listaCarro.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      if (listaCarro.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Cart(listaCarro),
                          ),
                        );
                      } else {
                        showModalBottomSheet(
                            backgroundColor: Colors.purple,
                            context: context,
                            builder: ((builder) => bottomSheet(context)));
                        //print("llene el carro por favor");
                      }
                    },
                  ),
                ),

                //Padin agregado
              ],
              bottom: TabBar(
                unselectedLabelColor: Colors.purpleAccent,
                tabs: <Widget>[
                  new Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Frutas"),
                    ),
                  ),
                  new Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 1),
                      child: Text("Verduras"),
                    ),
                  ),
                  new Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Viandas"),
                    ),
                  ),
                  new Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 1),
                      child: Text("Carnicos"),
                    ),
                  )
                ],
              )),
          body: TabBarView(children: <Widget>[
            Container(
              //color: Colors.purple,

              child: _buildUI(),
            ),
            Container(
              //color: Colors.purple,
              child: _buildUI(),
            ),
            Container(
              //color: Colors.purple,
              child: _buildUI(),
            ),
            Container(
              //color: Colors.purple,
              child: _buildUI(),
            ),
          ])

          // _fetchData(),
          // _fetchData(),
          ),
    );
  }

  Widget lolo() {
    var mario = 1;
    var a;
    if (mario == 1) {
      a = mario;
    }
  }

  // Widget _fetchData() {
  //   return FutureBuilder<List<ProductModel>>(
  //     future: dbService.getProducts(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<List<ProductModel>> products) {
  //       if (products.hasData) {
  //         return _buildUI(products.data);
  //       }

  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  // Widget _carr() {
  //   return FutureBuilder<List<ProductModel>>(
  //     future: dbService.getProducts(),
  //     builder: (BuildContext context,
  //         AsyncSnapshot<List<ProductModel>> _listaCarro) {
  //       if (_listaCarro.hasData) {
  //         return _buildUI(_listaCarro.data);
  //       }

  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  GridView _buildUI() {
    return GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: ((context, index) {
          final String imagen = products[index].productPic;
          var item = products[index];
          return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.file(File(products[index].productPic),
                          width: 200, fit: BoxFit.cover),
                    ),
                    // Expanded(

                    //   child:ImageCache( item.productPic),
                    //   // new Image.asset("assets/images/$imagen",
                    //       fit: BoxFit.cover),
                    //   //fit: BoxFit.contain),+
                    // ),
                    Text(
                      item.productName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "\$${item.price.toString()} ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!listaCarro.contains(item))
                                  ? Icon(
                                      Icons.shopping_cart,
                                      color: Colors.purple,
                                      size: 38,
                                    )
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!listaCarro.contains(item))
                                    listaCarro.add(item);
                                  else
                                    listaCarro.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }

  // _fetchData() {
  //   return FutureBuilder<List<ProductModel>>(
  //     future: dbService.getProducts(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<List<ProductModel>> products) {
  //       if (products.hasData) {
  //         return _buildUI(products.data);
  //       }

  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  // Widget _buildUI(List<ProductModel> products) {
  //   List<Widget> widgets = new List<Widget>();

  //   widgets.add(
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [_buildDataTable(products)],
  //     ),
  //   );

  //   return Padding(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: widgets,
  //     ),
  //     padding: EdgeInsets.all(10),
  //   );
  // }

  // Widget _buildDataTable(List<ProductModel> model) {
  //   return DataTable(
  //     columns: [
  //       DataColumn(
  //         label: Text(
  //           "Nombre",
  //           style: TextStyle(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w900,
  //           ),
  //         ),
  //       ),
  //       DataColumn(
  //         label: Text(
  //           "Precio",
  //           style: TextStyle(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w900,
  //           ),
  //         ),
  //       ),
  //     ],
  //     sortColumnIndex: 1,
  //     rows: model
  //         .map(
  //           (data) => DataRow(
  //             cells: <DataCell>[
  //               //   const Image(
  //               //   image: CachedNetworkImageProvider(
  //               //     'https://via.placeholder.com/350x150',
  //               //   ),
  //               // ),
  //               DataCell(
  //                 Text(
  //                   data.productPic.toString(),
  //                   style: TextStyle(fontSize: 12),
  //                 ),
  //               ),
  //               DataCell(
  //                 Text(
  //                   data.price.toString(),
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //         .toList(),
  //   );
  // }
  _loadData() async {
    List<ProductModel> aux = await dbService.getProducts();
    setState(() {});
    products = aux;
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 25.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Llene el carro por favor ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
