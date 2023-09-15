#include "LeetCode.h"

class Solution {
public:
    int prim(const vector<vector<int>>& points) {
        int n = points.size();

        int u = 0, ans = 0;
        vector<bool> vis(n, false);
        vector<int> dis(n, INT_MAX);
        vis[u] = true, dis[u] = 0;

        while (true) {
            int min_dis = INT_MAX, min_idx = -1;
            for (int j = 0; j < n; j++) {
                if (vis[j]) {
                    continue;
                }
                int d = abs(points[u][0] - points[j][0]) + abs(points[u][1] - points[j][1]);
                dis[j] = min(dis[j], d);

                if (dis[j] < min_dis) {
                    min_dis = dis[j];
                    min_idx = j;
                }
            }

            if (min_idx < 0)
                break;

            u = min_idx;
            vis[min_idx] = true;
            ans += min_dis;
        }

        return ans;
    }

    int minCostConnectPoints(vector<vector<int>>& points) {
        return prim(points);
    }
};
