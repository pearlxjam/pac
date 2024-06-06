import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pac/controller/controllers.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.withOpacity(0.6), offset: const Offset(0, 0), blurRadius: 8)]),
            child: Obx(
              () => TextField(
                autofocus: false,
                controller: productController.searchTextEditController,
                onSubmitted: (val) {
                  productController.getProductByName(keyword: val);
                  dashboardController.updateIndex(1);
                },
                onChanged: (val) {
                  productController.searchVal.value = val;
                },
                decoration: InputDecoration(
                    suffixIcon: productController.searchVal.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              productController.searchTextEditController.clear();
                              productController.searchVal.value = '';
                              productController.getProducts();
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    hintText: "Buscar...",
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
