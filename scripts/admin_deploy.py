from brownie import SimbaToken, DaiToken, YieldFarm
from helpers import get_account
from web3 import Web3

#############################################################

# deploys contract to Block


def deploy_yield_farm():
    account = get_account()
    dai_token = DaiToken.deploy({"from": account})
    print("Dai Token Deployed")
    print(dai_token.address)

    simba_token = SimbaToken.deploy({"from": account})
    print("Simba Token Deployed")
    print(simba_token.address)

    yield_contract = YieldFarm.deploy(
        dai_token.address, simba_token.address, {"from": account}
    )
    print("Yield Farm Contract Deployed")
    print(yield_contract.address)

    print("Contracts Successfully Deployed")


#############################################################

# funds the yeild contact with the inital amount of tokens supplied


def fund_yield_contract():
    account = get_account()
    prev_tx = SimbaToken[-1]
    yield_farm_prev_tx = YieldFarm[-1]
    amount = Web3.toWei(1900000, "ether")
    next_tx = prev_tx.transfer(yield_farm_prev_tx.address, amount, {"from": account})
    next_tx.wait(1)
    print(f"Successfully Funded: {amount} tokens")


#############################################################


def main():
    deploy_yield_farm()
    # fund_yield_contract()
