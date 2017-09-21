pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
uint betAmount;
uint duration;
mapping(address => VoterStruct) VoterStructs;
mapping(address => MarketStruct) markets;
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
        return (VoteStruct.voter == _voter);
    }

    function insertVote(
        address _market, 
        bool _voteAnswer, 
        uint _betAmount) 
        public
        returns(uint index)
    {
        // if (isVote(msg.sender, _market)) 
        // revert(); 
        VoteStruct memory newVoteStruct;
        newVoteStruct.market = _market;
        newVoteStruct.voteAnswer = _voteAnswer;
        newVoteStruct.betAmount = _betAmount;
        newVoteStruct.index = VotesIndex.push(_market)-1;
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
        // if (isVote(msg.sender, _market)) 
        // revert(); 
        MarketStruct memory newMarketStruct;
        newMarketStruct.marketQuestion = _marketQuestion;
        newMarketStruct.duration = _duration;
        newMarketStruct.marketOwner = msg.sender;
        newMarketStruct.index = MarketsIndex.push(msg.sender)-1;
        LogMarketCreation( _marketQuestion, msg.sender );
        return newMarketStruct.index;
        
    }
}


    // function giveRightToVote(address _person, uint _market) {
    //     voters[_person].votingAuthorizations.push(_market);
    // }

//     function marketBuilder(bytes _marketQuestion, uint _duration) {
//         markets[msg.sender].marketOwner = msg.sender;
//         markets[msg.sender].marketQuestion = _marketQuestion;
//         markets[msg.sender].duration = _duration;
//         MarketsIndex.push(markets[msg.sender]);
//         MarketCreation(msg.sender, _marketQuestion);
//     }

//     function getUserCount() public constant returns(uint count) {
//         return VoterStructs.length;
// }

   // function vote(address _market, bool _voteAnswer, uint _betAmount)
    // payable
    // returns(bool success)
    //  {
    //     voter = msg.sender;
    //     for (uint i = 0;i<VotesIndex.length;i++) {
    //     if (VotesIndex[i].market == votes[voter].market)
    //     revert();
    //     votes[_market].person = voter;
    //     votes[_market].voteAnswer = _voteAnswer;
    //     votes[_market].market = market;
    //     votes[_market].betAmount = _betAmount;
    //     VotesIndex.push(votes[_market]);
    //     markets[_market].balance += _betAmount;
    //     Transfer(msg.sender, _market, _betAmount);
    //     return true;
    //     }
    // }

    // function appointSolver(address _voterToAppoint, uint rowNumber, address _market) 
    // ownerOnly 
    // public
    // returns(bool success)
    //     {
    //     if (votes[_voterToAppoint].market != _market)
    //     revert();
    //     // Person voters voterToAppoint; 
    //     VoterStruct memory voterToAppoint;
    //     voterToAppoint = VoterStructs[rowNumber];
    //     for (uint i = 0; i<voterToAppoint.votingAuthorizations.length; i++) {
    //     if (voterToAppoint.votingAuthorizations[i] == _market)
    //         revert();
    //         //couldn't find a way to push a new Market to the votingAuthorizations array... 
    //         // voterToAppoint = VoterStructs[rowNumber].votingAuthorizations[i];
    //         // voterToAppoint.votingAuthorizations[i].push(_market);
    //         return true;
    //         }
    //     }  