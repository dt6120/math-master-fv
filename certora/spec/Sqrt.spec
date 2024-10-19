methods {
    function mathMastersSqrt(uint256) external returns uint256 envfree;
    function solmateSqrt(uint256) external returns uint256 envfree;
    function uniSqrt(uint256) external returns uint256 envfree;
}

rule check_sqrt(uint256 x) {
    assert(mathMastersSqrt(x) == uniSqrt(x));
}

invariant check_sqrtInvariant(uint256 x)
    mathMastersSqrt(x) == uniSqrt(x);