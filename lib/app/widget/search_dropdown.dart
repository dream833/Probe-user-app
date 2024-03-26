import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';

import '../../constants/theme_constant.dart';

class SearchDropDown extends StatefulWidget {
  final void Function(String?) onChange;
  final List items;
  final String? value;
  final String? hintText;
  const SearchDropDown(
      {super.key,
      required this.onChange,
      this.hintText,
      required this.items,
      required this.value});
  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  final searchController = TextEditingController();
  @override
  void initState() {
    if (widget.value != null) {
      searchController.text = widget.value!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      fillColor: Colors.white,
      borderRadius: BorderRadius.circular(16),
      // borderSide: const BorderSide(color: borderColor),
      hintText: widget.hintText??'Select Category',
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: Colors.grey, fontSize: 14),
      listItemStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: Colors.grey, fontSize: 14),
      selectedStyle: CustomFont.regularText.copyWith(
        color: Colors.black,
        fontSize: 14,
      ),
      hideSelectedFieldWhenOpen: true,
      items: widget.items.map((e) => e as String).toList(),
      controller: searchController,
      onChanged: widget.onChange,
    );
  }
}
