import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import VotingContract from "./Voting.json";

function App() {
  const [elections, setElections] = useState([]);
  const [account, setAccount] = useState("");
  const [votingContract, setVotingContract] = useState(null);

  useEffect(() => {
    loadBlockchainData();
  }, []);
  

  const loadBlockchainData = async () => {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contractAddress = "0xYourContractAddress"; // Dirección del contrato desplegado
      const contract = new ethers.Contract(contractAddress, VotingContract.abi, signer);

      setVotingContract(contract);

      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      setAccount(accounts[0]);

      const electionsCount = await contract.electionsCount();
      let electionsArray = [];
      for (let i = 1; i <= electionsCount; i++) {
        const election = await contract.elections(i);
        electionsArray.push(election);
      }
      setElections(electionsArray);
    }
  };

  const createElection = async (name) => {
    await votingContract.createElection(name);
  };

  return (
    <div>
      <h1>Voting DApp</h1>
      <p>Account: {account}</p>
      <h2>Create New Election</h2>
      <button onClick={() => createElection("My Election")}>Create Election</button>
      <h2>Existing Elections</h2>
      {elections.map((election, index) => (
        <div key={index}>
          <p>Election Name: {election.name}</p>
        </div>
      ))}
    </div>
  );
  return (
    <div className="App">
      <h1>Voting DApp</h1>
    </div>
  );
}

export default App;
