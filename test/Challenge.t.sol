// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IChallenge, CHALLENGE_1, CHALLENGE_2, Challenge} from "../src/Challenge.sol";

contract ChallengeTest is Test {
    IChallenge c1;
    IChallenge c2;

    Challenge c;

    function setUp() public {
        c1 = IChallenge(CHALLENGE_1);
        c2 = IChallenge(CHALLENGE_2);

        c = new Challenge();
    }

    function test_exp2ForkFuzz(uint256 x) external {
        vm.skip(true, "part of challenge contract");
        assertEq(c1.exp2(x), c2.exp2(x));
    }

    function test_exp2Fuzz(uint256 x) external {
        vm.skip(true, "part of challenge contract");
        assertEq(c.exp2(x), c.h().exp2(x));
    }

    function check_halmos_exp2(uint256 x) external {
        assert(c.compare(x));
    }

    function test_exp2Unit() external {
        uint256 x = 2324289753287403503615;
        assertEq(c.exp2(x), c.h().exp2(x));
    }
}
