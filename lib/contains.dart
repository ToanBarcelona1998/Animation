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
}