// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract SaveGas {
    uint public n = 1000;

    function noCache() external view returns (uint) {
        uint s = 0;
        for (uint i = 0; i < n; i++) {
            s += 1;
        }
        return s;
    }

    function cache() external view returns (uint) {
        uint s = 0;
        uint _n = n;
        for (uint i = 0; i < _n; i++) {
            s += 1;
        }
        return s;
    }
}

/*
## no cache ##
n, gas
5, 4864
10, 7724
100, 47904
1000, 474504

## cache ##
n, gas
5, 4355
10, 6215
100, 39695
1000, 374495

When applying caching, gas usage does decrease a little but not as significant as the result shown in the video when N increases.
*/