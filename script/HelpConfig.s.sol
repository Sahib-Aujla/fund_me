//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";

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
        return Help(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function anvilConfig() public pure returns (Help memory) {
        return Help(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
}
