//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    function fundFundMe(address mostRecent) public {
        vm.startBroadcast();
        FundMe(payable(mostRecent)).fund{value: 1 ether}();
        vm.stopBroadcast();
        console.log("done");
    }

    function run() external {
        address recentDeployment = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(recentDeployment);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecent) public {
        vm.startBroadcast();
        FundMe(payable(mostRecent)).withdraw();
        vm.stopBroadcast();
        console.log("done");
    }

    function run() external {
        address recentDeployment = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(recentDeployment);
    }
}
