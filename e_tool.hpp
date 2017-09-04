#ifndef __ETOOL_HPP__
#define __ETOOL_HPP__

#include "e_header.h"
#include <dirent.h>
#include <iomanip>
#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <vector>
using namespace std;

/*
* Function Description: Get the max one in two elements
* @param param1: element1
* @param param2: element2
* @return: the max element
*/
template <typename T> static T MAX(const T &x, const T &y) {
  return x < y ? y : x;
}

/*
* Function Description: Get the radian of the angle
* @param param1: the angle
* @return: the radian of the angle
*/
static double RadianFunction(double value) {
  const double PI = 3.1415926535898;
  return value * PI / 180.0;
}

/*
* Function Description: Get the GPS distance from one point to another
* @param param1: point1.latitude
* @param param2: point1.longtiude
* @param param3: point2.latitude
* @param param4: point2.longitude
* @return: the GPS distance
*/
static double GPSDistance(double lat1, double lng1, double lat2, float lng2) {
  double radLat1 = RadianFunction(lat1);
  double radLat2 = RadianFunction(lat2);
  double tLatSub = radLat1 - radLat2;
  double tradSub = RadianFunction(lng1) - RadianFunction(lng2);
  double tTmp = sqrt(pow(sin(tLatSub / 2), 2) +
                     cos(radLat1) * cos(radLat2) * pow(sin(tradSub / 2), 2));
  if (tTmp > 1 || tTmp < -1) {
    return 0;
  }
  double tResult = 2 * asin(tTmp);
  tResult = tResult * EARTH_RADIUS;
  return tResult;
}

/*
* Function Description: Get the euclidean distance from one point to another
* @param param1: point1.latitude
* @param param2: point1.longtiude
* @param param3: point2.latitude
* @param param4: point2.longitude
* @return: the euclidean distance
*/
static double EuclideanDistance(double lat1, double lng1, double lat2,
                                float lng2) {
  return sqrt((lat2 - lat1) * (lat2 - lat1) + (lng2 - lng1) * (lng2 - lng1));
}

/*
* Function Description: Get the Manhattan distance from one point to another
* @param param1: point1.latitude
* @param param2: point1.longtiude
* @param param3: point2.latitude
* @param param4: point2.longitude
* @return: the Manhattan distance
*/
static double ManhattanDistance(double lat1, double lng1, double lat2,
                                float lng2) {
  return abs(lat1 - lat2) + abs(lng1 - lng2);
}

/*
* Function Description: Get the Chebyshev distance from one point to another
* @param param1: point1.latitude
* @param param2: point1.longtiude
* @param param3: point2.latitude
* @param param4: point2.longitude
* @return: the Chebyshev distance
*/
static double ChebyshevDistance(double lat1, double lng1, double lat2,
                                float lng2) {
  return MAX(abs(lat1 - lat2), abs(lng1 - lng2));
}

static double Point2LineRatio(double lat1, double lng1, double lat2,
                              double lng2, double latp, double lngp) {
  if (lat2 == lat1 && lng2 == lng1) {
    return 0;
  }
  return ((lat1 - lat2) * (lat1 - latp) + (lng1 - lng2) * (lng1 - lngp)) /
         ((lat1 - lat2) * (lat1 - lat2) + (lng1 - lng2) * (lng1 - lng2));
}

/*
* Function Description: Get the min distance from one point to a line segment
* @param param1: point1.latitude
* @param param2: point1.longtiude
* @param param3: point2.latitude
* @param param4: point2.longitude
* @param param5: pointp.latitude
* @param param6: pointp.longitude
* @return: the distance
*/
static double Point2LineDistance(double lat1, double lng1, double lat2,
                                 double lng2, double latp, double lngp) {
  double ratio = Point2LineRatio(lat1, lng1, lat2, lng2, latp, lngp);
  if (ratio < 0) {
    return DISTANCE_FUNCTION(latp, lngp, lat1, lng1);
  } else if (ratio > 1) {
    return DISTANCE_FUNCTION(latp, lngp, lat2, lng2);
  }
  double tLat = lat1 + ratio * (lat2 - lat1);
  double tLng = lng1 + ratio * (lng2 - lng1);
  return DISTANCE_FUNCTION(latp, lngp, tLat, tLng);
}

