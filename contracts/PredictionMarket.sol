pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
uint betAmount;
uint duration;
mapping(address => VoterStruct) voters;
mapping(address => Market) markets;
mapping(address => Vote) votes;
Vote[] public VotesIndex;
VoterStruct[] public VoterStructs;
Market[] public MarketsIndex;
uint deadline = block.number + duration;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event MarketCreation(address _marketAddress, bytes _marketQuestion);
mapping (address => uint) balances;

    struct Market {
        uint voteCount;
        bytes marketQuestion;
        uint duration;
        address marketOwner;
        bool marketAnswer;
        uint balance;
    }

    struct Vote {
        bool voteAnswer;
        address person;
        address market;
        uint betAmount;
    }

    struct VoterStruct {
        uint vote;
        address[] votingAuthorizations;
    }

    modifier ownerOnly {
	if (msg.sender != owner) 
    revert();
	_;
	}

    function PredictionMarket() {
        owner = msg.sender;
    }

    // function giveRightToVote(address _person, uint _market) {
    //     voters[_person].votingAuthorizations.push(_market);
    // }

    function marketBuilder(bytes _marketQuestion, uint _duration) {
        markets[msg.sender].marketOwner = msg.sender;
        markets[msg.sender].marketQuestion = _marketQuestion;
        markets[msg.sender].duration = _duration;
        MarketsIndex.push(markets[msg.sender]);
        MarketCreation(msg.sender, _marketQuestion);
    }

    function vote(address _market, bool _voteAnswer, uint _betAmount)
    payable
    returns(bool success)
     {
        voter = msg.sender;
        for (uint i = 0;i<VotesIndex.length;i++) {
        if (VotesIndex[i].market == votes[voter].market)
        revert();
        votes[_market].person = voter;
        votes[_market].voteAnswer = _voteAnswer;
        votes[_market].market = market;
        votes[_market].betAmount = _betAmount;
        VotesIndex.push(votes[_market]);
        markets[_market].balance += _betAmount;
        Transfer(msg.sender, _market, _betAmount);
        return true;
        }
    }

    function appointSolver(address _voterToAppoint, uint rowNumber, address _market) 
    ownerOnly 
    public
    returns(bool success)
        {
        if (votes[_voterToAppoint].market != _market)
        revert();
        // Person voters voterToAppoint; 
        VoterStruct memory voterToAppoint;
        voterToAppoint = VoterStructs[rowNumber];
        for (uint i = 0; i<voterToAppoint.votingAuthorizations.length; i++) {
        
        if (voterToAppoint.votingAuthorizations == _market)
            revert();
            //couldn't find a way to push a new Market to the votingAuthorizations array... 
            voterToAppoint.votingAuthorizations.push(_market);
            return true;
         }
    
}