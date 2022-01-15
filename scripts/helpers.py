from brownie import accounts, network, config


LOCAL_BLOCKCHAIN_ENVIRONMENTS = [
    "development",
    "ganache",
    "hardhat",
    "mainnet-fork",
]
LOCAL_GANACHE_LOCAL = "ganache-local"


def get_account():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        account = accounts.load("cweetbeatz2")
        return account
    elif network.show_active() in LOCAL_GANACHE_LOCAL:
        # account = accounts.load("cweetbeatz")
        account = accounts[2]
        print(account.balance())
        print(account.address)
        return account
    else:
        return accounts.add(config["wallet"]["from_key"])


#############################################################
