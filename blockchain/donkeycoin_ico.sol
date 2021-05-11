pragma solidity >=0.4.0 <0.9.0;

contract donkeycoin_ico {

    // Introduction the maximum number of donkeycoins available for sale
    uint public max_donkeycoins = 100000000;

    // Introduction the USD to Donkeycoins conversion rate
    uint public usd_to_donkeycoins = 1000;


    // Introduction to the number of Donkeycoins that have been bought by investors
    uint public total_donkeycoins_bought = 0;

    // Mapping from the investors address to its equity in Donkeycoins and USD
    mapping(address => uint) equity_donkeycoins;
    mapping(address => uint) equity_usd;

    // Check if an investor can buy some donkeycoins
    modifier can_buy_donkeycoins(uint usd_invested) {
        require (usd_invested * usd_to_donkeycoins + total_donkeycoins_bought <= max_donkeycoins);
        _;
    }

    // Getting equity in Donkeycoins of an investor
    function equity_in_donkeycoins(address investor) external constant returns (uint) {
        return equity_donkeycoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_in_usd[investor];
    }

    // Buying Donkeycoins!!
    function buy_donkycoins(address investor, uint usd_invested) external
    can_buy_donkeycoins(usd_invested) {
        uint donkeycoins_bought = usd_invested * usd_to_donkeycoins;
        equity_donkeycoins[investor] += donkeycoins_bought;
        equity_usd[investor] = equity_donkeycoins[investor] / 1000;
        total_donkeycoins_bought += donkeycoins_bought;
    }

    // Selling Donkeycoins
    function sell_donkycoins(address investor, uint donkeycoins_sold) external {
        equity_donkeycoins[investor] -= donkeycoins_sold;
        equity_usd[investor] = equity_donkeycoins[investor] / 1000;
        total_donkeycoins_bought -= donkeycoins_sold;
    }



}