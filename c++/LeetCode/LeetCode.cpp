// LeetCode.cpp : Defines the entry point for the application.
//

#include "MinCostToConnectAllPoints.cpp"

int main()
{
    Solution s;

    vector<vector<int>> case0{ {{5, 2}, {2, 2}, {7, 0}, {3, 10}, {0, 0}} };
    cout << s.minCostConnectPoints(case0) << "\n";

    vector<vector<int>> case1{ {{3, 12}, {-2, 5}, {-4, 1}} };
    cout << s.minCostConnectPoints(case1) << "\n";
}
