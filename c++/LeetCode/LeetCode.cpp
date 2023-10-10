// LeetCode.cpp : Defines the entry point for the application.
//

#include "MinimumNumberOfOperationsToMakeArrayContinuous.cpp"

int main()
{
    Solution s;
    
    vector<int> nums = { 4, 2, 5, 3 };
    cout << s.minOperations(nums) << endl;
    
    nums = { 1, 2, 3, 5, 6 };
    cout << s.minOperations(nums) << endl;
    
    nums = { 1, 10, 100, 1000 };
    cout << s.minOperations(nums) << endl;
    
    nums = { 8, 5, 9, 9, 8, 4 };
    cout << s.minOperations(nums) << endl;

    nums = {41, 33, 29, 33, 35, 26, 47, 24, 18, 28};
    cout << s.minOperations(nums) << endl;
}
