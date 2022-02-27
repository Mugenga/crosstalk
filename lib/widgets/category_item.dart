import 'package:crosstalk/provider/words.dart';
import 'package:crosstalk/screens/pronounce_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatefulWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  var _isLoading = false;

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      PronounceScreen.routeName,
      arguments: {
        'id': widget.id,
        'title': widget.title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });
        var category = this.widget.title.toLowerCase();
        await Provider.of<Words>(context, listen: false)
            .getWordsByCategory(category);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(
          PronounceScreen.routeName,
          arguments: {
            'id': widget.id,
            'title': widget.title,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
