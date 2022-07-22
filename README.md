# AlgoGlobalState
allows accounts to have "global" state that any dApp can read

## use case
imagine each account could have global values like links to other important information connected to this account  
e.g. social media links of account owner, etc., etc.

## problem
accounts do not have their own global state

## solution
AlgoGlobalState is a simple dApp that allows accounts to keep a local state on it  
if the community would identify this dApp as **the** global state dApp, the local state would be quasi global

## first, an account should opt-into the dApp
`goal app optin --app-id=$APP_ID --from $USER`

## state
any account can save upto 16 key value pairs (of strings)

## read
any one can read anyone's state  
use `app_local_get_ex` from `TEAL`  
or  
`goal app read --app-id=$APP_ID --local --from $USER`  
or  
web2:
query chain e.g. algoexplorer  
https://algoexplorer.io/address/$USER -> Apps -> Connected -> $APP_ID -> local state  
(on algoexplorer, it is displayed in base64)  

## write
make an appCall with 2 app args ~ the first is the key ~ the second is the value  
`goal app call --app-id=$APP_ID --from $USER --app-arg="str:$KEY" --app-arg="str:$VALUE"`

## delete
to delete key k, write an empty string "" as the value of k  
`goal app call --app-id=$APP_ID --from $USER --app-arg="str:$KEY" --app-arg="str:"`

## security
all the key value pairs are public  
the code is very simple and mainly consists of the following:
```
txn Sender
txna ApplicationArgs 0
txna ApplicationArgs 1
app_local_put
```

## live values
// testnet
`APP_ID=100541892`
// mainnet
`APP_ID=`