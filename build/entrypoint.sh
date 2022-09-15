#!/bin/sh
# shopt -s nocasematch

# Script reads relays from files according to network and mode chosen
# Files need an extra return at the end of each file due to "read"

RELAYS="${ADDITIONAL_RELAYS:-}"

read_relays () {
  while IFS= read -r line
  do
    if [ "$RELAYS" == "" ]; then
        echo $line
        RELAYS="$line"
    else
        RELAYS="$RELAYS,$line"
        echo $line
    fi
  done < "/$1/$(echo "$2" | awk '{print tolower($0)}')"
}

echo "Running network: ${NETWORK}"
echo "Using relay mode: ${RELAY_MODE}"
echo "Adding user defined relays: ${ADDITIONAL_RELAYS}"
if [[ "${ONLY_USER_RELAYS}" == U* ]]; then
    read_relays "${NETWORK}" "${RELAY_MODE}"
    echo "Using following relay list: $RELAYS"
fi

# case ${RELAY_MODE} in

#   "ethical")

#     if [ -z "$RELAYS" ]; then
#         RELAYS="https://0xad0a8bb54565c2211cee576363f3a347089d2f07cf72679d16911d740262694cadb62d7fd7483f27afd714ca0f1b9118@bloxroute.ethical.blxrbdn.com"
#     else
#         RELAYS="${RELAYS},https://0xad0a8bb54565c2211cee576363f3a347089d2f07cf72679d16911d740262694cadb62d7fd7483f27afd714ca0f1b9118@bloxroute.ethical.blxrbdn.com"
#     fi
#     ;;

#   "compliant")
#     if [ -z "$RELAYS" ]; then
#         RELAYS="https://0xac6e77dfe25ecd6110b8e780608cce0dab71fdd5ebea22a16c0205200f2f8e2e3ad3b71d3499c54ad14d6c21b41a37ae@boost-relay.flashbots.net,https://0xb0b07cd0abef743db4260b0ed50619cf6ad4d82064cb4fbec9d3ec530f7c5e6793d9f286c4e082c0244ffb9f2658fe88@bloxroute.regulated.blxrbdn.com"
#     else
#         RELAYS="${RELAYS},https://0xac6e77dfe25ecd6110b8e780608cce0dab71fdd5ebea22a16c0205200f2f8e2e3ad3b71d3499c54ad14d6c21b41a37ae@boost-relay.flashbots.net,https://0xb0b07cd0abef743db4260b0ed50619cf6ad4d82064cb4fbec9d3ec530f7c5e6793d9f286c4e082c0244ffb9f2658fe88@bloxroute.regulated.blxrbdn.com"
#     fi
#     ;;

#   "non-compliant")
#     if [ -z "$RELAYS" ]; then
#         RELAYS="https://0x8b5d2e73e2a3a55c6c87b8b6eb92e0149a125c852751db1422fa951e42a09b82c142c3ea98d0d9930b056a3bc9896b8f@bloxroute.max-profit.blxrbdn.com"
#     else
#         RELAYS="${RELAYS},https://0x8b5d2e73e2a3a55c6c87b8b6eb92e0149a125c852751db1422fa951e42a09b82c142c3ea98d0d9930b056a3bc9896b8f@bloxroute.max-profit.blxrbdn.com"
#     fi
#     ;;

#   "non-compliant-ethical")
#     if [ -z "$RELAYS" ]; then
#         RELAYS="${RELAYS}"
#     else
#         RELAYS="${RELAYS}"
#     fi
#     ;;
    
#   *)
#     if [ -z "$RELAYS" ]; then
#         RELAYS="https://0x8b5d2e73e2a3a55c6c87b8b6eb92e0149a125c852751db1422fa951e42a09b82c142c3ea98d0d9930b056a3bc9896b8f@bloxroute.max-profit.blxrbdn.com"
#     else
#         RELAYS="${RELAYS},https://0x8b5d2e73e2a3a55c6c87b8b6eb92e0149a125c852751db1422fa951e42a09b82c142c3ea98d0d9930b056a3bc9896b8f@bloxroute.max-profit.blxrbdn.com"
#     fi
#     ;;
# esac

exec /app/mev-boost -addr 0.0.0.0:18550 \
  -${NETWORK} \
  -relay-check \
  -relays $RELAYS \
  ${EXTRA_OPTS}