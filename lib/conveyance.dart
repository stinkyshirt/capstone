import 'dart:ui';
import 'package:capstone/utils.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class ConveyancePage extends StatefulWidget {
  const ConveyancePage({Key? key}) : super(key: key);

  @override
  _ConveyancePageState createState() => _ConveyancePageState();
}

class _ConveyancePageState extends State<ConveyancePage> with SingleTickerProviderStateMixin {
  final Sale _sale = Sale();


  @override
  void initState() {
    super.initState();
    _sale.state = "ohio";
    _sale.county = "Franklin";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            textAlign: TextAlign.center,
            "Conveyance Taxes",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: ListView(
              children: [
                Section(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Multicard(
                        mode: MulticardMode.tertiary,
                        tiles: [
                          SizedBox(
                              width: double.infinity,
                              child: Padding(padding: const EdgeInsets
                                  .symmetric(horizontal: 16.0, vertical: 19.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      const Text("Total tax:"),
                                      Text(
                                        NumberFormat.currency(
                                            symbol: '\$', decimalDigits: 2)
                                            .format(
                                            (_sale.getMuniTax() == null ||
                                                _sale.getStateTax() == null)
                                                ? 0
                                                : (_sale.getMuniTax()! +
                                                _sale.getStateTax()!)),
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(fontSize: 40),
                                      ),
                                    ],
                                  )
                              )
                          ),
                          if(_sale.getMuniTax() != null ||
                              _sale.getStateTax() != null)
                            SizedBox(
                                width: double.infinity,
                                child: Padding(padding: const EdgeInsets
                                    .symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                    child: Column(
                                      children: [
                                        if(_sale.getMuniTax() != null)
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 130,
                                                child: Text("State tax:"),
                                              ),
                                              Text(
                                                _sale.stateExempt
                                                    ? "N/A"
                                                    : NumberFormat.currency(
                                                    symbol: '\$',
                                                    decimalDigits: 2)
                                                    .format(
                                                    _sale.getStateTax()!),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge
                                                    ?.copyWith(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        if(_sale.getStateTax() != null)
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 130,
                                                child: Text(
                                                    "Municipal tax:"),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                    symbol: '\$',
                                                    decimalDigits: 2)
                                                    .format(
                                                    _sale.getMuniTax()!),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge
                                                    ?.copyWith(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                      ],
                                    )
                                )
                            ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Multicard(
                          mode: MulticardMode.quatrenary,
                          tiles: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Town / City",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                        fontSize: 16,
                                        fontVariations: [
                                          const FontVariation('wght', 650),
                                        ],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0),
                                    ),
                                    Autocomplete<String>(
                                      initialValue: TextEditingValue(
                                          text: _sale.county ?? ""),
                                      optionsBuilder: (
                                          TextEditingValue textEditingValue) {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        }
                                        return Database.towns.where((
                                            String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text
                                                  .toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          _sale.county = selection;
                                        });
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController textEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return SoftShadow.wrap(
                                          child: TextField(
                                            controller: textEditingController,
                                            focusNode: focusNode,
                                            decoration: const InputDecoration(
                                              hintText: "Enter state...",
                                            ),
                                          ),
                                        );
                                      },
                                      optionsViewBuilder: SoftShadow
                                          .optionsViewBuilder,
                                    ),
                                  ],
                                )
                            ),
                          ]
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 4.0),
                      child: Multicard(
                          mode: MulticardMode.primary,
                          tiles: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sale / Purchase Price",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                        fontSize: 16,
                                        fontVariations: [
                                          const FontVariation('wght', 650),
                                        ],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0),
                                    ),
                                    SoftShadow.wrap(
                                      child: PriceFormatter(
                                        priceCallback: (price) {
                                          setState(() {
                                            _sale.price = price;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Enter price...",
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0, vertical: 24.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: SoftShadow.wrap(
                                      child: SegmentedButton(
                                        style: Theme
                                            .of(context)
                                            .segmentedButtonTheme
                                            .style
                                            ?.copyWith(
                                          textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                              color: Color(0xFF030303),
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              fontVariations: [
                                                FontVariation('wght', 750),
                                              ],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        emptySelectionAllowed: false,
                                        multiSelectionEnabled: false,
                                        showSelectedIcon: false,
                                        segments: const [
                                          ButtonSegment(
                                              value: SaleType.commercial,
                                              label: Text("Commercial")),
                                          ButtonSegment(
                                              value: SaleType.residential,
                                              label: Text("Residential")),
                                          ButtonSegment(
                                              value: SaleType.landMulti,
                                              label: Text("Land/Multi")),
                                        ],
                                        selected: { _sale.saleType},
                                        onSelectionChanged: (newSelection) {
                                          setState(() {
                                            _sale.saleType = newSelection.first;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: SoftShadow.wrap(
                                      child: SegmentedButton(
                                        style: Theme
                                            .of(context)
                                            .segmentedButtonTheme
                                            .style
                                            ?.copyWith(
                                          textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                              color: Color(0xFF030303),
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              fontVariations: [
                                                FontVariation('wght', 750),
                                              ],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        emptySelectionAllowed: true,
                                        showSelectedIcon: true,
                                        segments: const [
                                          ButtonSegment(
                                              value: true,
                                              label: Text(
                                                  "Exempt from state tax")),
                                        ],
                                        selected: { _sale.stateExempt},
                                        onSelectionChanged: (newSelection) {
                                          setState(() {
                                            _sale.stateExempt =
                                            newSelection.isEmpty ? false : true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

}