pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
uint betAmount;
uint duration;
mapping(address => Person) voters;
mapping(address => Market) markets;
mapping(address => Vote) votes;
Vote[] VotesIndex;
Voter[] VotersIndex;
Market[] MarketsIndex;
uint deadline = block.number + duration;
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

    struct Person {
        uint vote;
        uint[] votingAuthorizations;
    }

    modifier ownerOnly {
	if (msg.sender != owner) 
    revert();
	_;
	}

    function PredictionMarket() {
        owner = msg.sender;
    }

    function giveRightToVote(address _person, uint _market) {
        voters[_person].votingAuthorizations.push(_market);
    }

    function marketBuilder(bytes _marketQuestion, uint _duration) {
        markets[msg.sender].marketOwner = msg.sender;
        markets[msg.sender].marketQuestion = _marketQuestion;
        markets[msg.sender].duration = _duration;
        MarketsIndex.push(markets[msg.sender]);
    }

    function vote(address _market, uint _prediction, bool _voteAnswer, uint _betAmount)
    payable
    returns(bool success)
     {
        //I'm aware this boarding process makes it easy to make a sybil attack but I'm starting simple :)
        voter = msg.sender;
        for (uint i = 0;i<VotesIndex.length;i++) {
        if (VotesIndex[i].market == votes[voter].market)
        return;
        votes[_market].person = voter;
        votes[_market].voteAnswer = _voteAnswer;
        votes[_market].market = market;
        votes[_market].betAmount = _betAmount;
        VotesIndex.push(votes[_market]);
        markets[_market].balance += _betAmount;
        return true;
        }
    }

    function appointSolver (address _voterToAppoint, address _market) ownerOnly {
        voters[voterToAppoint].solver = true;
        if (voters[voterToAppoint])
        authorizationsVoterToAppoint = voters[_voterToAppoint].votingAuthorizations;
        for (uint i = 0; i<authorizationsVoterToAppoint.length; i++) {
            if (authorizationsVoterToAppoint[i] == _market)
            return;
            authorizationsVoterToAppoint.push(_market);
        }
    }

    // function winningPrediction() constant returns (uint8 _winningPrediction) {
    //     uint256 winningVoteCount = 0;
    //     for (uint8 prediction = 0; prediction < Predictions.length; prediction++) {
    //         if (Predictions[prediction].voteCount > winningVoteCount) {
    //             winningVoteCount = Predictions[prediction].voteCount;
    //             _winningPrediction = prediction;
    //         }
    //     }
    // }
}