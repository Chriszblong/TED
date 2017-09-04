#ifndef __EPDDP_HPP__
#define __EPDDP_HPP__

#include "e_tool.hpp"
#include <string>
#include <vector>

#ifndef __GLCODINGS__
#define __GLCODINGS__
vector<vector<vector<unsigned char> *> *> *gLCodings =
    new vector<vector<vector<unsigned char> *> *>();
#endif

vector<vector<vector<unsigned char> *> *> *gDDPCodings =
    new vector<vector<vector<unsigned char> *> *>();

vector<vector<vector<unsigned char> *> *> *gPDDPCodings =
    new vector<vector<vector<unsigned char> *> *>();

int gNodeSize = 0;

class DPNode {
public:
  DPNode() {
    mNumber = 0;
    mLeft = NULL;
    mRight = NULL;
    mData = new vector<unsigned char>();
    mRatio = -1;
  }

  double String2Double(vector<unsigned char> *data) {
    if (data->size() == 0) {
      return 0;
    }
    double tResult = 0;
    double tTmpRatio = 0.5;
    for (int i = 0; i < data->size(); i++) {
      tResult += (tTmpRatio * data->at(i));
      tTmpRatio *= 0.5;
    }
    return tResult;
  }

  long mNumber;
  DPNode *mLeft, *mRight;
  vector<unsigned char> *mData;
  double mRatio;
};

DPNode *gTree;

class PDDPIndex {
public:
  void LoadLocationData(FileReader *reader) {
    gTree = new DPNode();
    DPNode *tmp = gTree;
    int ttraNumber = reader->GetNextInt();
    for (int i = 0; i < ttraNumber; i++) {
      int tTraSize = reader->GetNextInt();
      for (int j = 0; j < tTraSize; j++) {
        tmp = gTree;
        Binary *my = new Binary(reader);
        for (int k = 0; k < my->mBinary->size(); k++) {
          if (!my->mBinary->at(k)) {
            if (!tmp->mLeft) {
              tmp->mLeft = new DPNode();
            }
            tmp = tmp->mLeft;
          } else {
            if (!tmp->mRight) {
              tmp->mRight = new DPNode();
            }
            tmp = tmp->mRight;
          }
        }
        if (tmp->mNumber == 0) {
          gNodeSize++;
        }
        tmp->mData = new vector<unsigned char>();
        for (int i = 0; i < my->mNumber; i++) {
          tmp->mData->push_back(my->mBinary->at(i));
        }
        tmp->mNumber++;
      }
    }
  }

  void LoadIndex(FileReader *file) {
    int i, j;
    gTree = new DPNode();
    int tTraSize = file->GetNextInt();
    for (j = 0; j < tTraSize; j++) {
      Binary *b1 = new Binary(file);
      Binary *b2 = new Binary(file);

      DPNode *tmp = gTree;
      for (i = 0; i < b2->mNumber; i++) {
        if (!b2->mBinary->at(i)) {
          if (tmp->mLeft == NULL) {
            tmp->mLeft = new DPNode();
          }
          tmp = tmp->mLeft;
        } else {
          if (tmp->mRight == NULL) {
            tmp->mRight = new DPNode();
          }
          tmp = tmp->mRight;
        }
      }
      tmp->mData = new vector<unsigned char>();
      for (i = 0; i < b1->mNumber; i++) {
        tmp->mData->push_back(b1->mBinary->at(i));
      }
    }
  }

  void LoadIndexQ(FileReader *file) {
    int i, j;
    gTree = new DPNode();
    int tTraSize = file->GetNextInt();
    for (j = 0; j < tTraSize; j++) {
      Binary *b1 = new Binary(file);
      Binary *b2 = new Binary(file);

      DPNode *tmp = gTree;
      for (i = 0; i < b1->mNumber; i++) {
        if (!b1->mBinary->at(i)) {
          if (tmp->mLeft == NULL) {
            tmp->mLeft = new DPNode();
          }
          tmp = tmp->mLeft;
        } else {
          if (tmp->mRight == NULL) {
            tmp->mRight = new DPNode();
          }
          tmp = tmp->mRight;
        }
      }
      vector<unsigned char> *t = new vector<unsigned char>();
      for (i = 0; i < b2->mNumber; i++) {
        t->push_back(b2->mBinary->at(i));
      }
      tmp->mRatio = tmp->String2Double(t);
    }
  }

  vector<unsigned char> *GetPDDPCoding(vector<unsigned char> *data) {
    vector<unsigned char> *result = new vector<unsigned char>();
    DPNode *tmp = gTree;
    for (int i = 0; i < data->size(); i++) {
      if (!data->at(i))
        tmp = tmp->mLeft;
      else
        tmp = tmp->mRight;
    }
    return tmp->mData;
  }

