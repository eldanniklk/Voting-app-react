// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Voting.sol";

contract VotingTest is Test {
    Voting voting;

    function setUp() public {
        voting = new Voting();
    }

    function testCreateElection() public {
    voting.createElection("Election 1");

    ( , string memory name, , ) = voting.elections(1); // Obteniendo sólo el name
    assertEq(name, "Election 1");
}

}
