from brownie import SimbaToken, DaiToken, YieldFarm
from .helpers import get_account
from web3 import Web3

#############################################################


def deploy_rewards_transaction():
    account = get_account()
    prev_tx = YieldFarm[-1]
    next_tx = prev_tx.AwardIntrests({"from": account})
    next_tx.wait(1)
    print(f"Successfully Rewarded {next_tx} Tokens")


#############################################################


def main():
    deploy_rewards_transaction()
