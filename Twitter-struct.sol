// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter {
    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    // ✅ Track who liked each tweet
    // liked[_author][_tweetIndex][_liker] = true if they already liked it
    mapping(address => mapping(uint256 => mapping(address => bool))) public liked;

    // Create a tweet
   function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= 280, "Tweet exceeds 280 characters");

        tweets[msg.sender].push(Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        }));
    }

    // Get a single tweet
    function getTweet(address _owner, uint256 _i) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    // Get all tweets from a user
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }

    // ✅ Like a tweet only once per user
    function likeTweet(address _author, uint _index) public {
        require(_index < tweets[_author].length, "Tweet does not exist");
        require(!liked[_author][_index][msg.sender], "You already liked this tweet");

        liked[_author][_index][msg.sender] = true;
        tweets[_author][_index].likes++;
    }

    // ✅ Get total likes from all tweets of a user
    function getTotalLikes(address _owner) public view returns (uint256 totalLikes) {
        for (uint i = 0; i < tweets[_owner].length; i++) {
            totalLikes += tweets[_owner][i].likes;
        }
    }
}
