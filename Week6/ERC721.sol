// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint balance);
    
    function ownerOf(uint tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from, 
        address to,
        uint tokenId
    ) external;

    function safeTransferFrom(
        address from, 
        address to,
        uint tokenId,
        bytes calldata data
    ) external;

    function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external;

    function approve(address to, uint tokenId) external;
    
    function getApproved(uint tokenId) external view returns (address operator);
    
    function setApprovalForAll(address operator, bool _approved) external;
    
    function isApprovedForAll(address owner, address operator)
        external
        view
        returns (bool);
}


// contract address could implement logic to handle ERC721 
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract ERC721 is IERC721 {
    event Transfer(address indexed from , address indexed to, uint indexed id);
    event Approval(address indexed owner, address indexed spender, uint indexed id);
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    mapping(uint => address) internal _ownerOf;
    mapping(address => uint) internal _balanceOf;

    // tokenId => address approved to spent 
    mapping(uint => address) internal _approvals;

    // address of owner => (address approved to spent all of the tokens owner own => true)
    // 
    // Solidity will automated generated public getter for public state variable
    // so this state variable also implements IERC721 isApprovedForAll function
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    // check input interfaceId matches IERC721 or IERC165
    function supportsInterface(bytes4 interfaceId) external view returns (bool){
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId;
    }

    function balanceOf(address owner) external view returns (uint balance) {
        require(owner != address(0), "owner = zero address");
        return _balanceOf[owner];
    }
    
    function ownerOf(uint tokenId) external view returns (address owner) {
        owner = _ownerOf[tokenId];
        require(owner != address(0), "owner = zero address");
    }

    // if to is a contract address, need to call onERC721Received function
    // make sure the contract implement logic to handle ERC721 
    function safeTransferFrom(
        address from, 
        address to,
        uint tokenId
    ) external {
        transferFrom(from, to, tokenId);
        
        require(
            to.code.length == 0 || // to is eoa address
            IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, "") ==
            IERC721Receiver.onERC721Received.selector, // to is contract address, 
            "unsafe recipient"
        );
    }

    // if to is a contract address, need to call onERC721Received function
    // make sure the contract implement logic to handle ERC721 
    function safeTransferFrom(
        address from, 
        address to,
        uint tokenId,
        bytes calldata data
    ) external {
        transferFrom(from, to, tokenId);
        
        require(
            to.code.length == 0 || // to is eoa address
            IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) ==
            IERC721Receiver.onERC721Received.selector, // to is contract address, 
            "unsafe recipient"
        );
    }

    // We will reuse this function internally, so change function visibility to public
    function transferFrom(
        address from,
        address to,
        uint tokenId
    ) public {
        require(from == _ownerOf[tokenId], "from != owner");
        require(to != address(0), "to = zero address");
        require(_isApprovedOrOwner(from, msg.sender, tokenId), "not authorized");
        
        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[tokenId] = to;
        
        delete _approvals[tokenId];

        emit Transfer(from, to, tokenId);
    }

    function approve(address to, uint tokenId) external {
        address owner = _ownerOf[tokenId];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender], "not authorized"
        );
        _approvals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }
    
    function getApproved(uint tokenId) external view returns (address operator) {
        require(_ownerOf[tokenId] != address(0), "token doesn't exist");
        return _approvals[tokenId];
    }
    
    function setApprovalForAll(address operator, bool _approved) external {
        isApprovedForAll[msg.sender][operator] = _approved;
        emit ApprovalForAll(msg.sender, operator, _approved);
    }
    
    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint tokenId
    ) internal view returns (bool) {
        return (
            spender == owner ||
            isApprovedForAll[owner][spender] ||
            spender == _approvals[tokenId]
        );
    }

    function _mint(address to, uint tokenId) internal {
        require(to != address(0), "to = zero address");
        require(_ownerOf[tokenId] == address(0), "token exists");

        _balanceOf[to]++;
        _ownerOf[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    function _burn(uint tokenId) internal {
        address owner = _ownerOf[tokenId];
        require(owner != address(0), "token does not exist");

        _balanceOf[owner]--;
        delete _ownerOf[tokenId];
        delete _approvals[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }
}

contract RobinNft is ERC721 {
    
    // everyone can mint erc721 token if that token id doesn't own by any address
    function mint(address to, uint tokenId) external {
        _mint(to, tokenId);
    }
    function burn(uint tokenId) external {
        require(msg.sender == _ownerOf[tokenId], "not owner");
        _burn(tokenId);
    }
}