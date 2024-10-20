// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IChallenge, CHALLENGE_1, CHALLENGE_2} from "../src/Challenge.sol";

contract ChallengeTest is Test {
    IChallenge c1;
    IChallenge c2;

    function setUp() public {
        c1 = IChallenge(CHALLENGE_1);
        c2 = IChallenge(CHALLENGE_2);
    }

    function test_exp2Fuzz(uint256 x) external {
        assertEq(c1.exp2(x), c2.exp2(x));
    }
}
