pragma solidity ^0.4.19;

contract TrusteeMultiBenTrust {

    string public trustName;
    address public owner;
    address[] public beneficiaries;
    mapping (address => bool) public trustees;
  
    function TrusteeMultiBenTrust(string _trustName) payable public {
        trustName = _trustName;
        owner = msg.sender;
        registerTrustee (msg.sender);
    }
     
    function registerTrustee (address _trustee) payable public {
        // Only the owner can register beneficiaries
        require (msg.sender == owner);
        trustees[_trustee] = true;
    }
    
    function unregisterTrustee (address _trustee) payable public {
        // Only the owner can register beneficiaries
        require (msg.sender == owner);
        trustees[_trustee] = false;
    }

    function registerBeneficiary (address _ben) payable public {
        // Only the owner can register beneficiaries
        require (msg.sender == owner);
        beneficiaries.push(_ben);
    }
    
    function unregisterBeneficiary (address _ben) payable public {
        // Only the owner can register beneficiaries
        require (msg.sender == owner);
        uint i = 0;
        for (i; i < beneficiaries.length; i++) {
            if (beneficiaries[i] == _ben) {
                delete beneficiaries[i];
                return;
            }
        }
    }

    function deposit() payable public returns (bool) {
       return true;
     }
     
    function withdraw (uint percentage) payable public returns (bool) {
        // only a trustee can trigger a withdrawal
        require (trustees[msg.sender]);

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