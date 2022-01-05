pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract BlockNumberTest {

    struct State {
        uint256 index;
        uint256 blockNumber;
        uint256 blockTime;
    }

    mapping(address => State) public userState;


    constructor() public {

        address user = msg.sender;

        userState[user] = State({
        index : 0,
        blockNumber : block.number,
        blockTime : block.timestamp
        });

    }

    function getUserState() public view returns (State memory){
        return userState[msg.sender];
    }

    function updateUserState() public {
        State storage state = userState[msg.sender];

        state.index = state.index + 1;
        state.blockNumber = block.number;
        state.blockTime = block.timestamp;
    }

    function compareAndUpdate() public {

        State storage state = userState[msg.sender];
        uint256 blockNumber = block.number;
        require(state.blockNumber <= blockNumber, "state.blockNumber must be smaller or equal to blockNumber");

        uint blockTime = block.timestamp;
        require(state.blockNumber < blockTime, "state.blockNumber must be smaller to block.timestamp");

        updateUserState();
    }


    function getBlockNumber() public view returns (uint256){
        return block.number;
    }

    function getBlockTimestamp() public view returns (uint256){
        return block.timestamp;
    }


}
