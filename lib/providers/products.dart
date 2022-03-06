import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app/models/http_exception.dart';
import 'package:shopping_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),

//     {
//     "products": [
//         {
//             "id": 1,
//             "name": "iPhone 12 Pro",
//             "desc": "Apple iPhone 12th generation",
//             "price": 999,
//             "color": "#33505a",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc"
//         },
//         {
//             "id": 2,
//             "name": "Pixel 5",
//             "desc": "Google Pixel phone 5th generation",
//             "price": 699,
//             "color": "#00ac51",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd0JhwLvm_uLDLc-la7hK9WyVpe9naJFcebKfhcICiq2KtvXDePNAU_9QO06LPcQ0K0fLByc7m&usqp=CAc"
//         },
//         {
//             "id": 3,
//             "name": "M1 Macbook Air",
//             "desc": "Apple Macbook air with apple silicon",
//             "price": 1099,
//             "color": "#e0bfae",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMOMstwtmLnjFb3NHiDJ_kcQnueNVH-rv_3ps96HZmXlFumKWaiBqq_L4Uoyx3iFiNTrXNEbyB&usqp=CAc"
//         },
//         {
//             "id": 4,
//             "name": "Playstation 5",
//             "desc": "Sony Playstation 5th generation",
//             "price": 500,
//             "color": "#544ee4",
//             "image": "https://cdn.vox-cdn.com/thumbor/lCUTZMIb1B4QF2OTxNPUKPYtcSA=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/22015298/vpavic_4278_20201030_0120.jpg"
//         },
//         {
//             "id": 5,
//             "name": "Airpods Pro",
//             "desc": "Apple Aipods Pro 1st generation",
//             "price": 200,
//             "color": "#e3e4e9",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQROEs084z65psoo06zYl5R0tUzywOVKVQZzmzqCj3PDP1vVJTWv3gGwGMFENSy4qV4n7sEQjE&usqp=CAc"
//         },
//         {
//             "id": 6,
//             "name": "iPad Pro",
//             "desc": "Apple iPad Pro 2020 edition",
//             "price": 799,
//             "color": "#f73984",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNzUeRQ5uH7E3hpECib8qxdhfHv6SnUGT7mOsew_xiOoqRR7ZpdH-TQ4J6-HuIEfqHimYyPXWH&usqp=CAc"
//         },
//         {
//             "id": 7,
//             "name": "Galaxy S21 Ultra",
//             "desc": "Samsung Galaxy S21 Ultra 2021 edition",
//             "price": 1299,
//             "color": "#1c1c1c",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT_PZcc0wicVYR992s5QCIDLYy8t-z-9kibTUdWZBN2sd86aaqdAJfhvxAwZNWV9wfdzDikpr1&usqp=CAc"
//         },
//         {
//             "id": 8,
//             "name": "Galaxy S21",
//             "desc": "Samsung Galaxy S21 2021 edition",
//             "price": 899,
//             "color": "#7c95eb",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBNHd7FwarbxA1xdMFt24KazjcR4dWPH_t_T5dz4YNK1s7rJAQ8gOIuR_NRw6eeiQgFhbZ9sAN&usqp=CAc"
//         }
//     ]
// }
  ];

  final String? authToken;
  final String? userId;
  Products(
    this._items,
    this.authToken,
    this.userId,
  );

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://flutter-update-9636c-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-update-9636c-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoritesData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: double.parse(prodData['price'].toString()),
          isFavorite:
              favoritesData == null ? false : favoritesData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-update-9636c-default-rtdb.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          },
        ),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProdduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-update-9636c-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProdduct.title,
            'description': newProdduct.description,
            'imageUrl': newProdduct.imageUrl,
            'price': newProdduct.price,
          }));
      _items[prodIndex] = newProdduct;
      notifyListeners();
    } else {
      print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-update-9636c-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      throw HttpException('Could not delete product');
    } else {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
