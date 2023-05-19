import 'package:flutter/material.dart';

class TabInfo {
  final String label;

  const TabInfo({
    required this.label,
  });
}

const TABS = [
  TabInfo(
    label: '전체 피드',
  ),
  TabInfo(
    label: '나의 피드',
  ),
];