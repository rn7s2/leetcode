use crate::Solution;

impl Solution {
    pub fn product_except_self(nums: Vec<i32>) -> Vec<i32> {
        if nums.len() == 0 {
            return vec![];
        }

        let mut prefix_prod = vec![0; nums.len()];
        let mut suffix_prod = vec![0; nums.len()];

        prefix_prod[0] = nums[0];
        suffix_prod[nums.len() - 1] = nums[nums.len() - 1];
        for i in 1..nums.len() {
            prefix_prod[i] = prefix_prod[i - 1] * nums[i];
        }
        for i in (0..nums.len() - 1).rev() {
            suffix_prod[i] = suffix_prod[i + 1] * nums[i];
        }

        let mut result = vec![0; nums.len()];
        result[0] = suffix_prod[1];
        result[nums.len() - 1] = prefix_prod[nums.len() - 2];
        for i in 1..nums.len() - 1 {
            result[i] = prefix_prod[i - 1] * suffix_prod[i + 1]
        }

        result
    }
}
