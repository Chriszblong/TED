#ifndef __EHEADER_H__
#define __EHEADER_H__

#include <iostream>
#include <string>
using namespace std;

/*
* The parameters in the graph
*/
static string EDGE_PATH = "";
static string NODE_PATH = "";
static string GEO_PATH = "";

/*
* The threshold int l-coding
*/
static double THRESHOLD_VALUE = 1.0;

/*
* The line's length in the next table
*/
static int LINE_LENGTH = 0;

/*
* The next table's path
*/
static string NEXT_PATH = "";

/*
* The time recording file's path
*/
static string TIME_FILE = "";

/*
* The depth of the partitioin index
*/
static int DIVID_NUM = 6;

/*
* The number of entry of graph in pcoding
*/
static int ENTRY_NUM = 3;

/*
* The radius of earth, which can be used in the GPS distance function
*/
const double EARTH_RADIUS = 6378137.0;

/*
* The distance funtion
* such as GPSDistance, EuclideanDistance, ManhattanDistance, ChebyshevDistance,
* and so on
*/
#define DISTANCE_FUNCTION EuclideanDistance

/*
* Map table to due the binary
*/
unsigned char MAPTABLE[8] = {128, 64, 32, 16, 8, 4, 2, 1};

static string query_result_file_path="";

#endif
