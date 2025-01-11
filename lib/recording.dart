import 'dart:ui';

import 'package:capstone/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> with SingleTickerProviderStateMixin {
  late Recording _recording;


  @override
  void initState() {
    super.initState();
    _recording = Recording();
    _recording.documents.add(Document());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text(
                textAlign: TextAlign.center,
                "Recording Fees",
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
                                          const Text("Total fees:"),
                                          Text(
                                            NumberFormat.currency(
                                                symbol: '\$', decimalDigits: 2)
                                                .format(_recording.getFee() ?? 0),
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
                            ],
                          ),
                        ),
                        Multicard(
                          mode: MulticardMode.quatrenary,
                          tiles: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 19.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "State",
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
                                          text: _recording.state ?? ""),
                                      optionsBuilder: (
                                          TextEditingValue textEditingValue) {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        }
                                        return Database.states.where((String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          _recording.state = selection;
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
                                              hintText: "Enter county name...",
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 8.0),
                          child: Multicard(
                              mode: MulticardMode.primary,
                              tiles: List<Widget>.generate(
                                  _recording.documents.length, (index) =>

                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    _recording.documents[index].name ?? "Document ${index + 1}",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                      fontSize: 18,
                                                      fontVariations: [
                                                        const FontVariation('wght', 700),
                                                      ],
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.edit),
                                                    color: const Color(0xFF4E6A8F),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          TextEditingController controller = TextEditingController(
                                                            text: _recording.documents[index].name,
                                                          );
                                                          return AlertDialog(
                                                            title: Padding(
                                                              padding: const EdgeInsets.only(right: 64.0),
                                                              child: Text("Rename ${_recording.documents[index].name ?? "Document ${index + 1}"}"),
                                                            ),
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                                            content: Padding(
                                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                                child: SoftShadow.wrap(
                                                                  child: TextField(
                                                                    controller: controller,
                                                                    decoration: const InputDecoration(
                                                                      hintText: "Enter new name...",
                                                                    ),
                                                                  ),
                                                                )
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _recording.documents[index].name = (controller.text.isEmpty ? null : controller.text);
                                                                  });
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Save'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Cancel'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    _recording.documents.removeAt(index);
                                                  });
                                                },
                                              ),

                                            ],

                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.0),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                child: SoftShadow.wrap(child: TextField(
                                                  keyboardType: TextInputType
                                                      .number,
                                                  decoration: const InputDecoration(
                                                    labelText: "Pages",
                                                  ),
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _recording.documents[index].pages = int.tryParse(value);
                                                    });
                                                  },
                                                ),
                                                ),
                                              ),

                                              SoftShadow.wrap(
                                                child: SegmentedButton(
                                                  emptySelectionAllowed: true,
                                                  multiSelectionEnabled: false,
                                                  showSelectedIcon: false,
                                                  segments: const [
                                                    ButtonSegment(
                                                        value: RecordingType.deed,
                                                        label: Text('Deed')),
                                                    ButtonSegment(
                                                        value: RecordingType.mersMtg,
                                                        label: Text('MERS Mtg.')),
                                                    ButtonSegment(
                                                        value: RecordingType.mersALR,
                                                        label: Text('MERS A/R.')),
                                                  ],
                                                  selected: _recording
                                                      .documents[index].recordingTypes
                                                      .isNotEmpty ? {
                                                    _recording.documents[index]
                                                        .recordingTypes.first
                                                  } : {},
                                                  onSelectionChanged: (newSelection) {
                                                    setState(() {
                                                      _recording.documents[index]
                                                          .recordingTypes = newSelection.isEmpty ? [] : [newSelection.first];
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          if(_recording.getFee(index: index) != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  NumberFormat.currency(
                                                      symbol: '\$', decimalDigits: 2)
                                                      .format(_recording.getFee(index: index)),
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
                                  )
                              ).followedBy(
                                  [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _recording.documents.add(Document());
                                            });
                                          },
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.add),
                                              Text("Add Document"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                              ).toList()
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