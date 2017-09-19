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
mapping(uint => Vote) votes;
Vote[] VotesIndex;
Market[] MarketsIndex;
uint deadline = block.number + duration;
mapping (address => uint) balances;

    struct Market {
        uint voteCount;
        bytes marketQuestion;
        uint duration;
        address marketOwner;
        bool marketAnswer;
    }

    struct Vote {
        bool voteAnswer;
        address person;
        address market;
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

    function giveRightToVote(address _person, address _market) {
        voters[_person].Authorizations.push(_market);
    }

    function marketBuilder(bytes _marketQuestion, uint _duration) {
        marketOwner = msg.sender;
        markets[Market].marketOwner = marketOwner;
        Market[Market].marketQuestion = _marketQuestion;
        Market[Market].duration = _duration;
        Market[Market].push(MarketsIndex);
    }

    function vote(address _market, uint _prediction, bool _voteAnswer, uint _betAmount)
    payable
    returns(bool success)
     {
        voter = msg.sender;
        //I'm aware this boarding process makes it easy to make a sybil attack but I'm starting simple :)
        voters[voter] = voter;
        voters[voter].voteAnswer = _voteAnswer;
        if (markets[_market]==address(0) || votes[_market].voted)
        return;
        votes[_market].person = voter;
        votes[_market].voteAnswer = _voteAnswer;
        votes[_market].market = market;
        votes[_market].betAmount = _betAmount;
        votes[_market].voted;
        votes[_market].push(voteIndex);
        msg.value.transfer(ballot);
        return true;
    }

    function vote(uint8 prediction, bool _voteAnswer) {
        Voter storage sender = voters[msg.sender];
        if (sender.voted) 
        return;

        sender.voteAnswer = _voteAnswer;
        sender.vote = prediction;
        Prediction.push(sender);
    }

    function appointSolver (address voterToAppoint) ownerOnly {
        voters[voterToAppoint].solver = true;
    }

    function winningPrediction() constant returns (uint8 _winningPrediction) {
        uint256 winningVoteCount = 0;
        for (uint8 prediction = 0; prediction < Predictions.length; prediction++) {
            if (Predictions[prediction].voteCount > winningVoteCount) {
                winningVoteCount = Predictions[prediction].voteCount;
                _winningPrediction = prediction;
            }
        }
    }
}