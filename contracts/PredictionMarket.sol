pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
uint betAmount;
uint duration;
mapping(address => VoterStruct) VoterStructs;
mapping(address => MarketStruct) MarketStructs;
mapping(address => VoteStruct) VoteStructs;
address[] public VotesIndex;
address[] private VoterIndex;
address[] public MarketsIndex;
uint deadline = block.number + duration;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event LogNewVote(address _market, bool answer, uint Amount);
event LogMarketCreation(bytes _marketQuestion, address _marketAddress);
mapping (address => uint) balances;

    struct MarketStruct {
        uint voteCount;
        bytes marketQuestion;
        uint duration;
        address marketOwner;
        bool marketAnswer;
        uint balance;
        uint index;
    }

    struct VoteStruct {
        bool voteAnswer;
        address voter;
        address market;
        uint betAmount;
        uint index;
    }

    struct VoterStruct {
        address[] castedVotes;
        uint256[] votingAuthorizations;
        uint index;
    }

    modifier ownerOnly {
	if (msg.sender != owner) 
    revert();
	_;
	}

    function PredictionMarket() {
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
        newVoteStruct.index = VotesIndex.push(_market)-1;
        VoterStructs[msg.sender].castedVotes.push(_market)-1;
        MarketStructs[_market].balance += _betAmount;
        market.transfer(_betAmount);
        LogNewVote(
            _market, 
            _voteAnswer, 
            _betAmount);
        return newVoteStruct.index;

  }

    function insertMarket(
        bytes _marketQuestion,
        uint _duration) 
        public
        returns(uint index)
    {
        MarketStruct memory newMarketStruct;
        newMarketStruct.marketQuestion = _marketQuestion;
        newMarketStruct.duration = _duration;
        newMarketStruct.marketOwner = msg.sender;
        newMarketStruct.index = MarketsIndex.push(msg.sender)-1;
        LogMarketCreation( _marketQuestion, msg.sender );
        return newMarketStruct.index;
        
    }
}