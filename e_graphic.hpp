#ifndef __EGRAPHIC_HPP__
#define __EGRAPHIC_HPP__

#include "e_tool.hpp"
#include <iostream>
#include <vector>
using namespace std;

class Node;
class Edge {
public:
  Edge();
  Edge(int id, Node *startNode, Node *endNode);
  void SetLength(double length);
  void SetLength();
  double GetLength();
  void SetId(int id);
  int GetId();
  void SetStartNode(Node *startNode);
  Node *GetStartNode();
  void SetEndNode(Node *endNode);
  Node *GetEndNode();
  void SetEdgeGeometry(vector<Node *> edgeGeometry);
  vector<Node *> GetEdgeGeometry();
  void Display();
  int GetGeometrySize();
  void SetGeometrySize(int geometrySize);
  void AppendGeometry(Node *point);
  ~Edge();

  int mId;
  Node *mStartNode, *mEndNode;
  vector<Node *> mEdgeGeometry;
  int mGeometrySize;
  double mLength;
};

class Node {
public:
  Node();
  Node(int id, double longitude, double latitude);
  void AppendOutEdge(Edge *e);
  void SetId(int id);
  int GetId();
  void SetEdgeNumber(int mEdgeNumber);
  int GetEdgeNumber();
  void SetLongitude(double longitude);
  double GetLongitude();
  void SetLatitude(double latitude);
  double GetLatitude();
  void SetOutEdges(vector<Edge *> outEdges);
  vector<Edge *> GetOutEdges();
  Edge *GetOutEdgeById(int id);
  void Display();
  ~Node();

private:
  int mId;
  double mLongitude;
  double mLatitude;
  int mEdgeNumber;
  vector<Edge *> mOutEdges;
};

class Graphic {
public:
  Graphic();
  void SetEdgeNumber(int mEdgeNumber);
  vector<Node *> GetNodesList();
  int GetEdgeNumber();
  void SetNodeNumber(int mNodeNumber);
  int GetNodeNumber();
  void AppendNode(Node *newNode);
  void AppendEdge(Edge *newEdge);
  Node *GetNodeById(int id);
  Edge *GetEdgeById(int id);
  void InitGraphic();
  void Display();
  ~Graphic();

private:
  int mEdgeNumber;
  vector<Edge *> mEdgeList;
  int mNodeNumber;
  vector<Node *> mNodeList;
};

Edge::Edge() {
  this->mId = -1;
  this->mStartNode = NULL;
  this->mEndNode = NULL;
  this->mEdgeGeometry.clear();
}

Edge::Edge(int id, Node *startNode, Node *endNode) {
  this->mId = id;
  this->mStartNode = startNode;
  this->mEndNode = endNode;
  this->mEdgeGeometry.clear();
}

void Edge::SetLength() {
  this->SetLength(0);
  for (int i = 1; i < this->GetGeometrySize(); ++i) {
    this->mLength += calDistance(this->mEdgeGeometry[i - 1]->GetLatitude(),
                                 this->mEdgeGeometry[i - 1]->GetLongitude(),
                                 this->mEdgeGeometry[i]->GetLatitude(),
                                 this->mEdgeGeometry[i]->GetLongitude());
  }
}

int Edge::GetGeometrySize() { return this->mEdgeGeometry.size(); }

void Edge::SetGeometrySize(int geometrySize) {
  this->mGeometrySize = geometrySize;
}

void Edge::AppendGeometry(Node *point) {
  this->mGeometrySize++;
  this->mEdgeGeometry.push_back(point);
}

void Edge::SetLength(double length) { this->mLength = length; }

double Edge::GetLength() { return this->mLength; }

void Edge::SetId(int id) { this->mId = id; }

int Edge::GetId() { return this->mId; }

void Edge::SetStartNode(Node *startNode) { this->mStartNode = startNode; }

Node *Edge::GetStartNode() { return this->mStartNode; }

void Edge::SetEndNode(Node *endNode) { this->mEndNode = endNode; }

Node *Edge::GetEndNode() { return this->mEndNode; }

void Edge::SetEdgeGeometry(vector<Node *> edgeGeometry) {
  this->mEdgeGeometry = edgeGeometry;
}

vector<Node *> Edge::GetEdgeGeometry() { return this->mEdgeGeometry; }

void Edge::Display() {
  cout << "Edge ID:" << this->GetId() << endl;
  cout << "\tstart Node:" << this->GetStartNode()->GetId() << endl;
  cout << "\tend Node:" << this->GetEndNode()->GetId() << endl;
}

