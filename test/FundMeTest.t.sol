//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundeMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        DeployFundeMe d = new DeployFundeMe();
        fundMe = d.run();
    }

    function testMinUSD() public view {
        assertEq(fundMe.MINIMUM_USD(), 5 * 10 ** 18);
    }

    function testGetVersion() public view{
        uint p = fundMe.getVersion();
        assertEq(p, 4);
    }
}
