from brownie import SimbaToken, DaiToken, YieldFarm
from helpers import get_account
from web3 import Web3

#############################################################


def check_token_balance(user_address):
    account = get_account()
    prev_tx = YieldFarm[-1]
    next_tx = prev_tx.balanceOf(user_address, {"from": account})
    print("Successful")


def main():
    check_token_balance()
