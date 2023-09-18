#include "LeetCode.h"

class Solution {
public:
    vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
        int n = (int)mat.size();
        priority_queue<pair<int, int>> Q;
        
        for (int i = 0; i < n; i++) {
            const auto& v = mat[i];
            auto sum = std::reduce(v.begin(), v.end());
            Q.push(make_pair(-sum, -i));
        }
        
        vector<int> result(k);
        for (int i = 0; i < k; i++) {
            result[i] = -Q.top().second;
            Q.pop();
        }
        return result;
    }
};
