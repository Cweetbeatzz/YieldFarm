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
    // ############################################################################

    mapping(address => uint256 ) public stakedAmount;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    // ############################################################################

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
         require(minimumStakeAmount >= amount, "Minimum Fee to Stake is $100")
    }

    // ############################################################################

    function Stake(uint256 _amount) public {
        //getting the minimum required fee to invest
        getMinStakeFee(_amount);
        //user deposits minimum amout of token required to invest to this contract
        daiToken.transferFrom(msg.sender,address(this),_amount);
        //mapping for each user & how much he/she staked
        stakedAmount[msg.sender] += _amount;
        //add users to list if they have not staked
        if(!hasStaked[msg.sender]){
           stakers.push(msg.sender)
        }
        //get stake status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // ############################################################################

    function unStake(address user, uint256 amount) public {}

    // ############################################################################

    function AwardIntrests(address user, uint256 amount) public {}
}
