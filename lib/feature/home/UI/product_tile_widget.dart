import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';



import '../bloc/home_bloc.dart';
import '../models/home_product_datamodel.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    Key? key,
    required this.productDataModel,
    required this.homeBloc,
  }) : super(key: key);

  @override
  _ProductTileWidgetState createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool _isAddedToCart = false;
  bool _isAddedToWishlist = false;

  void _handleWishlistClick() {
    setState(() {
      _isAddedToWishlist = !_isAddedToWishlist;
    });
    widget.homeBloc.add(HomeProductWishlistButtonClickedEvent(
      clickedProduct: widget.productDataModel,
    ));
  }

  void _handleCartClick() {
    setState(() {
      _isAddedToCart = !_isAddedToCart;
    });
    widget.homeBloc.add(HomeProductCartButtonClickedEvent(
      clickedProduct: widget.productDataModel,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Set animation duration
      curve: Curves.easeInOut, // Set animation curve
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      height: _isAddedToCart || _isAddedToWishlist ? 350 : 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productDataModel.imgeUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(widget.productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + widget.productDataModel.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _handleWishlistClick,
                    icon: Icon(
                      _isAddedToWishlist
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                  IconButton(
                    onPressed: _handleCartClick,
                    icon: Icon(
                      _isAddedToCart
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
