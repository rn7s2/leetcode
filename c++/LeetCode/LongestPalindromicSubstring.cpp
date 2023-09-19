#include "LeetCode.h"

pair<int, int> naive_odd(string s) {
    int n = (int)s.size();
    s = "$" + s + "^";
    vector<int> p(n + 2);
    for (int i = 1; i <= n; i++) {
        while (s[i - p[i]] == s[i + p[i]]) {
            p[i]++;
        }
    }
    
    int max_elem = 0, idx = 1;
    for (int i = 1; i <= n; i++) {
        if (p[i] > max_elem) {
            max_elem = p[i];
            idx = i;
        }
    }
    return make_pair(max_elem - 1, idx - 1);
}

pair<int, int> naive_even(string s) {
    int n = (int)s.size();
    s = "$" + s + "^";
    vector<int> p(n + 2);
    for (int i = 1; i < n; i++) {
        while (s[i - p[i]] == s[i + 1 + p[i]]) {
            p[i]++;
        }
    }

    int max_elem = 0, idx = 1;
    for (int i = 1; i < n; i++) {
        if (p[i] > max_elem) {
            max_elem = p[i];
            idx = i;
        }
    }
    return make_pair(max_elem - 1, idx - 1);
}

class Solution {
public:
    string longestPalindrome(string s) {
        auto odd = naive_odd(s);
        auto even = naive_even(s);
        auto odd_len = 2 * odd.first + 1;
        auto even_len = 2 * even.first + 2;
        if (odd_len > even_len) {
            int center = odd.second;
            return s.substr(center - odd.first, odd_len);
        } else {
            int center = even.second;
            return s.substr(center - even.first, even_len);
        }
    }
};
