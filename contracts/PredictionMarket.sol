pragma solidity ^0.4.0;

import "./Votes.sol";
contract PredictionMarket {
address owner;
address marketOwner;
address market;
uint betAmount;
uint duration;
mapping(address => MarketStruct) MarketStructs;
mapping (address => uint) balances;
MarketStruct[] public Markets;
uint deadline = block.number + duration;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
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

    modifier ownerOnly {
	if (msg.sender != owner)
    revert();
	_;
	}

    function PredictionMarket() {
        owner = msg.sender;
    }

    function insertMarket(
        bytes _marketQuestion,
        uint _duration)
        public
        returns(uint index)
    {
       address _marketId = msg.sender;
        MarketStruct memory newMarketStruct;
        newMarketStruct.marketQuestion = _marketQuestion;
        newMarketStruct.duration = _duration;
        newMarketStruct.marketOwner = msg.sender;
        MarketStructs[_marketId] = newMarketStruct;
        Markets.push(newMarketStruct) - 1;
        LogMarketCreation(_marketQuestion, msg.sender);
        return newMarketStruct.index;
    }

        function getMarkets(uint index)
        constant
        public
        returns (bytes)
    {
        bytes storage marketQuestion = Markets[index].marketQuestion;
        return marketQuestion;
    }
}