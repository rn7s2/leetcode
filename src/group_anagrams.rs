use crate::Solution;

use std::collections::HashMap;
use std::iter::FromIterator;

impl Solution {
    pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
        let mut table: HashMap<String, Vec<String>> = HashMap::with_capacity(strs.len());

        for s in strs.iter() {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort();
            let sorted = String::from_iter(chars);

            match table.get_mut(&sorted) {
                Some(v) => v.push(s.clone()),
                None => {
                    table.insert(sorted, vec![s.clone()]);
                }
            }
        }

        table.values().cloned().collect::<Vec<Vec<String>>>()
    }
}