/*
        * Function Description: Check if the rectangle can intersect with a line
        * @param 1 to 4 : The location of the rectangle
        * @param 5 to 8 : The location of the line
        * @return : If the rectangle can intersect with a line
*/
static bool IsLineIntersectRectangle(double rectangleX1, double rectangleY1,
                                     double rectangleX2, double rectangleY2,
                                     double linePointX1, double linePointY1,
                                     double linePointX2, double linePointY2) {
  double lineHeight = linePointY1 - linePointY2;
  double lineWidth = linePointX2 - linePointX1;
  double c = linePointX1 * linePointY2 - linePointX2 * linePointY1;
  if ((lineHeight * rectangleX1 + lineWidth * rectangleY2 + c >= 0 &&
       lineHeight * rectangleX2 + lineWidth * rectangleY1 + c <= 0) ||
      (lineHeight * rectangleX1 + lineWidth * rectangleY2 + c <= 0 &&
       lineHeight * rectangleX2 + lineWidth * rectangleY1 + c >= 0) ||
      (lineHeight * rectangleX1 + lineWidth * rectangleY1 + c >= 0 &&
       lineHeight * rectangleX2 + lineWidth * rectangleY2 + c <= 0) ||
      (lineHeight * rectangleX1 + lineWidth * rectangleY1 + c <= 0 &&
       lineHeight * rectangleX2 + lineWidth * rectangleY2 + c >= 0)) {
    if ((linePointX1 < rectangleX1 && linePointX2 < rectangleX1) ||
        (linePointX1 > rectangleX2 && linePointX2 > rectangleX2) ||
        (linePointY1 > rectangleY2 && linePointY2 > rectangleY2) ||
        (linePointY1 < rectangleY1 && linePointY2 < rectangleY1)) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
}

double BitToDouble(string data) {
  double result = 0;
  double tmp = 0.5;
  for (int i = 0; i < data.size(); i++) {
    result += ((data.at(i) - '0') * tmp);
  }
  tmp += 0.5;
  return result;
}

vector<unsigned char> *BoolToChar(vector<bool> *data) {
  vector<unsigned char> *result = new vector<unsigned char>();
  for (int i = 0; i < data->size(); i++) {
    result->push_back(data->at(i) ? '1' : '0');
  }
  return result;
}

double getLocationWithRatio(double a, double b, double ratios) {
  return a + (b - a) * ratios;
}

int string2int(string a) {
  double result = 0;
  int i = 0;
  for (i = 0; i < a.size(); i++) {
    result *= 10;
    result += (a[i] - '0');
  }
  return result;
}

double string2double(string a) {

  double result = 0;
  int i = 0;

  for (i = 0; i < a.size() && a[i] != '.'; i++) {
    result *= 10;
    result += (a[i] - '0');
  }

  double tmp = 0.1;

  for (i = i + 1; i < a.size(); i++) {
    result += (tmp * (a[i] - '0'));
    tmp *= 0.1;
  }

  return result;
}

char *int2time(int time) {
  char *result = new char[50];
  int hour = time / 3600;
  time %= 3600;
  int minute = time / 60;
  time %= 60;
  int second = time;
  sprintf(result, "%02d:%02d:%02d", hour, minute, second);
  return result;
}

int GetNextChar(int x, int y, string next_path, int line_length) {
  char a[10];
  int sum = 0;

  sprintf(a, "%d", x / 50);
  string path = next_path;
  path += "/next";
  path += a;
  path += ".txt";
  FILE *fp = fopen(path.c_str(), "rb");
  if (!fp) {
    printf("Open file error!\n");
    return -1;
  }
  fseek(fp, y + (x % 50) * line_length, 0);

  char ch;
  // char c[5];
  // fread(c, sizeof(unsigned char), 1, fp);
  if ((ch = fgetc(fp)) != EOF) {
    sum = ch - '0';
  }
  fclose(fp);

  return sum;
}

double abs(double a) { return (a >= 0) ? a : -a; }

double getrad(double d) {
  const double PI = 3.1415926535898;
  return d * PI / 180.0;
}

double calDistance(float fLati1, float fLong1, float fLati2, float fLong2) {
  const double EARTH_RADIUS = 6378137.0;
  double radLat1 = getrad(fLati1);
  double radLat2 = getrad(fLati2);
  double a = radLat1 - radLat2;
  double b = getrad(fLong1) - getrad(fLong2);
  double tmp = sqrt(pow(sin(a / 2), 2) +
                    cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2));
  if (tmp > 1 || tmp < -1)
    return 0;
  double s = 2 * asin(tmp);
  s = s * EARTH_RADIUS;
  return s;
}

