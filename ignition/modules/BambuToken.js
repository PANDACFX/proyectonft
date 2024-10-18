// ignition/modules.js 
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules"); 
 
module.exports = buildModule("BambuToken", (m) => { 
  const bambuToken = m.contract("BambuToken"); 
 
  return { bambuToken }; 
});