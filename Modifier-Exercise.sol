// SPDX-License-Identifier: MIT
// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets
// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function
// 1️⃣  Use require to limit the length of the tweet to be only 280 characters
// HINT: use bytes to length of tweet


pragma solidity ^0.8.0;

contract TweetStorage {
    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
    }

    // Mapping to store tweets by their author
    mapping(address => Tweet[]) public tweets;

    // Event to emit when a new tweet is created
    event TweetCreated(address indexed author, string content, uint256 timestamp);

    // Function to create a new tweet
    function createTweet(string memory _content) public {
        require(bytes(_content).length > 0, "Tweet content cannot be empty");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _content,
            timestamp: block.timestamp
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(msg.sender, _content, block.timestamp);
    }

    // Function to get all tweets by an author
    function getTweetsByAuthor(address _author) public view returns (Tweet[] memory) {
        return tweets[_author];
    }
}