#ifndef __EQUERY_SET_HPP__
#define __EQUERY_SET_HPP__

#include "e_graphic.hpp"
#include "e_tool.hpp"

#define random(x) (rand() % x)

const int INIT_PART_NUM = 6;

double randf() {
  double t = (double)(rand() / (double)RAND_MAX);
  return t;
}

class QuerySet {
public:
  int tSetSize;
  Node gLL, ur;

  QuerySet(int size) { tSetSize = size; }

  int Convert2int(Node *p) {
    int tGridNum = pow(4, INIT_PART_NUM);
    int lineNum = sqrt(tGridNum);
    double latWidth = (ur.GetLatitude() - gLL.GetLatitude()) / lineNum;
    double lngWidth = (ur.GetLongitude() - gLL.GetLongitude()) / lineNum;
    return (int)(lineNum * (p->GetLatitude() - gLL.GetLatitude()) / latWidth) +
           (int)((p->GetLongitude() - gLL.GetLongitude()) / lngWidth);
  }

  void initArea() {
    gLL.SetLatitude(10000);
    gLL.SetLongitude(10000);
    ur.SetLatitude(-10000);
    ur.SetLongitude(-10000);
    for (int i = 0; i < gGraph->GetNodeNumber(); i++) {
      if (gLL.GetLatitude() > gGraph->GetNodeById(i)->GetLatitude())
        gLL.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (gLL.GetLongitude() > gGraph->GetNodeById(i)->GetLongitude())
        gLL.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
      if (ur.GetLatitude() < gGraph->GetNodeById(i)->GetLatitude())
        ur.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (ur.GetLongitude() < gGraph->GetNodeById(i)->GetLongitude())
        ur.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
    }
  }

  void GetWhenSet(FileWriter *writer) {

    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      int a = random(gGraph->GetEdgeNumber());
      writer->WriteInt(a);
      double b = randf() * gGraph->GetEdgeById(a)->GetLength();
      writer->WriteDouble(b);
    }
  }

  void GetWhereSet(FileWriter *writer) {
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      int a = random(24 * 3600);
      writer->WriteInt(a);
    }
  }

  void GetDistanceSet(FileWriter *writer) {
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      int a1 = random(24 * 3600);
      int a2 = random(24 * 3600);
      if (a1 > a2) {
        int t = a1;
        a1 = a2;
        a2 = t;
      }
      writer->WriteInt(a1);
      writer->WriteInt(a2);
    }
  }

  void GetHowlongSet(FileWriter *writer) {
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      int a1 = random(gGraph->GetEdgeNumber());
      writer->WriteInt(a1);
      double b1 = randf() * gGraph->GetEdgeById(a1)->GetLength();
      writer->WriteDouble(b1);
      int a2 = random(gGraph->GetEdgeNumber());
      writer->WriteInt(a2);
      double b2 = randf() * gGraph->GetEdgeById(a2)->GetLength();
      writer->WriteDouble(b2);
    }
  }

  void GetWindowSet(FileWriter *writer) {
    initArea();
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      double lat =
          gLL.GetLatitude() + randf() * (ur.GetLatitude() - gLL.GetLatitude());
      double lng = gLL.GetLongitude() +
                   randf() * (ur.GetLongitude() - gLL.GetLongitude());
      int tGridNum = pow(4, INIT_PART_NUM);
      int lineNum = sqrt(tGridNum);
      double latWidth = (ur.GetLatitude() - gLL.GetLatitude()) / lineNum;
      double lngWidth = (ur.GetLongitude() - gLL.GetLongitude()) / lineNum;

      writer->WriteDouble(((int)((lat - gLL.GetLatitude()) / latWidth)) *
                              latWidth +
                          gLL.GetLatitude());
      writer->WriteDouble(((int)((lng - gLL.GetLongitude()) / lngWidth)) *
                              lngWidth +
                          gLL.GetLongitude());
      writer->WriteDouble(((int)((lat - gLL.GetLatitude()) / latWidth) + 1) *
                              latWidth +
                          gLL.GetLatitude());
      writer->WriteDouble(((int)((lng - gLL.GetLongitude()) / lngWidth) + 1) *
                              lngWidth +
                          gLL.GetLongitude());
    }
  }

  void GetKNNSet(FileWriter *writer) {
    initArea();
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      double lat =
          gLL.GetLatitude() + randf() * (ur.GetLatitude() - gLL.GetLatitude());
      double lng = gLL.GetLongitude() +
                   randf() * (ur.GetLongitude() - gLL.GetLongitude());
      writer->WriteDouble(lat);
      writer->WriteDouble(lng);
    }
  }

  void GetCountSet(FileWriter *writer) {
    initArea();
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      double lat =
          gLL.GetLatitude() + randf() * (ur.GetLatitude() - gLL.GetLatitude());
      double lng = gLL.GetLongitude() +
                   randf() * (ur.GetLongitude() - gLL.GetLongitude());
      int tGridNum = pow(4, INIT_PART_NUM);
      int lineNum = sqrt(tGridNum);
      double latWidth = (ur.GetLatitude() - gLL.GetLatitude()) / lineNum;
      double lngWidth = (ur.GetLongitude() - gLL.GetLongitude()) / lineNum;

      writer->WriteDouble(((int)((lat - gLL.GetLatitude()) / latWidth)) *
                              latWidth +
                          gLL.GetLatitude());
      writer->WriteDouble(((int)((lng - gLL.GetLongitude()) / lngWidth)) *
                              lngWidth +
                          gLL.GetLongitude());
      writer->WriteDouble(((int)((lat - gLL.GetLatitude()) / latWidth) + 1) *
                              latWidth +
                          gLL.GetLatitude());
      writer->WriteDouble(((int)((lng - gLL.GetLongitude()) / lngWidth) + 1) *
                              lngWidth +
                          gLL.GetLongitude());
    }
  }

  void GetDistanceSingleSet(FileWriter *writer) {
    int i;
    writer->WriteInt(tSetSize);
    for (i = 0; i < tSetSize; i++) {
      int a = random(24 * 3600);
      writer->WriteInt(a);
    }
  }
};

#endif
