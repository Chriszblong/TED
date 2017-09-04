#ifndef __EPREFIX_HPP__
#define __EPREFIX_HPP__

#include "e_tool.hpp"
#include <string>
#include <vector>

#ifndef __GLCODINGS__
#define __GLCODINGS__
vector<vector<vector<unsigned char> *> *> *gLCodings =
    new vector<vector<vector<unsigned char> *> *>();
#endif

vector<vector<vector<unsigned char> *> *> *gPrefixCodings =
    new vector<vector<vector<unsigned char> *> *>();

class Prefix {
public:
  vector<unsigned char> *GetPrefix(vector<unsigned char> *a) {
    vector<unsigned char> *result = new vector<unsigned char>();
    switch (a->size()) {
    case 0:
      result->push_back(0);
      result->push_back(0);
      result->push_back(0);
      result->push_back(0);
      break;
    case 1:
      result->push_back(0);
      result->push_back(0);
      result->push_back(0);
      result->push_back(1);
      break;
    case 2:
      result->push_back(0);
      result->push_back(0);
      result->push_back(1);
      result->push_back(0);
      break;
    case 3:
      result->push_back(0);
      result->push_back(0);
      result->push_back(1);
      result->push_back(1);
      break;
    case 4:
      result->push_back(0);
      result->push_back(1);
      result->push_back(0);
      result->push_back(0);
      break;
    case 5:
      result->push_back(0);
      result->push_back(1);
      result->push_back(0);
      result->push_back(1);
      break;
    case 6:
      result->push_back(0);
      result->push_back(1);
      result->push_back(1);
      result->push_back(0);
      break;
    case 7:
      result->push_back(0);
      result->push_back(1);
      result->push_back(1);
      result->push_back(1);
      break;
    case 8:
      result->push_back(1);
      result->push_back(0);
      result->push_back(0);
      result->push_back(0);
      break;
    case 9:
      result->push_back(1);
      result->push_back(0);
      result->push_back(0);
      result->push_back(1);
      break;
    case 10:
      result->push_back(1);
      result->push_back(0);
      result->push_back(1);
      result->push_back(0);
      break;
    case 11:
      result->push_back(1);
      result->push_back(0);
      result->push_back(1);
      result->push_back(1);
      break;
    case 12:
      result->push_back(1);
      result->push_back(1);
      result->push_back(0);
      result->push_back(0);
      break;
    case 13:
      result->push_back(1);
      result->push_back(1);
      result->push_back(0);
      result->push_back(1);
      break;
    case 14:
      result->push_back(1);
      result->push_back(1);
      result->push_back(1);
      result->push_back(0);
      break;
    case 15:
      result->push_back(1);
      result->push_back(1);
      result->push_back(1);
      result->push_back(1);
      break;
    }

    for (int i = 0; i < a->size(); i++) {
      result->push_back(a->at(i));
    }

    return result;
  }

  void PrefixCoding() {

    vector<unsigned char> *tTmpPrefixCoding = new vector<unsigned char>();

    for (int i = 0; i < gLCodings->size(); i++) {

      vector<vector<unsigned char> *> *tTraPrefixCodings =
          new vector<vector<unsigned char> *>();

      for (int j = 0; j < gLCodings->at(i)->size(); j++) {

        tTmpPrefixCoding = GetPrefix(gLCodings->at(i)->at(j));
        tTraPrefixCodings->push_back(tTmpPrefixCoding);
      }

      gPrefixCodings->push_back(tTraPrefixCodings);
    }
  }
};

Prefix *gPrefix = NULL;

#endif
