import 'dart:ui';
import 'package:capstone/utils.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> with SingleTickerProviderStateMixin {
  final Policy _policy = Policy();

  @override
  void initState() {
    _policy.company = "Stewart Title Guaranty Company";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            textAlign: TextAlign.center,
            "Title Premium",
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
                                      const Text("Gross:"),
                                      Text(
                                        NumberFormat.currency(
                                            symbol: '\$', decimalDigits: 2)
                                            .format(
                                            (_policy.getLoanPremium() == null ||
                                                _policy.getOwnersPremium() == null)
                                                ? 0
                                                : (_policy.getLoanPremium()! +
                                                _policy.getOwnersPremium()!)),
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
                          if(_policy.getLoanPremium() != null || _policy.getOwnersPremium() != null)
                            SizedBox(
                                width: double.infinity,
                                child: Padding(padding: const EdgeInsets
                                    .symmetric(horizontal: 16.0, vertical: 19.0),
                                    child: Column(
                                      children: [
                                        if(_policy.getOwnersPremium() != null)
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 130,
                                                child: Text("Owner's:"),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                    symbol: '\$',
                                                    decimalDigits: 2)
                                                    .format(_policy.getOwnersPremium()!),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge
                                                    ?.copyWith(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        if(_policy.getLoanPremium() != null)
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 130,
                                                child: Text("Loan:"),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                    symbol: '\$',
                                                    decimalDigits: 2)
                                                    .format(_policy.getLoanPremium()!),
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
                                      "Company",
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: _policy.company ?? "Invalid company",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    enabled: false,
                                  ),
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
                                      "Owner's Policy",
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
                                          vertical: 8.0),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: SoftShadow.wrap(
                                            child: PriceFormatter(
                                              priceCallback: (price) {
                                                setState(() {
                                                  _policy.ownerAmount = price;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                labelText: "Liability \$\$\$",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SoftShadow.wrap(
                                          child: SegmentedButton(
                                            emptySelectionAllowed: false,
                                            multiSelectionEnabled: false,
                                            showSelectedIcon: false,
                                            segments: const [
                                              ButtonSegment(
                                                  value: PolicyType.ALTA,
                                                  label: Text('ALTA')),
                                              ButtonSegment(
                                                  value: PolicyType.expanded,
                                                  label: Text('Expanded')),
                                            ],
                                            selected: { _policy.ownerType },
                                            onSelectionChanged: (newSelection) {
                                              setState(() {
                                                _policy.ownerType = newSelection.first;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(_policy.getOwnersPremium() != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                  symbol: '\$', decimalDigits: 2)
                                                  .format(_policy.getOwnersPremium()!),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium?.copyWith(
                                                  color: const Color(0xFF4E6A8F),
                                                  fontVariations: [
                                                    const FontVariation('wght', 700),
                                                  ]
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                            ),

                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lender's Policy",
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
                                          vertical: 8.0),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: SoftShadow.wrap(
                                            child: PriceFormatter(
                                              priceCallback: (price) {
                                                setState(() {
                                                  _policy.loanAmount = price;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                labelText: "Liability \$\$\$",
                                              ),
                                            ),
                                          ),
                                        ),

                                        SoftShadow.wrap(
                                          child: SegmentedButton(
                                            emptySelectionAllowed: false,
                                            multiSelectionEnabled: false,
                                            showSelectedIcon: false,
                                            segments: const [
                                              ButtonSegment(
                                                  value: PolicyType.ALTA,
                                                  label: Text('ALTA')),
                                              ButtonSegment(
                                                  value: PolicyType.expanded,
                                                  label: Text('Expanded')),
                                            ],
                                            selected: { _policy.loanType },
                                            onSelectionChanged: (newSelection) {
                                              setState(() {
                                                _policy.loanType = newSelection.first;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(_policy.getLoanPremium() != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            NumberFormat.currency(
                                                symbol: '\$', decimalDigits: 2)
                                                .format(_policy.getLoanPremium()!),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium?.copyWith(
                                                color: const Color(0xFF4E6A8F),
                                                fontVariations: [
                                                  const FontVariation('wght', 700),
                                                ]
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Prior",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontSize: 14,
                                            fontVariations: [
                                              const FontVariation('wght', 650),
                                            ],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                        ),
                                        Text(
                                          "(For non-NALR refis only)",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontSize: 14,
                                            fontVariations: [
                                              const FontVariation('wght', 400),
                                            ],
                                            fontStyle: FontStyle.italic,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0),
                                    ),
                                    SoftShadow.wrap(
                                      child: PriceFormatter(
                                        priceCallback: (price) {
                                          setState(() {
                                            _policy.prior = price;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Liability \$\$\$",
                                        ),
                                      ),
                                    ),
                                  ],
                                )
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