int getDistance(double startLng, double startLat, double endLng, double endLat,
                double poiLng, double poiLat) {
  double longitude = (startLng + endLng) / 2;
  double latitude = (startLat + endLat) / 2;
  double dis = calDistance(poiLat, poiLng, latitude, longitude);
  if (dis <= 1.0) {
    return -1;
  } else if (calDistance(poiLat, poiLng, startLat, startLng) <
             calDistance(poiLat, poiLng, endLat, endLng)) {
    return 0;
  } else
    return 1;
}
double vectorProduct(double p_lat, double p_lng, double s_lat, double s_lng,
                     double e_lat, double e_lng) {
  double x1 = s_lat - p_lat;
  double y1 = s_lng - p_lng;
  double x2 = e_lat = p_lat;
  double y2 = e_lng - p_lng;
  return x1 * y2 - x2 * y1;
}
double scalarProduct(double p_lat, double p_lng, double s_lat, double s_lng,
                     double e_lat, double e_lng) {
  double x1 = s_lat - p_lat;
  double y1 = s_lng - p_lng;
  double x2 = e_lat = p_lat;
  double y2 = e_lng - p_lng;
  return x1 * x2 + y1 * y2;
}
double getDistanceFromPointToSegment(double s_lat, double s_lng, double e_lat,
                                     double e_lng, double p_lat, double p_lng) {
  double result = min(calDistance(p_lat, p_lng, s_lat, s_lng),
                      calDistance(p_lat, p_lng, e_lat, e_lng));
  if (scalarProduct(s_lat, s_lng, e_lat, e_lng, p_lat, p_lng) > 0 &&
      scalarProduct(e_lat, e_lng, s_lat, s_lng, p_lat, p_lng) > 0) {
    result = min(result,
                 fabs(vectorProduct(e_lat, e_lng, s_lat, s_lng, p_lat, p_lng) /
                      calDistance(s_lat, s_lng, e_lat, e_lng)));
  }
  return result;
}

// convertor between char and binary char
union Char2Binary {
  char value;
  unsigned char data[1];
};
union Char2Binary char2Binary;

// convertor between int and binary int
union Int2Binary {
  int value;
  unsigned char data[4];
};
union Int2Binary int2Binary;

// convertor between double and binary double
union Double2Binary {
  double value;
  unsigned char data[8];
};
union Double2Binary double2Binary;

class FileReader {
public:
  FileReader(const char *filenamme, bool isbinary) {
    this->mIsBinary = isbinary;
    this->mFilePtr = fopen(filenamme, isbinary ? "rb" : "r");
  }
  FileReader(char *filenamme, char *options, bool isbinary) {
    this->mIsBinary = isbinary;
    this->mFilePtr = fopen(filenamme, options);
  }

  char GetNextChar() {
    if (this->mIsBinary) {
      if (fread(char2Binary.data, sizeof(unsigned char), 1, this->mFilePtr) < 1)
        return EOF;
      return char2Binary.value;
    } else {
      char temp;
      if (fscanf(this->mFilePtr, "%c", &temp) == EOF) {
        return EOF;
      }
      return temp;
    }
  }

  int GetNextInt() {
    if (this->mIsBinary) {
      if (fread(int2Binary.data, sizeof(unsigned char), 4, this->mFilePtr) < 4)
        return EOF;
      return int2Binary.value;
    } else {
      int temp;
      if (fscanf(this->mFilePtr, "%d", &temp) == EOF) {
        return EOF;
      }
      return temp;
    }
  }

  double GetNextDouble() {
    if (this->mIsBinary) {
      if (fread(double2Binary.data, sizeof(unsigned char), 8, this->mFilePtr) <
          8)
        return EOF;
      return double2Binary.value;
    } else {
      double temp;
      if (fscanf(this->mFilePtr, "%lf", &temp) == EOF) {
        return EOF;
      }
      return temp;
    }
  }

  char *GetNextString() {
    char *temp = new char[256];
    if (this->mIsBinary) {
      int i = 0;
      while (fread(char2Binary.data, sizeof(unsigned char), 1, this->mFilePtr) >
             0) {
        temp[i] = (char)char2Binary.value;
        if (temp[i++] = ' ' || temp[i++] == 0 || i > 254) {
          break;
        }
      }
      if (i == 0) {
        return temp;
      }
      temp[i] = 0;
      return temp;
    } else {
      if (fscanf(this->mFilePtr, "%s", temp) == EOF) {
        return temp;
      }
      return temp;
    }
  }

  bool IsBinary() { return this->mIsBinary; }

  void Close() { fclose(this->mFilePtr); }

  ~FileReader() { fclose(this->mFilePtr); }

private:
  FILE *mFilePtr;
  bool mIsBinary;
};

class FileWriter {
public:
  FileWriter(const char *filename, bool isbinary) {
    this->mIsBinary = isbinary;
    this->mFilePtr = fopen(filename, isbinary ? "wb" : "w");
  }

