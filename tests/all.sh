// https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
// chrome://inspect/#devices

// set env vars for terminal
export ALGORAND_DATA="$HOME/node/testnetdata"
export WALLET=2i2i
export CODE_DIR=./code
export TXNS_DIR=./txns
export SYSTEM_APPROVAL_FILE=$CODE_DIR/state_approval_program.teal
export SYSTEM_CLEAR_FILE=$CODE_DIR/state_clear_program.teal
export CREATOR=2I2IXTP67KSNJ5FQXHUJP5WZBX2JTFYEBVTBYFF3UUJ3SQKXSZ3QHZNNPY
export APP_ID=100541892
export KEY=cv
export VALUE=1m1.io
export USER=OU63ZTRQ52BLI4L2APIB42W4AVUSIA52CPOC662T5YKTGQ5XKCE5UMI5RE
export USER2=RMKUQNJ7KGMRWANBQ3KNHEKWNI7EA7ESWV3DOB7XMTG7DMP3LPDCI4FUNI

// start goal, create wallet and account
goal node start
goal node status
goal node end
goal wallet new $WALLET
goal account new -w $WALLET
goal clerk send -a 1000000 -f $CREATOR -t $A -w $WALLET

// create AlgoGlobalState
goal app create --creator $CREATOR --approval-prog $SYSTEM_APPROVAL_FILE --clear-prog $SYSTEM_CLEAR_FILE --global-byteslices 0 --global-ints 0 --local-byteslices 16 --local-ints 0 --on-completion OptIn

// opt-in
goal app optin --app-id=$APP_ID --from $USER

// set key valvue
goal app call --app-id=$APP_ID --from $USER --app-arg="str:$KEY" --app-arg="str:$VALUE"

goal app call --app-id=$APP_ID --from $CREATOR --app-arg="str:cv" --app-arg="str:1m1.io"

// get
use `app_local_get_ex` from TEAL
or
goal app read --app-id=$APP_ID --local --from $USER
or
query chain e.g. algoexplorer