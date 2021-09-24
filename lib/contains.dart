class Contains{
  static Contains ?_contains;
  factory Contains(){
    if(_contains==null){
      _contains=Contains._();
    }
    return _contains!;
  }
  Contains._();
  static const double radius=35;
  static const double paddingApp=20;

  //File EasyLoading
  static const double radiusLoading=8;
  static const double marginLoading=10;
  static const double constraintsLoading=120;
  static const double paddingLoading=12;
  static const double iconSize=45;
  static const double radiusIndicator=15;
}