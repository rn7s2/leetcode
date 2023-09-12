use crate::Solution;

use std::collections::HashSet;

impl Solution {
    pub fn contains_duplicate(nums: Vec<i32>) -> bool {
        let mut set = HashSet::new();
        for &v in nums.iter() {
            if set.contains(&v) {
                return true;
            }
            set.insert(v);
        }
        false
    }
}
