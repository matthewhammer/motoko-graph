echo PATH = $PATH
echo vessel @ `which vessel`

echo
echo == Build.
echo

dfx start --background
dfx canister create --all
dfx build

echo
echo == Start service.
echo

dfx canister install BigText

echo
echo == Test service.
echo

dfx canister install BigText
dfx canister call BigText selfTest
LOOP="(true)";
while [ "$LOOP" == "(true)" ]; do
    LOOP=$(dfx canister call BigText doNextCall)
done
