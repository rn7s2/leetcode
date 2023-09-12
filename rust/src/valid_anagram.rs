use crate::Solution;

use std::collections::HashMap;

impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        fn get_string_map(s: String) -> HashMap<char, i32> {
            let mut ms = HashMap::new();

            for v in s.chars() {
                match ms.get_mut(&v) {
                    Some(v) => {
                        *v += 1;
                    }
                    None => {
                        ms.insert(v, 1);
                    }
                }
            }

            ms
        }

        if s.len() != t.len() {
            return false;
        }
        let (ms, mt) = (get_string_map(s), get_string_map(t));
        ms == mt
    }
}
