//SPDX-License-Identifier:MIT

pragma solidity >=0.6.0 <0.9.0;

import "./SimbaToken.sol";
import "./DaiToken.sol";

contract YieldFarm {
    //deploy dai token
    //deploy simba token
    //minimum staking fee
    //stake tokens
    //award intrests after a specified period
    //unstake tokens

    // ############################################################################

    uint256 minimumStakeAmount;
    address[] public stakers;
    string public name = "Yield Farming";
    SimbaToken public simbaToken;
    DaiToken public daiToken;

    constructor(DaiToken _daitoken, SimbaToken _simbatoken) public {
        daiToken = _daitoken;
        simbaToken = _simbatoken;
    }

    // ############################################################################

    function getMinStakeFee(uint256 amount)
        public
        view
        returns (uint256)
    {
        //minimum staking amount is $100
         minimumStakeAmount = 100 * 10 ** 18;
         require(minimumStakeAmount >= amount)
    }

    // ############################################################################

    function Stake(address user, uint256 _amount) public {
        //getting the minimum required fee to invest
        getMinStakeFee(_amount)
        //user deposits minimum amout of token required to invest to this contract
    }

    // ############################################################################

    function unStake(address user, uint256 amount) public {}

    // ############################################################################

    function AwardIntrests(address user, uint256 amount) public {}
}
