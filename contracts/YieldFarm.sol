//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "./SimbaToken.sol";
import "./DaiToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// This interface represents all tokens that will be added to this Defi Application
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract YieldFarm is Ownable {
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
    IERC20 public simbaToken;
    IERC20 public geminiDollar;
    IERC20 public sUsd;
    IERC20 public susdt;
    IERC20 public usdcoin;
    IERC20 public daiToken;
    address[] public allowedTokens;
    // ############################################################################

    mapping(address => mapping(address => uint256)) public stakedAmount;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    mapping(address => uint256) public unique_Token_staked;
    mapping(address => address) public pricefeed;

    // ############################################################################

    constructor(
        address _daitoken,
        address _simbatoken,
        address _geminiDollar,
        address _sUsd,
        address _susdt,
        address _usdcoin
    ) public {
        daiToken = IERC20(_daitoken);
        simbaToken = IERC20(_simbatoken);
        geminiDollar = IERC20(_geminiDollar);
        sUsd = IERC20(_sUsd);
        susdt = IERC20(_susdt);
        usdcoin = IERC20(_usdcoin);
    }

    // ############################################################################

    function getMinStakeFee(uint256 _amount) public payable returns (uint256) {
        //minimum staking amount is $100
        minimumStakeAmount = 100 * 10**18;
        //if the user has upto $100 he can stake else exit
        require(_amount >= minimumStakeAmount, "Minimum Fee to Stake is $100");
    }

    // ############################################################################

    function Stake(uint256 _amount, address _token) public {
        require(AllowedTokenForStaking(_token), "Token is not allowed");
        //getting the minimum required fee to invest
        getMinStakeFee(msg.value >= _amount);
        //user deposits minimum amout of token required to invest to this contract
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        //calling function to check if users has multiple stakes in different tokens
        uniqueToken(msg.sender, _token);
        //mapping for each user & how much he/she staked
        stakedAmount[_token][msg.sender] += _amount;
        //add users to list if they have not staked
        if (unique_Token_staked[msg.sender] == 1) {
            stakers.push(msg.sender);
        }
        //get stake status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // ############################################################################

    function uniqueToken(address _user, address _token) internal {
        if (stakedAmount[_token][_user] <= 0) {
            unique_Token_staked += 1;
        }
    }

    // ############################################################################
    function AddTokens(address _token) public onlyOwner {
        // only admin can add tokens
        allowedTokens.push(_token);
    }

    // ############################################################################
    function RemoveTokens(address _token) public onlyOwner {
        // only admin can remove tokens
        allowedTokens.pop(_token);
    }

    // ############################################################################

    function AllowedTokenForStaking(address _token) public returns (bool) {
        //only tokens listed can be staked on
        for (uint256 i = 0; i < allowedTokens.length; i++) {
            if (allowedTokens[i] == _token) {
                return true;
            }
        }
        return false;
    }

    // ############################################################################

    function unStake(uint256 amount) public {}

    // ############################################################################

    function AwardIntrests() public onlyOwner {
        //looping through all stakers list

        for (uint256 i = 0; i < stakers.length; i++) {
            //get the user
            address user = stakers[i];
            //getting the balance
            // uint256 bal = stakedAmount[user];
            //sending rewards only if the balance from the array shows that the user has staked so
            //if less than or equal to zero they have not staked
            // if (bal > 0) {
            //     if (daiToken) {
            //         daiToken.transfer(user, bal);
            //     }
            //     if (simbaToken) {
            //         simbaToken.transfer(user, bal);
            //     }
            //     if (geminiDollar) {
            //         geminiDollar.transfer(user, bal);
            //     }
            //     if (sUsd) {
            //         sUsd.transfer(user, bal);
            //     }
            //     if (susdt) {
            //         susdt.transfer(user, bal);
            //     }
            //     if (usdcoin) {
            //         usdcoin.transfer(user, bal);
            //     }
            // }
        }
    }

    // ############################################################################

    function getTokenPriceFeed(address _token, address _pricefeed)
        public
        onlyOwner
    {
        pricefeed[_token] = _pricefeed;
    }
}
