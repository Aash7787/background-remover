import '../ui.dart';

class ContainerDecoration extends BoxDecoration {
  ContainerDecoration({
    Color? color,
    Color? borderColor,
    double? radius,
    List<BoxShadow>? boxShadow,
  }) : super(
         color: color ?? AppColors.white,
         borderRadius: BorderRadius.circular(radius ?? 20.0),
         border: Border.all(color: borderColor ?? AppColors.outline),
         boxShadow:
             boxShadow ??
             [
               BoxShadow(
                 color: AppColors.outline.withAlpha(100),
                 blurRadius: 12,
                 offset: const Offset(0, 4),
               ),
             ],
       );
}
