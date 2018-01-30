pragma solidity ^0.4.19;

contract MultiBenTrust {

    string public trustName;
    address public owner;
    address[] public beneficiaries;
  
    function MultiBenTrust(string _trustName) payable public {
        trustName = _trustName;
        owner = msg.sender;
    }
     
    function registerBeneficiary (address _ben) payable public {
        // Only the owner can register beneficiaries
        require (msg.sender == owner);
        beneficiaries.push(_ben);
    }

    function deposit() payable public returns (bool) {
       return true;
    }
     
    function withdraw (uint percentage) payable public returns (bool) {

        // percentage must be greater than zero and less than or equal to 100
        require (percentage > 0 && percentage <= 100);
 
        uint256 beforeBalance = this.balance;
        uint i = 0;
        for (i; i < beneficiaries.length; i++) {
            beneficiaries[i].transfer(beforeBalance / beneficiaries.length * percentage / 100);
        }
        return true;
    }
}