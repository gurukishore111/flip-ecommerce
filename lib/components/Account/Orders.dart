import 'package:flip/components/Common/Loader.dart';
import 'package:flip/components/Common/Product.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Order.dart';
import 'package:flip/screens/OrderDetails.dart';
import 'package:flip/services/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final OrderServices orderServices = OrderServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await orderServices.fetchMyOrder(context: context);
    setState(() {});
  }

  void navigateToOrderDetails(Order order) {
    Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Yours Orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: const Text(
                      "See all",
                      style: TextStyle(color: GlobalVariables.secondaryColor),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 170,
                padding: EdgeInsets.only(left: 10, right: 0, top: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () => navigateToOrderDetails(orders![index]),
                        child: Product(
                            image: orders![index].products[0].images[0]),
                      );
                    })),
              )
            ],
          );
  }
}
