
const main = async () => {
   const doughnutContractFactory = await hre.ethers.getContractFactory('DoughnutPortal'); // compiles the contract. hre = Hardhat Runtime Environment
   const doughnutContract = await doughnutContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.1'), // This removes 0.1eth from my wallet and uses it to fund the contract.
   }); // Hardhat creates a local ETH network, then will destroy it. Everytime contract is run, it's a fresh blockchain eg like refreshing your local server
   await doughnutContract.deployed(); // Wait until contract is deployed!
   console.log('Contract addy:', doughnutContract.address);

   //Get contract balance:
   let contractBalance = await hre.ethers.provider.getBalance(
      doughnutContract.address
   );
   console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

   //Send doughnut
   let doughnutTxn = await doughnutContract.doughnut('This is doughnut #1!');
   await doughnutTxn.wait(); // wait for transaction to be mined

   let doughnutTxn2 = await doughnutContract.doughnut('This is doughnut #2!');
   await doughnutTxn2.wait(); // wait for transaction to be mined

   //Get contract balance to see what happened:
   contractBalance = await hre.ethers.provider.getBalance(doughnutContract.address);
   console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

   let allDoughnuts = await doughnutContract.getAllDoughnuts();
   console.log(allDoughnuts);
};

const runMain = async () => {
   try {
      await main();
      process.exit(0);
   } catch (error) {
      console.log(error);
      process.exit(1);
   }
};

runMain();