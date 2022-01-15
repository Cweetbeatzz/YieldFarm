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
    address public owner;
    // ############################################################################

    mapping(address => uint256) public stakedAmount;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // ############################################################################

    constructor(DaiToken _daitoken, SimbaToken _simbatoken) public {
        daiToken = _daitoken;
        simbaToken = _simbatoken;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // ############################################################################

    function getMinStakeFee(uint256 amount) public payable returns (uint256) {
        //minimum staking amount is $100
        minimumStakeAmount = 100 * 10**18;
        //if the user has upto $100 he can stake else exit
        require(minimumStakeAmount >= amount, "Minimum Fee to Stake is $100");
    }

    // ############################################################################

    function Stake(uint256 _amount) public {
        //getting the minimum required fee to invest
        getMinStakeFee(_amount);
        //user deposits minimum amout of token required to invest to this contract
        daiToken.transferFrom(msg.sender, address(this), _amount);
        //mapping for each user & how much he/she staked
        stakedAmount[msg.sender] += _amount;
        //add users to list if they have not staked
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        //get stake status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // ############################################################################

    function unStake(uint256 amount) public {}

    // ############################################################################

    function AwardIntrests() public onlyOwner {
        //only owner can call this function
        // require(msg.sender == owner, "Caller must be the Owner");

        //looping through all stakers list

        for (uint256 i = 0; i < stakers.length; i++) {
            //get the user
            address user = stakers[i];
            //getting the balance
            uint256 bal = stakedAmount[user];
            //sending rewards only if the balance from the array shows that the user has staked so
            //if less than or equal to zero they have not staked
            if (bal > 0) {
                simbaToken.transfer(user, bal);
            }
        }
    }
}
