// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract FunctionTypes {
    uint x = 0;

    function privatePure() private pure returns (uint) {
        return 0;
    }

    function internalPure() internal pure returns (uint) {
        return 100;
    }

    function externalPure() external pure returns (uint) {
        return 300;
    }

    function publicPure() public pure returns (uint) {
        return 200;
    }


    function privateView() private view returns (uint) {
        return x;
    }

    function internalView() internal view returns (uint) {
        return x;
    }

    function externalView() external view returns (uint) {
        return x;
    }

    function publicView() public view returns (uint) {
        return x;
    }

    // internal and public function cannot be payable
    /*
    function privatePayable() private payable returns (uint) {
        return x;
    }

    function internalPayable() internal payable returns (uint) {
        return x;
    }
    */

    function externalPayable() external payable returns (uint) {
        return x;
    }

    function publicPayable() public payable returns (uint) {
        return x;
    }

}

contract Child is FunctionTypes {
    function example() external {
        internalPure();
        this.externalPure();
        publicPure();
        internalView();
        this.externalView();
        publicView();
        this.externalPayable();
        publicPayable();
    }
}

