import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Section extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const Section({
    super.key,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: title != null ? Text(
              title!,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ) : null,
          ),
          for (int i = 0; i < children.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: children[i],
            ),
          ],
        ],
      ),
    );
  }
}


enum MulticardMode {
  primary,
  secondary,
  tertiary,
  quatrenary,
}

class Multicard extends StatelessWidget {
  final MulticardMode mode;
  final List<Widget> tiles;

  const Multicard({
    super.key,
    required this.mode,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    Color? cardColor, dividerColor;

    switch(mode) {
      case MulticardMode.primary:
        cardColor = Colors.white;
        dividerColor = Theme
            .of(context)
            .dividerTheme
            .color;
        break;
      case MulticardMode.secondary:
        cardColor = Theme
            .of(context)
            .dividerTheme
            .color;
        dividerColor = Colors.white;
        break;
      case MulticardMode.tertiary:
        cardColor = const Color(0xffcedef2);
        dividerColor = Colors.white;
        break;
      case MulticardMode.quatrenary:
        cardColor = const Color(0xffe5e5e5);

        break;
    }

    return Container(
      margin: (mode == MulticardMode.primary) ? const EdgeInsets.symmetric(horizontal: 4.0) : const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow:
            [
              BoxShadow(
                color: Colors.black.withOpacity(mode == MulticardMode.quatrenary ? 0.0875 : 0.125),
                spreadRadius: 1,
                blurRadius: 9,
                offset: const Offset(0, 0),
              ),
            ],
       ),
      child: Column(
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            tiles[i],
            if (i < tiles.length - 1) Divider(color: dividerColor, height: 1),
          ],
        ],
      ),
    );
  }
}


class SoftShadow {
  static Widget wrap({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0625),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }


  static Widget Function(BuildContext, AutocompleteOnSelected<String>, Iterable<
      String>) get optionsViewBuilder =>
          (context, onSelected, options) =>
          Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(24.0),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Theme
                      .of(context)
                      .inputDecorationTheme
                      .fillColor,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(
                          option,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );


}



class PriceFormatter extends StatefulWidget {
  final void Function(double?) priceCallback;
  final InputDecoration decoration;

  const PriceFormatter({
    super.key,
    required this.priceCallback,
    required this.decoration,
  });

  @override
  _PriceFormatterState createState() => _PriceFormatterState();
}


class _PriceFormatterState extends State<PriceFormatter> {
  late TextEditingController _controller;

  
  String _sanitize(String text) => text.replaceAll('\$', '').replaceAll(',', '');
  
  
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      var text = _controller.text;

      if(text.isEmpty) return;
      final price = double.tryParse(_sanitize(text));

      if(price == null || price == 0.0) {
        _controller.value = const TextEditingValue(
          text: "",
          selection: TextSelection.collapsed(offset: 0),
        );
        return;
      }

      final cursor = _controller.selection.baseOffset;
      bool shouldPush = true;

      if(!text.contains('.') && text.length != 1) {
        shouldPush = false;
      }

      text = NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(price);

      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: cursor + (shouldPush ? (_controller.text.length == 1 ? 1 : text.length - _controller.text.length) : 0)
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      onChanged: (value) {
        widget.priceCallback(double.tryParse(_sanitize(value)));
      },
      decoration: widget.decoration,
    );
  }


}