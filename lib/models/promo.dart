part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  const Promo(
      {@required this.title, @required this.subtitle, @required this.discount});

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  const Promo(
      title: 'Student Holiday',
      subtitle: 'Maximal for two people only',
      discount: 50),
  const Promo(
      title: 'Family Club',
      subtitle: 'Minimal for three members',
      discount: 70),
  const Promo(
      title: 'Subscription Promo', subtitle: 'Min. one year', discount: 40),
];
