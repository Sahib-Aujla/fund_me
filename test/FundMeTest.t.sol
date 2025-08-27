//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        fundMe = new FundMe();
    }

    function testMinUSD() public {
        assertEq(fundMe.MINIMUM_USD(), 5 * 10 ** 18);
    }
}
