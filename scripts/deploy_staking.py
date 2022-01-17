from brownie import SimbaToken, DaiToken, YieldFarm
from .helpers import get_account
from web3 import Web3

#############################################################


def deploy_staking_transaction(amount):
    account = get_account()
    prev_tx = YieldFarm[-1]
    next_tx = prev_tx.Stake(amount, {"from": account})
    next_tx.wait(1)
    print(f"Successfully Staked {next_tx}")


#############################################################


def main():
    deploy_staking_transaction()
