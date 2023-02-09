

import 'package:flutter/foundation.dart';
import 'package:sfiasset/model/leaving_card.dart';

class LeavingProvider with ChangeNotifier{
  List<LeavingCard> leavingCards = [];


  List<LeavingCard> getleavingCards(){
    return leavingCards;
  }

  addLeavingCard(LeavingCard statement){
    leavingCards.insert(0, statement);
    notifyListeners();
  }

  removeLeavingCard(){
    leavingCards.clear();
  }

}