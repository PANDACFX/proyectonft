async function main() {
    const bambuTokenAddress = "ADDRESS_OF_DEPLOYED_BAMBU_TOKEN";
    const PandaNFT = await ethers.getContractFactory("PandaNFT");
    const pandaNFT = await PandaNFT.deploy(bambuTokenAddress);
    await pandaNFT.deployed();
    console.log("PandaNFT deployed to:", pandaNFT.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });