---@class lc.ProblemListEntry
---@field title_slug string
---@field tags string[]

---@class lc.ProblemList
---@field name string
---@field problems lc.ProblemListEntry[]

---@class lc.ProblemLists
local M = {}

M.lists = {
    blind75 = {
        name = "Blind 75",
        problems = {
            -- Arrays & Hashing
            { title_slug = "two-sum", tags = { "Arrays & Hashing" } },
            { title_slug = "contains-duplicate", tags = { "Arrays & Hashing" } },
            { title_slug = "valid-anagram", tags = { "Arrays & Hashing" } },
            { title_slug = "group-anagrams", tags = { "Arrays & Hashing" } },
            { title_slug = "top-k-frequent-elements", tags = { "Arrays & Hashing" } },
            { title_slug = "product-of-array-except-self", tags = { "Arrays & Hashing" } },
            { title_slug = "longest-consecutive-sequence", tags = { "Arrays & Hashing" } },

            -- Two Pointers
            { title_slug = "valid-palindrome", tags = { "Two Pointers" } },
            { title_slug = "3sum", tags = { "Two Pointers" } },
            { title_slug = "container-with-most-water", tags = { "Two Pointers" } },

            -- Sliding Window
            { title_slug = "best-time-to-buy-and-sell-stock", tags = { "Sliding Window" } },
            { title_slug = "longest-substring-without-repeating-characters", tags = { "Sliding Window" } },
            { title_slug = "longest-repeating-character-replacement", tags = { "Sliding Window" } },
            { title_slug = "minimum-window-substring", tags = { "Sliding Window" } },

            -- Stack
            { title_slug = "valid-parentheses", tags = { "Stack" } },

            -- Binary Search
            { title_slug = "find-minimum-in-rotated-sorted-array", tags = { "Binary Search" } },
            { title_slug = "search-in-rotated-sorted-array", tags = { "Binary Search" } },

            -- Linked List
            { title_slug = "reverse-linked-list", tags = { "Linked List" } },
            { title_slug = "merge-two-sorted-lists", tags = { "Linked List" } },
            { title_slug = "reorder-list", tags = { "Linked List" } },
            { title_slug = "remove-nth-node-from-end-of-list", tags = { "Linked List" } },
            { title_slug = "linked-list-cycle", tags = { "Linked List" } },
            { title_slug = "merge-k-sorted-lists", tags = { "Linked List" } },

            -- Trees
            { title_slug = "invert-binary-tree", tags = { "Trees" } },
            { title_slug = "maximum-depth-of-binary-tree", tags = { "Trees" } },
            { title_slug = "same-tree", tags = { "Trees" } },
            { title_slug = "subtree-of-another-tree", tags = { "Trees" } },
            { title_slug = "lowest-common-ancestor-of-a-binary-search-tree", tags = { "Trees" } },
            { title_slug = "binary-tree-level-order-traversal", tags = { "Trees" } },
            { title_slug = "validate-binary-search-tree", tags = { "Trees" } },
            { title_slug = "kth-smallest-element-in-a-bst", tags = { "Trees" } },
            { title_slug = "construct-binary-tree-from-preorder-and-inorder-traversal", tags = { "Trees" } },
            { title_slug = "binary-tree-maximum-path-sum", tags = { "Trees" } },
            { title_slug = "serialize-and-deserialize-binary-tree", tags = { "Trees" } },

            -- Tries
            { title_slug = "implement-trie-prefix-tree", tags = { "Tries" } },
            { title_slug = "design-add-and-search-words-data-structure", tags = { "Tries" } },
            { title_slug = "word-search-ii", tags = { "Tries" } },

            -- Heap / Priority Queue
            { title_slug = "find-median-from-data-stream", tags = { "Heap / Priority Queue" } },

            -- Backtracking
            { title_slug = "combination-sum", tags = { "Backtracking" } },
            { title_slug = "word-search", tags = { "Backtracking" } },

            -- Graphs
            { title_slug = "number-of-islands", tags = { "Graphs" } },
            { title_slug = "clone-graph", tags = { "Graphs" } },
            { title_slug = "pacific-atlantic-water-flow", tags = { "Graphs" } },
            { title_slug = "course-schedule", tags = { "Graphs" } },
            { title_slug = "graph-valid-tree", tags = { "Graphs" } },
            { title_slug = "number-of-connected-components-in-an-undirected-graph", tags = { "Graphs" } },

            -- Advanced Graphs
            { title_slug = "alien-dictionary", tags = { "Advanced Graphs" } },

            -- 1-D Dynamic Programming
            { title_slug = "climbing-stairs", tags = { "1-D DP" } },
            { title_slug = "house-robber", tags = { "1-D DP" } },
            { title_slug = "house-robber-ii", tags = { "1-D DP" } },
            { title_slug = "longest-palindromic-substring", tags = { "1-D DP" } },
            { title_slug = "palindromic-substrings", tags = { "1-D DP" } },
            { title_slug = "decode-ways", tags = { "1-D DP" } },
            { title_slug = "coin-change", tags = { "1-D DP" } },
            { title_slug = "maximum-product-subarray", tags = { "1-D DP" } },
            { title_slug = "word-break", tags = { "1-D DP" } },
            { title_slug = "longest-increasing-subsequence", tags = { "1-D DP" } },

            -- 2-D Dynamic Programming
            { title_slug = "unique-paths", tags = { "2-D DP" } },
            { title_slug = "longest-common-subsequence", tags = { "2-D DP" } },

            -- Greedy
            { title_slug = "maximum-subarray", tags = { "Greedy" } },
            { title_slug = "jump-game", tags = { "Greedy" } },

            -- Intervals
            { title_slug = "insert-interval", tags = { "Intervals" } },
            { title_slug = "merge-intervals", tags = { "Intervals" } },
            { title_slug = "non-overlapping-intervals", tags = { "Intervals" } },
            { title_slug = "meeting-rooms", tags = { "Intervals" } },
            { title_slug = "meeting-rooms-ii", tags = { "Intervals" } },

            -- Math & Geometry
            { title_slug = "rotate-image", tags = { "Math & Geometry" } },
            { title_slug = "spiral-matrix", tags = { "Math & Geometry" } },
            { title_slug = "set-matrix-zeroes", tags = { "Math & Geometry" } },

            -- Bit Manipulation
            { title_slug = "number-of-1-bits", tags = { "Bit Manipulation" } },
            { title_slug = "counting-bits", tags = { "Bit Manipulation" } },
            { title_slug = "reverse-bits", tags = { "Bit Manipulation" } },
            { title_slug = "missing-number", tags = { "Bit Manipulation" } },
            { title_slug = "sum-of-two-integers", tags = { "Bit Manipulation" } },
        },
    },

    neetcode150 = {
        name = "NeetCode 150",
        problems = {
            -- Arrays & Hashing
            { title_slug = "two-sum", tags = { "Arrays & Hashing" } },
            { title_slug = "contains-duplicate", tags = { "Arrays & Hashing" } },
            { title_slug = "valid-anagram", tags = { "Arrays & Hashing" } },
            { title_slug = "group-anagrams", tags = { "Arrays & Hashing" } },
            { title_slug = "top-k-frequent-elements", tags = { "Arrays & Hashing" } },
            { title_slug = "encode-and-decode-strings", tags = { "Arrays & Hashing" } },
            { title_slug = "product-of-array-except-self", tags = { "Arrays & Hashing" } },
            { title_slug = "valid-sudoku", tags = { "Arrays & Hashing" } },
            { title_slug = "longest-consecutive-sequence", tags = { "Arrays & Hashing" } },

            -- Two Pointers
            { title_slug = "valid-palindrome", tags = { "Two Pointers" } },
            { title_slug = "two-sum-ii-input-array-is-sorted", tags = { "Two Pointers" } },
            { title_slug = "3sum", tags = { "Two Pointers" } },
            { title_slug = "container-with-most-water", tags = { "Two Pointers" } },
            { title_slug = "trapping-rain-water", tags = { "Two Pointers" } },

            -- Sliding Window
            { title_slug = "best-time-to-buy-and-sell-stock", tags = { "Sliding Window" } },
            { title_slug = "longest-substring-without-repeating-characters", tags = { "Sliding Window" } },
            { title_slug = "longest-repeating-character-replacement", tags = { "Sliding Window" } },
            { title_slug = "permutation-in-string", tags = { "Sliding Window" } },
            { title_slug = "minimum-window-substring", tags = { "Sliding Window" } },
            { title_slug = "sliding-window-maximum", tags = { "Sliding Window" } },

            -- Stack
            { title_slug = "valid-parentheses", tags = { "Stack" } },
            { title_slug = "min-stack", tags = { "Stack" } },
            { title_slug = "evaluate-reverse-polish-notation", tags = { "Stack" } },
            { title_slug = "generate-parentheses", tags = { "Stack" } },
            { title_slug = "daily-temperatures", tags = { "Stack" } },
            { title_slug = "car-fleet", tags = { "Stack" } },
            { title_slug = "largest-rectangle-in-histogram", tags = { "Stack" } },

            -- Binary Search
            { title_slug = "binary-search", tags = { "Binary Search" } },
            { title_slug = "search-a-2d-matrix", tags = { "Binary Search" } },
            { title_slug = "koko-eating-bananas", tags = { "Binary Search" } },
            { title_slug = "find-minimum-in-rotated-sorted-array", tags = { "Binary Search" } },
            { title_slug = "search-in-rotated-sorted-array", tags = { "Binary Search" } },
            { title_slug = "time-based-key-value-store", tags = { "Binary Search" } },
            { title_slug = "median-of-two-sorted-arrays", tags = { "Binary Search" } },

            -- Linked List
            { title_slug = "reverse-linked-list", tags = { "Linked List" } },
            { title_slug = "merge-two-sorted-lists", tags = { "Linked List" } },
            { title_slug = "reorder-list", tags = { "Linked List" } },
            { title_slug = "remove-nth-node-from-end-of-list", tags = { "Linked List" } },
            { title_slug = "copy-list-with-random-pointer", tags = { "Linked List" } },
            { title_slug = "add-two-numbers", tags = { "Linked List" } },
            { title_slug = "linked-list-cycle", tags = { "Linked List" } },
            { title_slug = "find-the-duplicate-number", tags = { "Linked List" } },
            { title_slug = "lru-cache", tags = { "Linked List" } },
            { title_slug = "merge-k-sorted-lists", tags = { "Linked List" } },
            { title_slug = "reverse-nodes-in-k-group", tags = { "Linked List" } },

            -- Trees
            { title_slug = "invert-binary-tree", tags = { "Trees" } },
            { title_slug = "maximum-depth-of-binary-tree", tags = { "Trees" } },
            { title_slug = "diameter-of-binary-tree", tags = { "Trees" } },
            { title_slug = "balanced-binary-tree", tags = { "Trees" } },
            { title_slug = "same-tree", tags = { "Trees" } },
            { title_slug = "subtree-of-another-tree", tags = { "Trees" } },
            { title_slug = "lowest-common-ancestor-of-a-binary-search-tree", tags = { "Trees" } },
            { title_slug = "binary-tree-level-order-traversal", tags = { "Trees" } },
            { title_slug = "binary-tree-right-side-view", tags = { "Trees" } },
            { title_slug = "count-good-nodes-in-binary-tree", tags = { "Trees" } },
            { title_slug = "validate-binary-search-tree", tags = { "Trees" } },
            { title_slug = "kth-smallest-element-in-a-bst", tags = { "Trees" } },
            { title_slug = "construct-binary-tree-from-preorder-and-inorder-traversal", tags = { "Trees" } },
            { title_slug = "binary-tree-maximum-path-sum", tags = { "Trees" } },
            { title_slug = "serialize-and-deserialize-binary-tree", tags = { "Trees" } },

            -- Tries
            { title_slug = "implement-trie-prefix-tree", tags = { "Tries" } },
            { title_slug = "design-add-and-search-words-data-structure", tags = { "Tries" } },
            { title_slug = "word-search-ii", tags = { "Tries" } },

            -- Heap / Priority Queue
            { title_slug = "kth-largest-element-in-a-stream", tags = { "Heap / Priority Queue" } },
            { title_slug = "last-stone-weight", tags = { "Heap / Priority Queue" } },
            { title_slug = "k-closest-points-to-origin", tags = { "Heap / Priority Queue" } },
            { title_slug = "kth-largest-element-in-an-array", tags = { "Heap / Priority Queue" } },
            { title_slug = "task-scheduler", tags = { "Heap / Priority Queue" } },
            { title_slug = "design-twitter", tags = { "Heap / Priority Queue" } },
            { title_slug = "find-median-from-data-stream", tags = { "Heap / Priority Queue" } },

            -- Backtracking
            { title_slug = "subsets", tags = { "Backtracking" } },
            { title_slug = "combination-sum", tags = { "Backtracking" } },
            { title_slug = "permutations", tags = { "Backtracking" } },
            { title_slug = "subsets-ii", tags = { "Backtracking" } },
            { title_slug = "combination-sum-ii", tags = { "Backtracking" } },
            { title_slug = "word-search", tags = { "Backtracking" } },
            { title_slug = "palindrome-partitioning", tags = { "Backtracking" } },
            { title_slug = "letter-combinations-of-a-phone-number", tags = { "Backtracking" } },
            { title_slug = "n-queens", tags = { "Backtracking" } },

            -- Graphs
            { title_slug = "number-of-islands", tags = { "Graphs" } },
            { title_slug = "clone-graph", tags = { "Graphs" } },
            { title_slug = "max-area-of-island", tags = { "Graphs" } },
            { title_slug = "pacific-atlantic-water-flow", tags = { "Graphs" } },
            { title_slug = "surrounded-regions", tags = { "Graphs" } },
            { title_slug = "rotting-oranges", tags = { "Graphs" } },
            { title_slug = "walls-and-gates", tags = { "Graphs" } },
            { title_slug = "course-schedule", tags = { "Graphs" } },
            { title_slug = "course-schedule-ii", tags = { "Graphs" } },
            { title_slug = "redundant-connection", tags = { "Graphs" } },
            { title_slug = "number-of-connected-components-in-an-undirected-graph", tags = { "Graphs" } },
            { title_slug = "graph-valid-tree", tags = { "Graphs" } },

            -- Advanced Graphs
            { title_slug = "reconstruct-itinerary", tags = { "Advanced Graphs" } },
            { title_slug = "min-cost-to-connect-all-points", tags = { "Advanced Graphs" } },
            { title_slug = "network-delay-time", tags = { "Advanced Graphs" } },
            { title_slug = "swim-in-rising-water", tags = { "Advanced Graphs" } },
            { title_slug = "alien-dictionary", tags = { "Advanced Graphs" } },
            { title_slug = "cheapest-flights-within-k-stops", tags = { "Advanced Graphs" } },

            -- 1-D Dynamic Programming
            { title_slug = "climbing-stairs", tags = { "1-D DP" } },
            { title_slug = "min-cost-climbing-stairs", tags = { "1-D DP" } },
            { title_slug = "house-robber", tags = { "1-D DP" } },
            { title_slug = "house-robber-ii", tags = { "1-D DP" } },
            { title_slug = "longest-palindromic-substring", tags = { "1-D DP" } },
            { title_slug = "palindromic-substrings", tags = { "1-D DP" } },
            { title_slug = "decode-ways", tags = { "1-D DP" } },
            { title_slug = "coin-change", tags = { "1-D DP" } },
            { title_slug = "maximum-product-subarray", tags = { "1-D DP" } },
            { title_slug = "word-break", tags = { "1-D DP" } },
            { title_slug = "longest-increasing-subsequence", tags = { "1-D DP" } },
            { title_slug = "partition-equal-subset-sum", tags = { "1-D DP" } },

            -- 2-D Dynamic Programming
            { title_slug = "unique-paths", tags = { "2-D DP" } },
            { title_slug = "longest-common-subsequence", tags = { "2-D DP" } },
            { title_slug = "best-time-to-buy-and-sell-stock-with-cooldown", tags = { "2-D DP" } },
            { title_slug = "coin-change-ii", tags = { "2-D DP" } },
            { title_slug = "target-sum", tags = { "2-D DP" } },
            { title_slug = "interleaving-string", tags = { "2-D DP" } },
            { title_slug = "longest-increasing-path-in-a-matrix", tags = { "2-D DP" } },
            { title_slug = "distinct-subsequences", tags = { "2-D DP" } },
            { title_slug = "edit-distance", tags = { "2-D DP" } },
            { title_slug = "burst-balloons", tags = { "2-D DP" } },
            { title_slug = "regular-expression-matching", tags = { "2-D DP" } },

            -- Greedy
            { title_slug = "maximum-subarray", tags = { "Greedy" } },
            { title_slug = "jump-game", tags = { "Greedy" } },
            { title_slug = "jump-game-ii", tags = { "Greedy" } },
            { title_slug = "gas-station", tags = { "Greedy" } },
            { title_slug = "hand-of-straights", tags = { "Greedy" } },
            { title_slug = "merge-triplets-to-form-target-triplet", tags = { "Greedy" } },
            { title_slug = "partition-labels", tags = { "Greedy" } },
            { title_slug = "valid-parenthesis-string", tags = { "Greedy" } },

            -- Intervals
            { title_slug = "insert-interval", tags = { "Intervals" } },
            { title_slug = "merge-intervals", tags = { "Intervals" } },
            { title_slug = "non-overlapping-intervals", tags = { "Intervals" } },
            { title_slug = "meeting-rooms", tags = { "Intervals" } },
            { title_slug = "meeting-rooms-ii", tags = { "Intervals" } },
            { title_slug = "minimum-interval-to-include-each-query", tags = { "Intervals" } },

            -- Math & Geometry
            { title_slug = "rotate-image", tags = { "Math & Geometry" } },
            { title_slug = "spiral-matrix", tags = { "Math & Geometry" } },
            { title_slug = "set-matrix-zeroes", tags = { "Math & Geometry" } },
            { title_slug = "happy-number", tags = { "Math & Geometry" } },
            { title_slug = "plus-one", tags = { "Math & Geometry" } },
            { title_slug = "powx-n", tags = { "Math & Geometry" } },
            { title_slug = "multiply-strings", tags = { "Math & Geometry" } },
            { title_slug = "detect-squares", tags = { "Math & Geometry" } },

            -- Bit Manipulation
            { title_slug = "single-number", tags = { "Bit Manipulation" } },
            { title_slug = "number-of-1-bits", tags = { "Bit Manipulation" } },
            { title_slug = "counting-bits", tags = { "Bit Manipulation" } },
            { title_slug = "reverse-bits", tags = { "Bit Manipulation" } },
            { title_slug = "missing-number", tags = { "Bit Manipulation" } },
            { title_slug = "sum-of-two-integers", tags = { "Bit Manipulation" } },
            { title_slug = "reverse-integer", tags = { "Bit Manipulation" } },
        },
    },

    grind75 = {
        name = "Grind 75",
        problems = {
            -- Week 1
            { title_slug = "two-sum", tags = { "Week 1", "Array" } },
            { title_slug = "valid-parentheses", tags = { "Week 1", "Stack" } },
            { title_slug = "merge-two-sorted-lists", tags = { "Week 1", "Linked List" } },
            { title_slug = "best-time-to-buy-and-sell-stock", tags = { "Week 1", "Array" } },
            { title_slug = "valid-palindrome", tags = { "Week 1", "String" } },
            { title_slug = "invert-binary-tree", tags = { "Week 1", "Tree" } },
            { title_slug = "valid-anagram", tags = { "Week 1", "String" } },
            { title_slug = "binary-search", tags = { "Week 1", "Binary Search" } },
            { title_slug = "flood-fill", tags = { "Week 1", "Graph" } },
            { title_slug = "lowest-common-ancestor-of-a-binary-search-tree", tags = { "Week 1", "Tree" } },
            { title_slug = "balanced-binary-tree", tags = { "Week 1", "Tree" } },
            { title_slug = "linked-list-cycle", tags = { "Week 1", "Linked List" } },
            { title_slug = "implement-queue-using-stacks", tags = { "Week 1", "Stack" } },

            -- Week 2
            { title_slug = "first-bad-version", tags = { "Week 2", "Binary Search" } },
            { title_slug = "ransom-note", tags = { "Week 2", "Hash Table" } },
            { title_slug = "climbing-stairs", tags = { "Week 2", "Dynamic Programming" } },
            { title_slug = "longest-palindrome", tags = { "Week 2", "String" } },
            { title_slug = "reverse-linked-list", tags = { "Week 2", "Linked List" } },
            { title_slug = "majority-element", tags = { "Week 2", "Array" } },
            { title_slug = "add-binary", tags = { "Week 2", "String" } },
            { title_slug = "diameter-of-binary-tree", tags = { "Week 2", "Tree" } },
            { title_slug = "middle-of-the-linked-list", tags = { "Week 2", "Linked List" } },
            { title_slug = "maximum-depth-of-binary-tree", tags = { "Week 2", "Tree" } },
            { title_slug = "contains-duplicate", tags = { "Week 2", "Array" } },

            -- Week 3
            { title_slug = "maximum-subarray", tags = { "Week 3", "Dynamic Programming" } },
            { title_slug = "insert-interval", tags = { "Week 3", "Array" } },
            { title_slug = "01-matrix", tags = { "Week 3", "Graph" } },
            { title_slug = "k-closest-points-to-origin", tags = { "Week 3", "Heap" } },
            { title_slug = "longest-substring-without-repeating-characters", tags = { "Week 3", "String" } },
            { title_slug = "3sum", tags = { "Week 3", "Array" } },
            { title_slug = "binary-tree-level-order-traversal", tags = { "Week 3", "Tree" } },
            { title_slug = "clone-graph", tags = { "Week 3", "Graph" } },
            { title_slug = "evaluate-reverse-polish-notation", tags = { "Week 3", "Stack" } },

            -- Week 4
            { title_slug = "course-schedule", tags = { "Week 4", "Graph" } },
            { title_slug = "implement-trie-prefix-tree", tags = { "Week 4", "Trie" } },
            { title_slug = "coin-change", tags = { "Week 4", "Dynamic Programming" } },
            { title_slug = "product-of-array-except-self", tags = { "Week 4", "Array" } },
            { title_slug = "min-stack", tags = { "Week 4", "Stack" } },
            { title_slug = "validate-binary-search-tree", tags = { "Week 4", "Tree" } },
            { title_slug = "number-of-islands", tags = { "Week 4", "Graph" } },
            { title_slug = "rotting-oranges", tags = { "Week 4", "Graph" } },

            -- Week 5
            { title_slug = "search-in-rotated-sorted-array", tags = { "Week 5", "Binary Search" } },
            { title_slug = "combination-sum", tags = { "Week 5", "Backtracking" } },
            { title_slug = "permutations", tags = { "Week 5", "Backtracking" } },
            { title_slug = "merge-intervals", tags = { "Week 5", "Array" } },
            { title_slug = "lowest-common-ancestor-of-a-binary-tree", tags = { "Week 5", "Tree" } },
            { title_slug = "time-based-key-value-store", tags = { "Week 5", "Binary Search" } },
            { title_slug = "accounts-merge", tags = { "Week 5", "Graph" } },
            { title_slug = "sort-colors", tags = { "Week 5", "Array" } },

            -- Week 6
            { title_slug = "word-break", tags = { "Week 6", "Dynamic Programming" } },
            { title_slug = "partition-equal-subset-sum", tags = { "Week 6", "Dynamic Programming" } },
            { title_slug = "string-to-integer-atoi", tags = { "Week 6", "String" } },
            { title_slug = "spiral-matrix", tags = { "Week 6", "Matrix" } },
            { title_slug = "subsets", tags = { "Week 6", "Backtracking" } },
            { title_slug = "binary-tree-right-side-view", tags = { "Week 6", "Tree" } },
            { title_slug = "longest-palindromic-substring", tags = { "Week 6", "String" } },
            { title_slug = "unique-paths", tags = { "Week 6", "Dynamic Programming" } },
            { title_slug = "construct-binary-tree-from-preorder-and-inorder-traversal", tags = { "Week 6", "Tree" } },

            -- Week 7
            { title_slug = "container-with-most-water", tags = { "Week 7", "Array" } },
            { title_slug = "letter-combinations-of-a-phone-number", tags = { "Week 7", "Backtracking" } },
            { title_slug = "word-search", tags = { "Week 7", "Backtracking" } },
            { title_slug = "find-all-anagrams-in-a-string", tags = { "Week 7", "String" } },
            { title_slug = "minimum-height-trees", tags = { "Week 7", "Graph" } },
            { title_slug = "task-scheduler", tags = { "Week 7", "Heap" } },
            { title_slug = "lru-cache", tags = { "Week 7", "Design" } },

            -- Week 8
            { title_slug = "kth-smallest-element-in-a-bst", tags = { "Week 8", "Tree" } },
            { title_slug = "minimum-window-substring", tags = { "Week 8", "String" } },
            { title_slug = "serialize-and-deserialize-binary-tree", tags = { "Week 8", "Tree" } },
            { title_slug = "trapping-rain-water", tags = { "Week 8", "Array" } },
            { title_slug = "find-median-from-data-stream", tags = { "Week 8", "Heap" } },
            { title_slug = "word-ladder", tags = { "Week 8", "Graph" } },
            { title_slug = "basic-calculator", tags = { "Week 8", "Stack" } },
            { title_slug = "maximum-profit-in-job-scheduling", tags = { "Week 8", "Dynamic Programming" } },
            { title_slug = "merge-k-sorted-lists", tags = { "Week 8", "Linked List" } },
            { title_slug = "largest-rectangle-in-histogram", tags = { "Week 8", "Stack" } },
        },
    },

    design = {
        name = "Design",
        problems = {
            -- Easy
            { title_slug = "design-hashset", tags = { "Easy", "Hash Table" } },
            { title_slug = "design-hashmap", tags = { "Easy", "Hash Table" } },
            { title_slug = "design-parking-system", tags = { "Easy", "Design" } },
            { title_slug = "implement-stack-using-queues", tags = { "Easy", "Stack" } },
            { title_slug = "implement-queue-using-stacks", tags = { "Easy", "Queue" } },
            { title_slug = "kth-largest-element-in-a-stream", tags = { "Easy", "Heap" } },

            -- Medium
            { title_slug = "min-stack", tags = { "Medium", "Stack" } },
            { title_slug = "implement-trie-prefix-tree", tags = { "Medium", "Trie" } },
            { title_slug = "design-add-and-search-words-data-structure", tags = { "Medium", "Trie" } },
            { title_slug = "lru-cache", tags = { "Medium", "Linked List" } },
            { title_slug = "design-twitter", tags = { "Medium", "Heap" } },
            { title_slug = "insert-delete-getrandom-o1", tags = { "Medium", "Hash Table" } },
            { title_slug = "design-circular-queue", tags = { "Medium", "Queue" } },
            { title_slug = "design-circular-deque", tags = { "Medium", "Queue" } },
            { title_slug = "design-linked-list", tags = { "Medium", "Linked List" } },
            { title_slug = "design-browser-history", tags = { "Medium", "Design" } },
            { title_slug = "design-underground-system", tags = { "Medium", "Design" } },
            { title_slug = "snapshot-array", tags = { "Medium", "Design" } },
            { title_slug = "online-stock-span", tags = { "Medium", "Stack" } },
            { title_slug = "time-based-key-value-store", tags = { "Medium", "Binary Search" } },
            { title_slug = "binary-search-tree-iterator", tags = { "Medium", "Tree" } },
            { title_slug = "peeking-iterator", tags = { "Medium", "Iterator" } },
            { title_slug = "flatten-nested-list-iterator", tags = { "Medium", "Iterator" } },
            { title_slug = "serialize-and-deserialize-bst", tags = { "Medium", "Tree" } },
            { title_slug = "design-hit-counter", tags = { "Medium", "Design" } },
            { title_slug = "logger-rate-limiter", tags = { "Medium", "Design" } },
            { title_slug = "design-tic-tac-toe", tags = { "Medium", "Design" } },
            { title_slug = "encode-and-decode-tinyurl", tags = { "Medium", "Design" } },
            { title_slug = "design-front-middle-back-queue", tags = { "Medium", "Queue" } },

            -- Hard
            { title_slug = "lfu-cache", tags = { "Hard", "Linked List" } },
            { title_slug = "all-oone-data-structure", tags = { "Hard", "Design" } },
            { title_slug = "serialize-and-deserialize-binary-tree", tags = { "Hard", "Tree" } },
            { title_slug = "find-median-from-data-stream", tags = { "Hard", "Heap" } },
            { title_slug = "design-in-memory-file-system", tags = { "Hard", "Trie" } },
            { title_slug = "design-search-autocomplete-system", tags = { "Hard", "Trie" } },
            { title_slug = "maximum-frequency-stack", tags = { "Hard", "Stack" } },
            { title_slug = "design-skiplist", tags = { "Hard", "Design" } },
        },
    },
}

---Get all available list keys
---@return string[]
function M.get_list_keys()
    return vim.tbl_keys(M.lists)
end

---Get a specific list by key
---@param key string
---@return lc.ProblemList|nil
function M.get_list(key)
    return M.lists[key]
end

---Get all unique tags from a list
---@param list_key string
---@return string[]
function M.get_tags(list_key)
    local list = M.lists[list_key]
    if not list then
        return {}
    end

    local tags_set = {}
    for _, problem in ipairs(list.problems) do
        for _, tag in ipairs(problem.tags) do
            tags_set[tag] = true
        end
    end

    local tags = vim.tbl_keys(tags_set)
    table.sort(tags)
    return tags
end

---Get problems from a list filtered by tag
---@param list_key string
---@param tag string
---@return lc.ProblemListEntry[]
function M.get_problems_by_tag(list_key, tag)
    local list = M.lists[list_key]
    if not list then
        return {}
    end

    return vim.tbl_filter(function(problem)
        return vim.tbl_contains(problem.tags, tag)
    end, list.problems)
end

---Get all problems from a list
---@param list_key string
---@return lc.ProblemListEntry[]
function M.get_all_problems(list_key)
    local list = M.lists[list_key]
    if not list then
        return {}
    end
    return list.problems
end

return M
