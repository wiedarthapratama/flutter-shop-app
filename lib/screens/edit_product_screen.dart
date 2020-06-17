import 'package:flutter/material.dart';
import 'package:shop_app_v2/models/product.dart';

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
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null, title: '', price: 0, description: '', imageUrl: '');
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
  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if(!_isValid) {
      return ;
    }
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save, color: Colors.white), onPressed: () { _saveForm(); },)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(key: _form, child: ListView(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            validator: (value) {
              if(value.isEmpty) {
                return "please provide a value";
              }
              return null;
            },
            onSaved: (value) {
              _editedProduct = Product(
                title: value,
                price: _editedProduct.price,
                description: _editedProduct.description,
                imageUrl: _editedProduct.imageUrl,
                id: null
              );
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
            validator: (value) {
              if(value.isEmpty){
                return "please enter a value";
              }
              if(double.tryParse(value)==null){
                return "please enter a valid value";
              }
              if(double.parse(value)<=0){
                return "please enter a number greater than zero";
              }
              return null;
            },
            onSaved: (value) {
              _editedProduct = Product(
                title: _editedProduct.title,
                price: double.parse(value),
                description: _editedProduct.description,
                imageUrl: _editedProduct.imageUrl,
                id: null
              );
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            focusNode: _descFocusNode,
            validator: (value) {
              if(value.isEmpty){
                return "please enter a value";
              }
              if(value.length < 10){
                return "should be at least 10 characters long";
              }
              return null;
            },
            onSaved: (value) {
              _editedProduct = Product(
                title: _editedProduct.title,
                price: _editedProduct.price,
                description: value,
                imageUrl: _editedProduct.imageUrl,
                id: null
              );
            },
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
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  validator: (value) {
                    if(value.isEmpty){
                      return "please enter a image url";
                    }
                    if(!value.startsWith("http") && !value.startsWith("https")){
                      return "please enter a valid url";
                    }
                    if(!value.endsWith(".png") && !value.endsWith(".jpg") && !value.endsWith(".jpeg")){
                      return "please enter a valid image url";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      imageUrl: value,
                      id: null
                    );
                  },
                ),
              )
            ]
          )
        ],)),
      ),
    );
  }
}