  vector<unsigned char> *GetDDPCoding(vector<unsigned char> *data) {
    vector<unsigned char> *result = new vector<unsigned char>();
    DPNode *tmp = gTree;
    for (int i = 0; i < data->size(); i++) {
      if (!data->at(i))
        tmp = tmp->mLeft;
      else
        tmp = tmp->mRight;
    }
    return tmp->mData;
  }

  void CreateDDPIndex(DPNode *node) {
    if (!node) {
      return;
    }
    if (!node->mLeft && !node->mRight) {
      return;
    }
    if (node->mNumber != 0) {
      DPNode *tmp = node;
      while (tmp->mLeft) {
        node->mData->push_back(0);
        tmp = tmp->mLeft;
      }
      tmp->mLeft = new DPNode();
      node->mData->push_back(0);
    }
    if (node->mLeft)
      CreateDDPIndex(node->mLeft);
    if (node->mRight)
      CreateDDPIndex(node->mRight);
  }

  void CreatePDDPIndex(DPNode *node) {
    int i;
    if (!node)
      return;
    if (!node->mLeft && !node->mRight) {
      int po = 0;
      DPNode *tmp = gTree;
      int a = node->mData->size();
      for (i = 0; i < a; i++) {
        if (tmp->mLeft && tmp->mRight) {
          po = i;
        }
        if (!node->mData->at(i)) {
          tmp = tmp->mLeft;
        } else {
          tmp = tmp->mRight;
        }
      }
      for (i = node->mData->size() - 1; i > po + 1; i--)
        node->mData->erase(node->mData->begin() + i);
      return;
    }
    if (node->mLeft)
      CreatePDDPIndex(node->mLeft);
    if (node->mRight)
      CreatePDDPIndex(node->mRight);
  }

  void Write2File(vector<unsigned char> *aim, DPNode *gTree, FileWriter *fp) {
    int i, j;
    if (!gTree)
      return;
    if (gTree->mNumber > 0) {
      vector<bool> *tmp1 = new vector<bool>();
      for (i = 0; i < gTree->mData->size(); i++) {
        tmp1->push_back(gTree->mData->at(i));
      }
      Binary *b1 = new Binary(tmp1);
      b1->Store(fp);
      vector<bool> *tmp2 = new vector<bool>();
      for (i = 0; i < aim->size(); i++) {
        tmp2->push_back(aim->at(i));
      }
      Binary *b2 = new Binary(tmp2);
      b2->Store(fp);
    }
    if (gTree->mLeft) {
      vector<unsigned char> *t1 = new vector<unsigned char>();
      for (i = 0; i < aim->size(); i++)
        t1->push_back(aim->at(i));
      t1->push_back(0);
      Write2File(t1, gTree->mLeft, fp);
    }
    if (gTree->mRight) {
      vector<unsigned char> *t2 = new vector<unsigned char>();
      for (i = 0; i < aim->size(); i++)
        t2->push_back(aim->at(i));
      t2->push_back(1);
      Write2File(t2, gTree->mRight, fp);
    }
  }

  void CreatePDDPIndex(FileReader *reader, FileWriter *writer) {

    LoadLocationData(reader);

    CreateDDPIndex(gTree);
    CreatePDDPIndex(gTree);

    writer->WriteInt(gNodeSize);

    vector<unsigned char> *t1 = new vector<unsigned char>();

    Write2File(t1, gTree, writer);
  }

  void CreateDDPIndex(FileReader *reader, FileWriter *writer) {

    LoadLocationData(reader);
    CreateDDPIndex(gTree);

    writer->WriteInt(gNodeSize);

    vector<unsigned char> *t1 = new vector<unsigned char>();

    Write2File(t1, gTree, writer);
  }

  void GetDDPCoding() {

    vector<unsigned char> *t = new vector<unsigned char>();
    for (int i = 0; i < gLCodings->size(); i++) {

      vector<vector<unsigned char> *> *tttt =
          new vector<vector<unsigned char> *>();

      for (int j = 0; j < gLCodings->at(i)->size(); j++) {

        t = GetDDPCoding(gLCodings->at(i)->at(j));
        tttt->push_back(t);
      }
      gDDPCodings->push_back(tttt);
    }
  }

  void GetPDDPCoding() {
    vector<unsigned char> *t = new vector<unsigned char>();
    for (int i = 0; i < gLCodings->size(); i++) {
      vector<vector<unsigned char> *> *tttt =
          new vector<vector<unsigned char> *>();
      for (int j = 0; j < gLCodings->at(i)->size(); j++) {
        t = GetPDDPCoding(gLCodings->at(i)->at(j));

        tttt->push_back(t);
      }
      gPDDPCodings->push_back(tttt);
    }
  }
};

PDDPIndex *gPDDPIndex = NULL;

#endif
