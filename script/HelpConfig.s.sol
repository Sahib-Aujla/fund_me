//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelpConfig is Script {
    struct Help {
        address priceFeed;
    }

    Help public activeConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeConfig = sepoliaConfig();
        } else {
            activeConfig = anvilConfig();
        }
    }

    function sepoliaConfig() public pure returns (Help memory) {
        Help memory h = Help(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return h;
    }

    function anvilConfig() public returns (Help memory) {
        if (activeConfig.priceFeed != address(0)) {
            return activeConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mock = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();

        Help memory h = Help(address(mock));
        return h;
    }
}
