mod top_k_frequent_elements;

pub struct Solution;

fn main() {
    println!(
        "{:?}",
        Solution::top_k_frequent(vec![4, 1, -1, 2, -1, 2, 3], 2)
    );
}
