import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Gerçek zamanlı arama — accent odak halkası, beyaz zemin, net border.
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Ürün adına göre arama yapın',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool hasText = widget.controller.text.isNotEmpty;
    final bool focused = _focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: focused ? AppPalette.accent : AppPalette.border,
            width: focused ? 1.5 : 1,
          ),
          boxShadow: <BoxShadow>[
            if (focused)
              BoxShadow(
                color: AppPalette.accent.withValues(alpha: 0.22),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              )
            else
              BoxShadow(
                color: AppPalette.primary.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.md),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.search,
            cursorColor: AppPalette.accent,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppPalette.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: AppPalette.textSecondary.withValues(alpha: 0.82),
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: focused
                    ? AppPalette.accent
                    : AppPalette.primary.withValues(alpha: 0.72),
              ),
              suffixIcon: hasText
                  ? IconButton(
                      tooltip: 'Temizle',
                      style: IconButton.styleFrom(
                        foregroundColor: AppPalette.textSecondary,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        widget.onChanged('');
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_rounded),
                    )
                  : null,
              filled: true,
              fillColor: AppPalette.surface,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.md + 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
