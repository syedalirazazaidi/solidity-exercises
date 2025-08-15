// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Create a Twitter Contract ✅
// 2. Create a mapping between user and tweet ✅
// 3. Add function to create a tweet and save it in mapping ✅
// 4. Create a function to get Tweet ✅
// 5. Add array of tweets ✅

// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets

contract Tweets {
    struct Tweet {
        address author;
        string content;
        uint256 likes;
        uint256 timestamp;
    }

    // Mapping from user address to their array of tweets
    mapping(address => Tweet[]) public tweets;

    // Create a tweet
    function createTweet(string memory _content) public {
        tweets[msg.sender].push(
            Tweet({
                author: msg.sender,
                content: _content,
                likes: 0,
                timestamp: block.timestamp
            })
        );
    }

    function getTweet(address _user, uint256 _index)
        public
        view
        returns (
            address,
            string memory,
            uint256,
            uint256
        )
    {
        require(_index < tweets[_user].length, "Tweet does not exist");
        Tweet memory t = tweets[_user][_index];
        return (t.author, t.content, t.likes, t.timestamp);
    }

    // Get total tweets of a user
    function getTweetCount(address _user) public view returns (uint256) {
        return tweets[_user].length;
    }
}
