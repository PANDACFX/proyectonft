
// ignition/modules.js
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("BambuTokenModule", (m) => {
    const BambuToken = m.contract("BambuToken", {
      from: m.deployer,
      args: [], // Constructor arguments
    });
  
    return { BambuToken };
  });