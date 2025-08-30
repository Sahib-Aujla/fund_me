//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundeMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    DeployFundeMe d;

    function setUp() public {
        vm.deal(USER, 100 ether);
        d = new DeployFundeMe();
        fundMe = d.run();
    }

    function testMinUSD() public view {
        assertEq(fundMe.MINIMUM_USD(), 5 * 10 ** 18);
    }

    function testGetVersion() public view {
        uint256 p = fundMe.getVersion();
        assertEq(p, 4);
    }

    function testFundSuccessfully() public {
        //fund with eth
        vm.prank(USER);
        fundMe.fund{value: 1 ether}();
        //check if the funding is done
        assertEq(1 ether, fundMe.addressToAmountFunded(USER));
    }

    function testFundRevert() public {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.fund{value: 0 ether}();
    }

    function testWithdraw() public {
        //fund and then withdraw
        vm.prank(USER);
        fundMe.fund{value: 1 ether}();

        uint256 startingOwnerBalance = fundMe.i_owner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        vm.prank(fundMe.i_owner()); // ✅ withdraw as owner
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.i_owner().balance;
        uint256 endingContractBalance = address(fundMe).balance;

        assertEq(endingContractBalance, 0);
        assertEq(startingOwnerBalance + startingContractBalance, endingOwnerBalance);
    }

    function testOwner() external view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testReceive() external {
        vm.prank(USER);
        (bool success,) = address(fundMe).call{value: 1 ether}("");
        require(success, "Call failed");

        // Verify the funding was recorded
        assertEq(fundMe.addressToAmountFunded(USER), 1 ether);
        assertEq(address(fundMe).balance, 1 ether);
    }

    function testFallback() external {
        vm.prank(USER);
        (bool success,) = address(fundMe).call{value: 1 ether}("abcd");
        require(success, "Call failed");

        // Verify the funding was recorded
        assertEq(fundMe.addressToAmountFunded(USER), 1 ether);
        assertEq(address(fundMe).balance, 1 ether);
    }
}
