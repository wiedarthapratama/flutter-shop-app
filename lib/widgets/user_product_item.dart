import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/providers/product_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Delete ${title} ?"),
                          content: Text("Are you sure for delete ${title} ?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text('No')),
                            FlatButton(
                                onPressed: () async {
                                  try {
                                    await Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .deleteProduct(id);
                                  } catch (e) {
                                    scaffold.showSnackBar(SnackBar(
                                        content: Text('Deleting Failed')));
                                  }
                                  Navigator.of(ctx).pop();
                                },
                                child: Text('Yes')),
                          ],
                        ));
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
