// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Election {
        uint id;
        string name;
        mapping(uint => Candidate) candidates;
        mapping(address => bool) hasVoted;
        uint candidatesCount;
        bool isActive;
    }

    mapping(uint => Election) public elections;
    uint public electionsCount;

    event ElectionCreated(uint electionId, string electionName);
    event CandidateAdded(uint electionId, uint candidateId, string candidateName);
    event VoteCast(uint electionId, uint candidateId, address voter);

    function createElection(string memory _name) public {
        electionsCount++;
        Election storage election = elections[electionsCount];
        election.id = electionsCount;
        election.name = _name;
        election.isActive = true;

        emit ElectionCreated(electionsCount, _name);
    }

    function addCandidate(uint _electionId, string memory _name) public {
        Election storage election = elections[_electionId];
        require(election.isActive, "Election is not active");
        election.candidatesCount++;
        election.candidates[election.candidatesCount] = Candidate(election.candidatesCount, _name, 0);

        emit CandidateAdded(_electionId, election.candidatesCount, _name);
    }

    function vote(uint _electionId, uint _candidateId) public {
        Election storage election = elections[_electionId];
        require(election.isActive, "Election is not active");
        require(!election.hasVoted[msg.sender], "You have already voted");

        Candidate storage candidate = election.candidates[_candidateId];
        require(bytes(candidate.name).length != 0, "Candidate does not exist");

        candidate.voteCount++;
        election.hasVoted[msg.sender] = true;

        emit VoteCast(_electionId, _candidateId, msg.sender);
    }

    function endElection(uint _electionId) public {
        Election storage election = elections[_electionId];
        require(election.isActive, "Election is already ended");
        election.isActive = false;
    }

    function getCandidate(uint _electionId, uint _candidateId) public view returns (string memory, uint) {
        Election storage election = elections[_electionId];
        Candidate storage candidate = election.candidates[_candidateId];
        return (candidate.name, candidate.voteCount);
    }
}
