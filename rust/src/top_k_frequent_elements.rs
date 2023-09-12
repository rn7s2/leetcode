use crate::Solution;

use std::collections::HashMap;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        // collects freqs.
        let mut map = HashMap::new();
        for num in &nums {
            match map.get_mut(num) {
                Some(v) => *v += 1,
                None => {
                    map.insert(*num, 1usize);
                }
            }
        }

        // bucker[i] stores numbers that appears i time(s).
        let mut bucket = vec![vec![]; nums.len() + 1];
        for (num, freq) in map.iter() {
            bucket[*freq].push(*num);
        }

        // collects most frequent numbers.
        let mut cnt = 0;
        let mut result = vec![];
        for i in (1..nums.len() + 1).rev() {
            if bucket[i].len() == 0 {
                continue;
            }

            for num in bucket[i].iter() {
                result.push(*num);
                cnt += 1;
                if cnt >= k {
                    return result;
                }
            }
        }

        result
    }
}
