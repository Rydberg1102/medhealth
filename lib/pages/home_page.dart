import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/services/database_service.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_category.dart';
import 'package:medhealth/widget/card_product.dart';
import 'package:medhealth/model/todo.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.fromLTRB(24, 30, 25, 30),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 155,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Find a medicine or\nvitamins with MEDHEALTH",
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyBoldColor),
                )
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: greenColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe4faf0)),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffb1d8b2),
                ),
                hintText: "Search medicine ...",
                hintStyle: regularTextStyle.copyWith(color: Color(0xffb0d8b2))),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          "Medicine & Vitamins by Category",
          style: regularTextStyle.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 14,
        ),
        _messageListView()
      ],
    )));
  }

  Widget _messageListView() {
    return StreamBuilder(
      stream: _databaseService.getCategory(),
      builder: (context, snapshot) {
        List category_product = snapshot.data?.docs ?? [];
        if (category_product.isEmpty) {
          return const Center(
            child: Text("Add a todo!"),
          );
        }
        return GridView.builder(
          itemCount: category_product.length,
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, i) {
            Todo todo = category_product[i].data();
            return CardCategory(
                imageCategory: todo.image, nameCategory: todo.category);
          },
        );
      },
    );
  }
}
