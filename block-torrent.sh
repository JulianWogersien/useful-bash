#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "This Script requires sudo."
    exit 1
fi

if [ "$1" = "-r" ]; then

    echo "This will erase ALL custom iptables rules. Proceed? (y/n)"
    read -r answer

    if [ "$answer" != "y" ]; then
        echo "Did not do anything, exiting..."
        exit 1
    fi

    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT

    iptables -F INPUT
    iptables -F OUTPUT
    iptables -F FORWARD
else
    echo "Note: This does NOT block for example encrypted ssl traffic and its very loose with what it blocks"
    echo "Continue anyways? (y/n)"
    read -r answer

    if [ "$answer" != "y" ]; then
        echo "Did not do anything, exiting..."
        exit 1
    fi

    iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
    iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
    iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
    iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
    iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP

    iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
    iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
    iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
fi
