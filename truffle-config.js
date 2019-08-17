var HDWalletProvider = require("truffle-hdwallet-provider");
var Mnemonic = "adjust explain practice fossil grief bike kiss exit common pelican toilet cruel"
module.exports = {


  networks: {
  
    development: {
      host: "127.0.0.1",     
      port: 9545,           
      network_id: "*",   
    },

    rinkeby: {
      provider: function() { 
       return new HDWalletProvider(Mnemonic,"https://rinkeby.infura.io/54534d57dc294e12a6e3344a2bca16ee");
      },
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000,
  }
  
  },

  mocha: {
  },

  compilers: {
    solc: {
     
    }
  }
}
