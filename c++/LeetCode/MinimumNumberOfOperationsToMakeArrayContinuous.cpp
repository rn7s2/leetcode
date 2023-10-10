#include "LeetCode.h"

// 将一个长度为 n 的列表的数字映射到 [x, x + n) 区间之中，要求映射值与原序列不同的个数最少
// 考虑先求与原序列相同的映射值的个数。由于重复的数字一定会被分配新的映射值，所以仅需要考虑
// 对所有不重复的数字，在最好的情况下能有多少数字不变。双指针遍历所有可能的区间情况，求出最优值

class Solution
{
public:
    int minOperations(vector<int> &nums) {
        int n = (int)nums.size();
        sort(nums.begin(), nums.end());
        
        int unique_len = 1;
        for (int i = 1; i < n; ++i) {
            if (nums[i] != nums[i - 1]) {
                nums[unique_len++] = nums[i];
            }
        }

        int ans = n;
        for (int i = 0, j = 0; i < unique_len; ++i) {
            while (j < unique_len && nums[j] - nums[i] <= n - 1) {
                ++j;
            }
            ans = min(ans, n - (j - i));
        }

        return ans;
    }
};
