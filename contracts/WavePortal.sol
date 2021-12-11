// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0; // Solidity compiler version, only use this version and nothing lower. Should be same compiler version as in hardhat.config.js

import "hardhat/console.sol"; // Allows us to console logs

contract DoughnutPortal {
   uint256 totalDoughnuts; // state variable, stored permanently in contract storage, initialized at 0

   uint256 private seed; // Generate random number

   // Solidity event:
   event NewDoughnut(address indexed from, uint256 timestamp, string message);

   // Doughnut struct = custom datatype where can can customize what we want to hold inside of it.
   struct Doughnut {
      address doughnuter; // address of user who gave a doughnut
      string message; // message the user sent
      uint256 timestamp; // timestamp when user gave doughnut
   }

   //Declare variable doughnuts that allows storing an array of structs. This will show all the doughnuts that are sent.
   Doughnut[] doughnuts;

   mapping(address => uint256) public lastDoughnuted;

   constructor() payable {
      console.log("Hiya, I'm a contract and I'm smart");

      // Set the initial seed:
      seed = (block.timestamp + block.difficulty) % 100;
   }

   function doughnut(string memory _message) public {

      require(lastDoughnuted[msg.sender] + 15 minutes < block.timestamp,
      'Wait 15 minutes');

      lastDoughnuted[msg.sender] = block.timestamp;

      totalDoughnuts += 1;
      console.log("%s has sent a yummy doughnut", msg.sender); // msg.sender is the wallet address of the person who called the function. 

      //Store doughnut data in the array
      doughnuts.push(Doughnut(msg.sender, _message, block.timestamp));

      seed = (block.difficulty + block.timestamp + seed) % 100;
      console.log('Random # generated: %d', seed);

      if (seed <= 50) {
         console.log('%s won!', msg.sender);

         uint256 prizeAmount = 0.0001 ether;
         require(
            prizeAmount <= address(this).balance, 'Trying to withdraw more money than the contract has.'
         );
         (bool success, ) = (msg.sender).call{value: prizeAmount}("");
         require(success, "Failed to withdraw money from contract.");
      }

      emit NewDoughnut(msg.sender, block.timestamp, _message);

   }

   function getAllDoughnuts() public view returns (Doughnut[] memory) {
      return doughnuts;
   }

   function getTotalDoughnuts() public view returns (uint256) {
      console.log ("We have %d total doughnuts", totalDoughnuts);
      return totalDoughnuts;
   }
} // The actual contract looks like a class