pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
address marketOwner;
address voter;
address market;
mapping(address => Person) voters;
mapping(address => Market) markets;
mapping(uint => Vote) votes;
Market[] MarketsIndex;
Vote[] VotesIndex;
uint duration;
uint deadline = block.number + duration;
mapping (address => uint) balances;

    struct Person {
        uint vote;

    }
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
        uint market;
    }

    modifier ownerOnly {
	if (msg.sender != owner) 
    revert();
	_;
	}

    function PredictionMarket()
    {
        owner = msg.sender;
    }

    function marketBuilder(bytes _marketQuestion, uint _duration)   {
        marketOwner = msg.sender;
        markets[Market].marketOwner = marketOwner;
        Market[Market].marketQuestion = _marketQuestion;
        Market[Market].duration = _duration;
        Market[Market].push(MarketsIndex);
    }

//must create a vote, check if voter has voted on this one, 
    function vote(address _market, uint _prediction, bool _voteAnswer)
    payable
    returns(bool success)
     {
        voter = msg.sender;
        //I'm aware this boarding process makes it easy to make a sybil attack but I'm starting simple :)
        voters[voter] = voter;
        voters[voter].voteAnswer = _voteAnswer;
        if (markets[_market]== address(0))
        return;
        markets[Market] = _prediction;

    }

build a balance system
check how the votes and stats are stored

    function stashBallot

    function vote(address person, uint prediction, bool voteAnswer)
        payable
        ownerOnly
        returns(bool success)
         {
        voters[person].marketOwner = _marketOwner;
        transfer(ballot)
        return true;
    }

    function giveRightToVote(address person) {
        if (msg.sender != Prediction[Prediction].marketOwner || voters[person].voted) 
        return;
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