pragma solidity ^0.4.0;
contract PredictionMarket {

address owner;
mapping(address => Voter) voters;
mapping(uint => Prediction) predictions;
mapping(address => Vote) votes;
Prediction[] PredictionsIndex;
uint duration;
uint deadline = block.number + duration;

    struct Voter {
        bool voted;
        uint vote;
        bool solver;
    }
    struct Prediction {
        uint voteCount;
        bytes predictionStatement;
        uint duration;
        address predictionOwner;
        bool predictionOutcome;
        bool predictionOwner;
    }

    struct Vote {
        bool voteAnswer;
        address Voter;
        uint prediction;
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

    function predictionMarketBuilder(bytes _predictionStatement, uint _duration, address _predictionOwner)  ownerOnly {
        Prediction[Prediction].predictionOwner = _predictionOwner;
        Prediction[Prediction].predictionStatement = _predictionStatement;
        Prediction[Prediction].duration = _duration;
    }

    function voteBuilder(bool voted, )  ownerOnly {
        voters[Voter].predictionOwner = _predictionOwner;
        Prediction[Prediction].predictionStatement = _predictionStatement;
        Prediction[Prediction].duration = _duration;
    }

    function giveRightToVote(address voter) {
        if (msg.sender != Prediction[Prediction].predictionOwner || voters[voter].voted) 
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