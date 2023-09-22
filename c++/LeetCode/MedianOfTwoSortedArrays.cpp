#include "LeetCode.h"

class Solution {
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        if (nums1.size() > nums2.size()) {
            swap(nums1, nums2);
        }

        int n = (int)nums1.size(), m = (int)nums2.size();
        int l = 0, r = n, median1 = 0, median2 = 0;
        while (l <= r) {
            int i = (l + r) / 2;
            int j = (n + m + 1) / 2 - i;
            
            int left_a_max = (i == 0 ? INT_MIN : nums1[i - 1]);
            int right_a_min = (i == n ? INT_MAX : nums1[i]);
            int left_b_max = (j == 0 ? INT_MIN : nums2[j - 1]);
            int right_b_min = (j == m ? INT_MAX : nums2[j]);

            if (left_a_max <= right_b_min) {
                median1 = max(left_a_max, left_b_max);
                median2 = min(right_a_min, right_b_min);
                l = i + 1;
            } else {
                r = i - 1;
            }
        }

        int i = l, j = (n + m + 1) / 2 - i;
        if ((n + m) % 2 == 1) {
            return median1;
        } else {
            return (median1 + median2) / 2.0;
        }
    }
};
