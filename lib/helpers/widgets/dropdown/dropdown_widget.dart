import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:finals_fe/utils/app_color.dart';

class DropdownWidget extends StatefulWidget {
  final String title;
  final String hint;
  final bool isRequired;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;

  const DropdownWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.isRequired,
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.blueBackground, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColor.darkPurple,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.isRequired) ...[
                const Gap(4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: AppColor.lightRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const Gap(8),
          DropdownButton<String>(
            hint: Text(
              widget.hint,
              style: const TextStyle(
                color: AppColor.disable,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            value: _selectedItem,
            isExpanded: true,
            isDense: true,
            icon: const Icon(Icons.arrow_drop_down, color: AppColor.white),
            style: TextStyle(
              color: _selectedItem != null ? AppColor.white : AppColor.disable,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            dropdownColor: AppColor.blueBackground,
            underline: Container(),
            items: widget.items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: item == _selectedItem ? AppColor.white : AppColor.white,
                    fontWeight: item == _selectedItem ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
              });
              widget.onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
