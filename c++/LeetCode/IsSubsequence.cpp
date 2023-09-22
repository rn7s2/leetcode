#include "LeetCode.h"

class Solution {
public:
    bool isSubsequence(string s, string t) {
        int i = 0, j = 0, n = s.length(), m = t.length();
        if (n > m)
            return false;

        for (i = 0; i < n; i++, j++) {
            if (s[i] == t[j])
                continue;
            while (j < m && s[i] != t[j])
                j++;
            if (j >= m)
                return false;
        }
        return i == n;
    }
};
