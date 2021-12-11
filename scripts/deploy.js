
const main = async () => {

   const doughnutContractFactory = await hre.ethers.getContractFactory('DoughnutPortal');
   const doughnutContract = await doughnutContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.001'),
   });
   await doughnutContract.deployed();
   
   console.log('DoughnutPortal address', doughnutContract.address)
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