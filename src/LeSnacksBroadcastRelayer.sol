// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./interface/IPushCommInterface.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract LeSnacksBroadcastRelayer is Ownable {
    constructor() {}

    function broadcastNotification(
        address channel,
        string memory title,
        string memory body
    ) external onlyOwner() {
        IPUSHCommInterface(0xb3971BCef2D791bc4027BbfedFb47319A4AAaaAa)
            .sendNotification(
                channel,
                channel,
                bytes(
                    string(
                        // We are passing identity here: https://docs.epns.io/developers/developer-guides/sending-notifications/advanced/notification-payload-types/identity/payload-identity-implementations
                        abi.encodePacked(
                            "0", // this is notification identity: https://docs.epns.io/developers/developer-guides/sending-notifications/advanced/notification-payload-types/identity/payload-identity-implementations
                            "+", // segregator
                            "1", // this is payload type: https://docs.epns.io/developers/developer-guides/sending-notifications/advanced/notification-payload-types/payload (1, 3 or 4) = (Broadcast, targetted or subset)
                            "+", // segregator
                            title, // this is notificaiton title
                            "+", // segregator
                            body // notification body
                        )
                    )
                )
            );
    }
}
