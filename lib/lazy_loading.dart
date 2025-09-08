import 'package:flutter/material.dart';

class LazyLoadingWithScroll extends StatefulWidget {
  @override
  _LazyLoadingWithScrollState createState() => _LazyLoadingWithScrollState();
}

class _LazyLoadingWithScrollState extends State<LazyLoadingWithScroll> {
  final ScrollController _scrollController = ScrollController();
  List<int> items = [];
  int page = 1;
  final int limit = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchItems();
      }
    });
  }

  Future<void> fetchItems() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    await Future.delayed(Duration(seconds: 2)); // simulate API delay
    List<int> newItems = List.generate(limit, (index) => index + (page - 1) * limit);

    setState(() {
      page++;
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lazy Loading (Scroll)")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return ListTile(title: Text("Item ${items[index]}"));
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
