mod valid_anagram;

pub struct Solution;

fn main() {
    println!(
        "{}",
        Solution::is_anagram("rat".to_string(), "arc".to_string())
    );
}