Edge::~Edge() {
  this->mStartNode = NULL;
  this->mEndNode = NULL;
  for (int i = 0; i < this->mEdgeGeometry.size(); i++) {
    delete this->mEdgeGeometry[i];
  }
  this->mEdgeGeometry.clear();
}

Node::Node() {
  this->mId = -1;
  this->mLongitude = 0;
  this->mLatitude = 0;
  this->mOutEdges.clear();
  this->mEdgeNumber = 0;
}

Node::Node(int id, double longitude, double latitude) {
  this->mId = id;
  this->mLongitude = longitude;
  this->mLatitude = latitude;
  this->mOutEdges.clear();
  this->mEdgeNumber = 0;
}

void Node::AppendOutEdge(Edge *e) {
  ++this->mEdgeNumber;
  this->mOutEdges.push_back(e);
}

void Node::SetId(int id) { this->mId = id; }

int Node::GetId() { return this->mId; }

void Node::SetEdgeNumber(int mEdgeNumber) { this->mEdgeNumber = mEdgeNumber; }

int Node::GetEdgeNumber() { return this->mEdgeNumber; }

void Node::SetLongitude(double longitude) { this->mLongitude = longitude; }

double Node::GetLongitude() { return this->mLongitude; }

void Node::SetLatitude(double latitude) { this->mLatitude = latitude; }

double Node::GetLatitude() { return this->mLatitude; }

Edge *Node::GetOutEdgeById(int id) { return this->mOutEdges.at(id); }

void Node::SetOutEdges(vector<Edge *> outEdges) { this->mOutEdges = outEdges; }

vector<Edge *> Node::GetOutEdges() { return this->mOutEdges; }

void Node::Display() {
  cout << "Node ID:" << this->GetId() << endl;
  cout << "(" << this->GetLatitude() << "," << this->GetLongitude() << ")"
       << endl;
  for (int i = 0; i < this->GetEdgeNumber(); i++) {
    this->GetOutEdgeById(i)->Display();
  }
}

Node::~Node() {
  this->mId = -1;
  this->mEdgeNumber = 0;
  this->mOutEdges.clear();
}

Graphic::Graphic() {
  this->mEdgeNumber = 0;
  this->mNodeNumber = 0;
  this->mEdgeList.clear();
  this->mNodeList.clear();
}

void Graphic::SetEdgeNumber(int mEdgeNumber) {
  this->mEdgeNumber = mEdgeNumber;
}

int Graphic::GetEdgeNumber() { return this->mEdgeNumber; }

void Graphic::SetNodeNumber(int mNodeNumber) {
  this->mNodeNumber = mNodeNumber;
}

int Graphic::GetNodeNumber() { return this->mNodeNumber; }

void Graphic::AppendNode(Node *newNode) {
  this->mNodeList.push_back(newNode);
  this->mNodeNumber++;
}

void Graphic::AppendEdge(Edge *newEdge) {
  this->mEdgeList.push_back(newEdge);
  this->mEdgeNumber++;
}

Node *Graphic::GetNodeById(int id) {
  if (this->mNodeList.at(id)->GetId() == id) {
    return this->mNodeList.at(id);
  } else {
    for (int i = 0; i < this->mNodeNumber; ++i) {
      if (this->mNodeList.at(id)->GetId() == id) {
        return this->mNodeList.at(id);
      }
    }
  }
  return NULL;
}

Edge *Graphic::GetEdgeById(int id) { return this->mEdgeList.at(id); }

void Graphic::Display() {
  cout << "Edge Number:" << this->GetEdgeNumber() << endl;
  cout << "Node Number:" << this->GetNodeNumber() << endl;
}

Graphic::~Graphic() {
  this->mNodeNumber = 0;
  this->mEdgeNumber = 0;
  int i;
  for (i = 0; i < this->mNodeList.size(); i++) {
    delete this->mNodeList[i];
  }
  for (i = 0; i < this->mEdgeList.size(); i++) {
    delete this->mEdgeList[i];
  }
  this->mNodeList.clear();
  this->mEdgeList.clear();
}

