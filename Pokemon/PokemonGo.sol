// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PokemonGo {
    struct Pokemon {
        string name;
        uint   atk;
        uint   def;
    }

    mapping(address => Pokemon[]) public addressToPokemons;

    function createPokemon(string calldata _name, uint _atk, uint _def) external {
        Pokemon memory pokemon = Pokemon(_name, _atk, _def);
        addressToPokemons[msg.sender].push(pokemon);
    }

    function getPokemons(address _address) public view returns (Pokemon[] memory) {
        return addressToPokemons[_address];
    }

    function payToIncreaseAtk(uint pid) external payable {
        require(msg.value >= 0.1 ether);
        Pokemon storage pokemon = addressToPokemons[msg.sender][pid];
        pokemon.atk += 10;
    }
}