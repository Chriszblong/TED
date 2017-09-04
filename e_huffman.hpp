#ifndef __EHUFFMAN_HPP__
#define __EHUFFMAN_HPP__

#include "e_header.h"
#include "e_pddp.hpp"
#include "e_tool.hpp"
#include <iostream>
#include <vector>
using namespace std;

#ifndef __GLCODINGS__
#define __GLCODINGS__
vector<vector<vector<unsigned char> *> *> *gLCodings =
    new vector<vector<vector<unsigned char> *> *>();
#endif

vector<vector<vector<unsigned char> *> *> *gHuffmanCodings =
    new vector<vector<vector<unsigned char> *> *>();

struct HNode {
  vector<unsigned char> *mData;
  int mValue;
  HNode *mLeft;
  HNode *mRight;
  bool mIsVisited;
};

HNode *nodes[100000];
HNode *gHTree = NULL;
int gPos = 0;

class Huffman {
public:
  void LoadHuffmanIndex(FileReader *reader) {

    gHTree = new HNode();
    gHTree->mData = new vector<unsigned char>();

    HNode *tTmpNode = gHTree;
    Binary *mCodingBinary;
    Binary *mData;
    while (1) {

      mData = new Binary(reader);
      if (mData->mIsEOF) {
        break;
      }

      mCodingBinary = new Binary(reader);
      tTmpNode = gHTree;

      for (int i = 0; i < mCodingBinary->mBinary->size(); i++) {
        if (mCodingBinary->mBinary->at(i) == false) {
          if (tTmpNode->mLeft == NULL) {
            tTmpNode->mLeft = new HNode();
            tTmpNode->mLeft->mData = new vector<unsigned char>();
          }
          tTmpNode = tTmpNode->mLeft;
        } else {
          if (tTmpNode->mRight == NULL) {
            tTmpNode->mRight = new HNode();
            tTmpNode->mRight->mData = new vector<unsigned char>();
          }
          tTmpNode = tTmpNode->mRight;
        }
      }

      tTmpNode->mData = BoolToChar(mData->mBinary);
      delete mData;
      delete mCodingBinary;
    }
  }

  vector<unsigned char> *GetIndexCoding(vector<unsigned char> *data11) {

    HNode *tTmpNode = gHTree;
    for (int i = 0; i < data11->size(); i++) {

      if (data11->at(i) == 0)
        tTmpNode = tTmpNode->mLeft;
      else
        tTmpNode = tTmpNode->mRight;
    }

    return tTmpNode->mData;
  }

  void HuffmanCoding() {

    int i, j, k;
    vector<unsigned char> *t;

    for (i = 0; i < gLCodings->size(); i++) {

      vector<vector<unsigned char> *> *tt =
          new vector<vector<unsigned char> *>();
      for (j = 0; j < gLCodings->at(i)->size(); j++) {

        t = GetIndexCoding(gLCodings->at(i)->at(j));
        tt->push_back(t);
      }

      gHuffmanCodings->push_back(tt);
    }
  }

  void CountHuffman(FileReader *lcodingsreader,
                    FileWriter *huffmancountwriter) {

    gPDDPIndex = new PDDPIndex();
    gPDDPIndex->LoadLocationData(lcodingsreader);

    SaveCountToFile(new vector<unsigned char>(), gTree, huffmancountwriter);
    delete gPDDPIndex;
  }

  void SaveCountToFile(vector<unsigned char> *aim, DPNode *gTree,
                       FileWriter *writer) {

    int k;

    if (gTree->mNumber > 0) {
      vector<bool> *tTmpNode = new vector<bool>();

      for (k = 0; k < aim->size(); k++) {
        tTmpNode->push_back(aim->at(k));
      }

      Binary *tBinary = new Binary(tTmpNode);
      tBinary->Store(writer);
      delete tBinary;

      writer->WriteInt(gTree->mNumber);
    }

    if (gTree->mLeft) {
      vector<unsigned char> *tLeftAim = new vector<unsigned char>();
      for (k = 0; k < aim->size(); k++) {
        tLeftAim->push_back(aim->at(k));
      }
      tLeftAim->push_back(0);
      SaveCountToFile(tLeftAim, gTree->mLeft, writer);
    }

    if (gTree->mRight) {
      vector<unsigned char> *tRightAim = new vector<unsigned char>();
      for (k = 0; k < aim->size(); k++) {
        tRightAim->push_back(aim->at(k));
      }
      tRightAim->push_back(1);
      SaveCountToFile(tRightAim, gTree->mRight, writer);
    }
  }

