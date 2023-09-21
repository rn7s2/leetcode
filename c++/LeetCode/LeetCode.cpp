// LeetCode.cpp : Defines the entry point for the application.
//

#include "MedianOfTwoSortedArrays.cpp"

int main()
{
    Solution s;
    vector<int> nums1, nums2;

    nums1 = { 1, 2 }, nums2 = { 3 };
    cout << s.findMedianSortedArrays(nums1, nums2) << "\n";

    nums1 = { 1, 2 }, nums2 = { 3, 4 };
    cout << s.findMedianSortedArrays(nums1, nums2) << "\n";
}
