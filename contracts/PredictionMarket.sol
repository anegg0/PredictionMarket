pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
uint betAmount;
uint duration;
mapping(address => VoterStruct) VoterStructs;
mapping(bytes32 => MarketStruct) MarketStructs;
mapping(bytes32 => VoteStruct) VoteStructs;
mapping (address => uint) balances;
address[] public VotesIndex;
address[] private VoterIndex;
address[] public MarketsIndex;
uint deadline = block.number + duration;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event LogNewVote(bytes32 _market, bool answer, uint amount, uint balanceMarket);
event LogMarketCreation(bytes _marketQuestion,address _marketAddress);

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
        bytes32 market;
        uint betAmount;
        uint index;
    }

    struct VoterStruct {
        bytes32 castedVote;
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

    function isVote(address _voter, bytes32 _market)
        public
        constant
        returns(bool isIndeed)
    {
        if (VoteStructs[_market].voter == _voter && VoteStructs[_market].market == _market)
        return false;
        return VoteStructs[_market].voter == _voter;
    }

    function insertVote(
        bytes32 _market,
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

    function insertMarket(
        bytes _marketQuestion,
        uint _duration)
        // address _marketId)
        public
        returns(uint index)
    {
        MarketStruct memory newMarketStruct;
        newMarketStruct.marketQuestion = _marketQuestion;
        newMarketStruct.duration = _duration;
        newMarketStruct.marketOwner = msg.sender;
        newMarketStruct.index = MarketsIndex.push(msg.sender) - 1;
        MarketStructs[keccak256(msg.sender,_marketQuestion)] = newMarketStruct;
        LogMarketCreation( _marketQuestion, msg.sender );
        return newMarketStruct.index;
    }

        function getMarkets(bytes32 _marketId)
        constant
        public
        returns (bytes)
    {
        return MarketStructs[_marketId].marketQuestion;
    }
}