  void Save2File(FileWriter *writer, vector<unsigned char> *aim, HNode *gTree) {

    int k;

    if (gTree->mData->size() > 0) {
      vector<bool> *tTmpNode = new vector<bool>();

      for (k = 0; k < aim->size(); k++) {

        tTmpNode->push_back(aim->at(k));
      }
      Binary *my = new Binary(tTmpNode);
      my->Store(writer);

      vector<bool> *tTmpNode1 = new vector<bool>();

      for (k = 0; k < gTree->mData->size(); k++) {

        tTmpNode1->push_back(gTree->mData->at(k));
      }
      Binary *my1 = new Binary(tTmpNode1);
      my1->Store(writer);
    }

    if (gTree->mLeft != NULL) {
      vector<unsigned char> *tLeftAim = new vector<unsigned char>();
      for (k = 0; k < aim->size(); k++) {
        tLeftAim->push_back(aim->at(k));
      }
      tLeftAim->push_back(0);
      Save2File(writer, tLeftAim, gTree->mLeft);
    }

    if (gTree->mRight != NULL) {
      vector<unsigned char> *tRightAim = new vector<unsigned char>();
      for (k = 0; k < aim->size(); k++) {
        tRightAim->push_back(aim->at(k));
      }
      tRightAim->push_back(1);
      Save2File(writer, tRightAim, gTree->mRight);
    }
  }

  void BuildHuffmanIndex(FileReader *reader, FileWriter *writer) {

    Binary *line1;
    int num;
    int i;
    gPos = 0;

    while (1) {
      line1 = new Binary(reader);
      if (line1->mIsEOF) {
        break;
      }
      num = reader->GetNextInt();

      nodes[gPos] = new HNode();
      nodes[gPos]->mData = BoolToChar(line1->mBinary);
      nodes[gPos]->mValue = num;
      nodes[gPos]->mLeft = NULL;
      nodes[gPos]->mRight = NULL;
      nodes[gPos]->mIsVisited = false;
      gPos++;
      delete line1;
    }

    while (1) {
      int minmin = -1, min = -1;
      for (i = 0; i < gPos; i++) {
        if (nodes[i]->mIsVisited == false) {
          if (minmin == -1) {
            minmin = i;
          } else if (min == -1) {
            min = i;
          } else if (nodes[i]->mValue < nodes[minmin]->mValue) {
            min = minmin;
            minmin = i;
          } else if (nodes[i]->mValue < nodes[min]->mValue) {
            min = i;
          }
        }
      }
      if (min == -1) {
        gHTree = nodes[minmin];
        break;
      } else {
        nodes[min]->mIsVisited = true;
        nodes[minmin]->mIsVisited = true;
        HNode *c, *a, *b;
        c = new HNode();
        a = new HNode();
        b = new HNode();
        a->mValue = nodes[minmin]->mValue;
        a->mData = new vector<unsigned char>();
        for (i = 0; i < nodes[minmin]->mData->size(); i++) {
          a->mData->push_back(nodes[minmin]->mData->at(i));
        }
        a->mLeft = nodes[minmin]->mLeft;
        a->mRight = nodes[minmin]->mRight;

        b->mValue = nodes[min]->mValue;
        b->mData = new vector<unsigned char>();

        for (i = 0; i < nodes[min]->mData->size(); i++) {
          b->mData->push_back(nodes[min]->mData->at(i));
        }

        b->mLeft = nodes[min]->mLeft;
        b->mRight = nodes[min]->mRight;

        c->mIsVisited = false;
        c->mValue = a->mValue + b->mValue;
        c->mLeft = a;
        c->mRight = b;
        c->mData = new vector<unsigned char>();

        for (i = 0; i < gPos; i++) {
          if (nodes[i]->mIsVisited) {
            nodes[i] = c;
            break;
          }
        }
      }
    }

    Save2File(writer, new vector<unsigned char>(), gHTree);
  }
};

Huffman *gHuffman = NULL;

#endif
