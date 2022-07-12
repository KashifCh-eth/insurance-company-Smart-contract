// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


contract insuranceContract   {

 address Manger;
 uint policyamount;


 struct insurancecompany {
           string name ;
           bool Register ;
           bool Paid ;
           uint256 Amount;
           uint256 LicenseDate;
           uint256 LicenseExpire;
 }

 struct Policyholder {
        string name ;
        uint256 Area ;
        bool fund ;
        bool PolicyAmount;
 }
 
mapping (address => Policyholder) public Policyholders ;
mapping(address => insurancecompany) public insurancecompanys;
 

  constructor (){
                      Manger = msg.sender;
          }

function ChangeOwner (address _Change) public view  {
         _Change = Manger;
}

function Reg (address _company ,string memory _name) payable public 
{
    require(msg.value == 1 ether, 'License balance should be 1 ether');
    insurancecompanys[_company].name = _name; 
    insurancecompanys[_company].Register = true;
    insurancecompanys[_company].Paid = true; 
    insurancecompanys[_company].Amount = msg.value ;
    insurancecompanys[_company].LicenseDate = block.timestamp; 
    insurancecompanys[_company].LicenseExpire = block.timestamp + 31536000;
}

function allowHolder(bool condition) public onlyOwner{
  Policyholders[msg.sender].PolicyAmount = condition;
}
function policyamounts(uint256 amount) public  view onlyOwner{
  amount = policyamount;
}

function PolicyHolder(address _holder , string memory name , uint256 Area ) payable public  {
  require (msg.value ==  policyamount,'not Match policyamount');
  Policyholders[_holder].name=name;
  Policyholders[_holder].Area=Area;
  
  
}
      
function withdrawforHolder( address payable _recip , uint256 _area ) public {
      require(Policyholders[msg.sender].PolicyAmount = true,'not allowed from company' );
      require(Policyholders[msg.sender].fund == false,'alredy funded');
      require(Policyholders[msg.sender].Area == _area);
     _recip.transfer(1 ether);
      Policyholders[msg.sender].fund = true;
}
function withdrawForCompany( address payable _recip ) public {
    require (insurancecompanys[msg.sender].Paid,'Not Paid in License');
    require (insurancecompanys[msg.sender].LicenseExpire < block.timestamp, 'LicenseExpired');
    _recip.transfer(address(this).balance);
}
modifier onlyOwner (){
    require(msg.sender==Manger,'Only Manger Can Change ');
    _;
}

}
