import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {
        
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(child: ListView(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_descFocusNode);
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            focusNode: _descFocusNode,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                child: 
                  _imageUrlController.text.isEmpty 
                  ? Text("Enter a URL") 
                  : FittedBox(child: Image.network(_imageUrlController.text, fit: BoxFit.cover,)),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Image URL'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  controller: _imageUrlController,
                  focusNode: _imageUrlFocusNode,
                ),
              )
            ]
          )
        ],)),
      ),
    );
  }
}