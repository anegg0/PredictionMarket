pragma solidity ^0.4.0;

import "./PredictionMarket.sol";

contract Votes {

address owner;
address voter;
uint betAmount;
uint duration;
mapping(address => VoterStruct) VoterStructs;
mapping(address => VoteStruct) VoteStructs;
mapping (address => uint) balances;
address[] public VotesIndex;
address[] private VoterIndex;
uint deadline = block.number + duration;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event LogNewVote(address _market, bool answer, uint amount, uint balanceMarket);

    struct VoteStruct {
        bool voteAnswer;
        address voter;
        address market;
        uint betAmount;
        uint index;
    }

    struct VoterStruct {
        address castedVote;
        uint256[] votingAuthorizations;
        uint index;
    }

    modifier ownerOnly {
	if (msg.sender != owner)
    revert();
	_;
	}

    function Votes() {
        owner = msg.sender;
    }

    function isVote(address _voter, address _market)
        public
        constant
        returns(bool isIndeed)
    {
        if (VoteStructs[_market].voter == _voter && VoteStructs[_market].market == _market)
        return false;
        return VoteStructs[_market].voter == _voter;
    }

    function insertVote(
        address _market,
        bool _voteAnswer,
        uint _betAmount)
        public
        returns(uint index)
    {
        if (isVote(msg.sender, _market))
        revert();
        VoteStruct memory newVoteStruct;
        newVoteStruct.market = _market;
        newVoteStruct.voteAnswer = _voteAnswer;
        newVoteStruct.betAmount = _betAmount;
        newVoteStruct.index = VotesIndex.push(msg.sender)-1;
        VoterStructs[msg.sender].castedVote = _market;
        MarketStructs[_market].balance += _betAmount;
        LogNewVote(
            _market,
            _voteAnswer,
            _betAmount,
            MarketStructs[_market].balance
            );
        return newVoteStruct.index;
    }
}