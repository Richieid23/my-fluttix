part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnable;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  const SelectableBox({
    this.isSelected = false,
    this.isEnable = true,
    this.width = 144,
    this.height = 60,
    @required this.text,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (!isEnable)
              ? const Color(0xffe4e4e4)
              : isSelected
                  ? accentColor2
                  : Colors.transparent,
          border: Border.all(
            color: (!isEnable)
                ? const Color(0xffe4e4e4)
                : isSelected
                    ? Colors.transparent
                    : const Color(0xffe4e4e4),
          ),
        ),
        child: Center(
          child: Text(
            text ?? 'None',
            style: (textStyle ?? blackTextFont)
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
