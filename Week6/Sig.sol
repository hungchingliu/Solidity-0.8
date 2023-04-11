// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/*
0. message to sign
1. hash(message)
2. sign(hash(message), private key) | offchain
3. ecrecover(hash(message), signature) == signer
*/

contract VerifySig {
    function verify(address _signer, string memory _message, bytes memory _sig)
        external pure returns(bool) 
    {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns(bytes32) {
        return keccak256((abi.encodePacked(_message)));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public pure returns(address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure
        returns(bytes32 r, bytes32 s, uint8 v)
    {
        require(_sig.length == 65, "invalid signature length");
        
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
    // account = "0xad061d5e03dc82992a77c6693fed04245d4ce59e"
    // hash = "0xb9a5dc0048db9a7d13548781df3cd4b2334606391f75f40c14225a92f4cb3537" message: "aaa"
    // sig = "0x074297eb45d89ced89df33f6db75b39c2340321ef6759026ef270ea969e73b4f7cb34a45607837b1ce0a58530d0f91bc469a393393f9ea6b22deab43dcc6a21e1c"
}