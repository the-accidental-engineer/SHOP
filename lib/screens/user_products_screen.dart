import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    // print('rebuilding...');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: '');
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Products>(
                        builder: (ctx, productData, child) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemBuilder: (context, i) => Column(
                              children: [
                                UserProductItem(
                                  id: productData.items[i].id,
                                  title: productData.items[i].title,
                                  imageUrl: productData.items[i].imageUrl,
                                ),
                                Divider(),
                              ],
                            ),
                            itemCount: productData.items.length,
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
