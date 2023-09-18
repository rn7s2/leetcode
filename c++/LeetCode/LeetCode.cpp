// LeetCode.cpp : Defines the entry point for the application.
//

#include "TheKWeakestRowsInAMatrix.cpp"

template<typename T>
void dumpVector(const vector<T>& v)
{
    for (const auto& e : v) {
        cout << e << " ";
    }
    cout << "\n";
}

int main()
{
    Solution s;

    vector<vector<int>> case0{ {{1,1,0,0,0},
                                {1,1,1,1,0},
                                {1,0,0,0,0},
                                {1,1,0,0,0},
                                {1,1,1,1,1}} };
    dumpVector(s.kWeakestRows(case0, 3));

    vector<vector<int>> case1{ {{1,0,0,0},
                                {1,1,1,1},
                                {1,0,0,0},
                                {1,0,0,0}} };
    dumpVector(s.kWeakestRows(case1, 2));
}
