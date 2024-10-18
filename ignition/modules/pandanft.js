const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("PandaNFTModule", (m) => {
  const BambuToken = "0xcc33C5883c13327391B96a792cDC39A650163039"; // Reemplaza con la dirección real del contrato BambuToken

  const pandaNFT = m.contract("PandaNFT", {
    args: [BambuTokenAddress],
  });

  return { pandaNFT };
});