//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundeMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract FundMeTestIntegration is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    DeployFundeMe d;

    function setUp() public {
        vm.deal(USER, 100 ether);
        d = new DeployFundeMe();
        fundMe = d.run();
    }

    function testUserCanFund() external {
        FundFundMe f = new FundFundMe();
        f.fundFundMe(address(fundMe));

        WithdrawFundMe wf = new WithdrawFundMe();
        wf.withdrawFundMe(address(fundMe));

        assertEq(address(f).balance == 0, true);
    }
}