  FileWriter(const char *filename, char *options, bool isbinary) {
    this->mIsBinary = isbinary;
    this->mFilePtr = fopen(filename, options);
  }
  void WriteChar(char value) {
    if (this->mIsBinary) {
      char2Binary.value = value;
      fwrite(char2Binary.data, sizeof(unsigned char), 1, this->mFilePtr);
    } else {
      fprintf(this->mFilePtr, "%c", value);
    }
  }
  void WriteInt(int value) {
    if (this->mIsBinary) {
      int2Binary.value = value;
      fwrite(int2Binary.data, sizeof(unsigned char), 4, this->mFilePtr);
    } else {
      fprintf(this->mFilePtr, "%d ", value);
    }
  }
  void WriteDouble(double value) {
    if (this->mIsBinary) {
      double2Binary.value = value;
      fwrite(double2Binary.data, sizeof(unsigned char), 8, this->mFilePtr);
    } else {
      fprintf(this->mFilePtr, "%lf ", value);
    }
  }
  bool IsBinary() { return this->mIsBinary; }
  void Close() { fclose(this->mFilePtr); }
  ~FileWriter() { fclose(this->mFilePtr); }

private:
  FILE *mFilePtr;
  bool mIsBinary;
};

class FileDir {
public:
  static FileDir *GetInstance() {
    if (instance == NULL) {
      instance = new FileDir();
    }
    return instance;
  }
  static void GetFiles(char *dir, vector<string> &files) {
    DIR *dp;
    struct dirent *entry;
    struct stat statbuf;
    if ((dp = opendir(dir)) == NULL) {
      fprintf(stderr, "cannot open directory: %s\n", dir);
      return;
    }
    int tmp = chdir(dir);
    char filename[1024];
    while ((entry = readdir(dp)) != NULL) {
      lstat(entry->d_name, &statbuf);
      if (S_ISDIR(statbuf.st_mode)) {

        if (strcmp(".", entry->d_name) == 0 || strcmp("..", entry->d_name) == 0)
          continue;

        GetFiles(entry->d_name, files);
      } else {
        sprintf(filename, "%s/%s", dir, entry->d_name);
        files.push_back(filename);
      }
    }
    tmp = chdir("..");
    closedir(dp);
  }

private:
  static FileDir *instance;
};
FileDir *FileDir::instance = NULL;

// Binary bit stream
class Binary {
public:
  int ByteNumber(int number) { return number / 8 + (number % 8 ? 1 : 0); }

  int mNumber;
  vector<bool> *mBinary;
  bool mIsEOF;

  Binary(vector<bool> *binary) {
    this->mBinary = binary;
    this->mNumber = (int)binary->size();
    mIsEOF = false;
  }

  Binary(FileReader *fr) {
    mIsEOF = false;
    this->mNumber = fr->GetNextInt();
    if (this->mNumber == EOF) {
      this->mIsEOF = true;
      return;
    }
    int tByteNumber = this->ByteNumber(this->mNumber);
    this->mBinary = new vector<bool>();
    for (int i = 0; i < tByteNumber - 1; ++i) {
      unsigned char byte = fr->GetNextChar();
      int mask = 0x80;
      for (int i = 0; i < 8; ++i) {
        this->mBinary->push_back(byte & mask);
        mask >>= 1;
      }
    }
    unsigned char byte = fr->GetNextChar();
    for (int k = (tByteNumber - 1) * 8; k < this->mNumber; k++) {
      this->mBinary->push_back(byte & MAPTABLE[k % 8]);
    }
  }

  void Store(FileWriter *fw) {

    fw->WriteInt(this->mNumber);
    int tByteNumber = this->ByteNumber(this->mNumber);

    for (int i = 0; i < tByteNumber - 1; ++i) {
      int byte = 0;
      for (int j = 0; j < 8; ++j) {
        byte = byte * 2 + (this->mBinary->at((i << 3) + j) ? 1 : 0);
      }
      fw->WriteChar((unsigned char)byte);
    }

    unsigned char byte = 0;
    for (int k = (tByteNumber - 1) * 8; k < this->mNumber; k++) {
      byte = byte | (this->mBinary->at(k) << (7 - k % 8));
    }

    fw->WriteChar(byte);
  }

  void Display() {
    cout << this->mNumber << endl;
    for (int i = 0; i < this->mNumber; ++i) {
      cout << this->mBinary->at(i) << " ";
    }
    cout << endl;
  }

  ~Binary() { delete this->mBinary; }
};
#endif