void Graphic::InitGraphic() {
  FILE *nodes, *edges, *edgeGeometry;
  nodes = fopen(NODE_PATH.c_str(), "r");
  edges = fopen(EDGE_PATH.c_str(), "r");
  edgeGeometry = fopen(GEO_PATH.c_str(), "r");
  if (!nodes) {
    cout << NODE_PATH << "打开失败！" << endl;
    return;
  }
  if (!edges) {
    cout << EDGE_PATH << "打开失败！" << endl;
    return;
  }
  if (!edgeGeometry) {
    cout << EDGE_PATH << "打开失败！" << endl;
    return;
  }
  int id = 0;
  double longitude = 0, latitude = 0;
  char ch;
  while ((ch = fgetc(nodes)) != EOF) {
    id *= 10;
    id += (ch - '0');
    while ((ch = fgetc(nodes)) != ' ') {
      id *= 10;
      id += (ch - '0');
    }
    while ((ch = fgetc(nodes)) != '.') {
      latitude *= 10;
      latitude += (ch - '0');
    }
    double tmp = 0.1;
    while ((ch = fgetc(nodes)) != ' ') {
      latitude += tmp * (ch - '0');
      tmp *= 0.1;
    }
    // cout<<latitude<<endl;
    while ((ch = fgetc(nodes)) != '.') {
      longitude *= 10;
      longitude += (ch - '0');
    }
    tmp = 0.1;
    while ((ch = fgetc(nodes)) != '\n' && ch != '\r') {
      longitude += tmp * (ch - '0');
      tmp *= 0.1;
    }
    fgetc(nodes);
    Node *node = new Node(id, longitude, latitude);
    this->AppendNode(node);
    id = 0;
    latitude = longitude = 0;
  }
  // cout << "Node inition is OK!" << endl;
  id = 0;
  int start = 0, end = 0;
  while ((ch = fgetc(edges)) != EOF) {
    id *= 10;
    id += (ch - '0');
    while ((ch = fgetc(edges)) != ' ') {
      id *= 10;
      id += (ch - '0');
    }
    while ((ch = fgetc(edges)) != ' ') {
      start *= 10;
      start += (ch - '0');
    }
    while ((ch = fgetc(edges)) != '\n' && ch != '\r') {
      end *= 10;
      end += (ch - '0');
    }
    fgetc(edges);
    Edge *edge = new Edge(id, this->GetNodeById(start), this->GetNodeById(end));
    this->AppendEdge(edge);
    this->GetNodeById(start)->AppendOutEdge(edge);
    id = 0;
    start = end = 0;
  }
  // cout << "Edge inition is OK!" << endl;
  int tmpId = 0;
  double tmpLat = 0, tmpLng = 0;
  while ((ch = fgetc(edgeGeometry)) != EOF) {
    tmpId *= 10;
    tmpId += (ch - '0');
    while ((ch = fgetc(edgeGeometry)) != '^') {
      tmpId *= 10;
      tmpId += (ch - '0');
    }
    Edge *tmpEdge = this->GetEdgeById(tmpId);

    ch = fgetc(edgeGeometry);
    while ((ch = fgetc(edgeGeometry)) != '^') {
    }
    ch = fgetc(edgeGeometry);
    ch = fgetc(edgeGeometry);
    while ((ch = fgetc(edgeGeometry)) != '\n' && ch != '\r') {
      tmpLat *= 10;
      tmpLat += (ch - '0');
      while ((ch = fgetc(edgeGeometry)) != '.') {
        tmpLat *= 10;
        tmpLat += (ch - '0');
      }
      double tmp = 0.1;
      while ((ch = fgetc(edgeGeometry)) != '^') {
        tmpLat += (ch - '0') * tmp;
        tmp *= 0.1;
      }
      while ((ch = fgetc(edgeGeometry)) != '.') {
        tmpLng *= 10;
        tmpLng += (ch - '0');
      }
      tmp = 0.1;
      while ((ch = fgetc(edgeGeometry)) != '^' && ch != '\n' && ch != '\r') {
        tmpLng += (ch - '0') * tmp;
        tmp *= 0.1;
      }
      tmpEdge->AppendGeometry(new Node(-1, tmpLng, tmpLat));
      tmpLat = tmpLng = 0;
      if (ch == '\n' || ch == '\r') {
        fgetc(edgeGeometry);
        break;
      }
    }
    tmpEdge->SetLength();
    tmpId = 0;
    tmpLat = tmpLng = 0;
  }
  // cout << "edgeGeometry inition is OK!" << endl;
  fclose(nodes);
  fclose(edges);
  fclose(edgeGeometry);
}

vector<Node *> Graphic::GetNodesList() { return this->mNodeList; }

Graphic *gGraph = NULL;

#endif
