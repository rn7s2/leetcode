module MaxDotProductOfTwoSubsequences

let maxDotProduct (nums1: list<int>) (nums2: list<int>) : int =
    let mutable dp = Array2D.zeroCreate nums1.Length nums2.Length

    for i in 0 .. nums1.Length - 1 do
        for j in 0 .. nums2.Length - 1 do
            let maxProd =
                let prod = nums1[i] * nums2[j]

                if i > 0 && j > 0 then
                    max (dp[i - 1, j - 1] + prod) prod
                else
                    prod

            let maxProd = if i > 0 then max maxProd dp[i - 1, j] else maxProd
            let maxProd = if j > 0 then max maxProd dp[i, j - 1] else maxProd
            dp[i, j] <- maxProd

    dp[nums1.Length - 1, nums2.Length - 1]
