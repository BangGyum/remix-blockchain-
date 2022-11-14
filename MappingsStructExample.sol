pragma solidity >= 0.7.0 < 0.9.0;

contract MappingsStructExample {
    mapping(address => uint) public balacneReceived;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function sendMoney() public payable{
        balacneReceived[msg.sender] += msg.value; //보내는 금액만큼 잔고 증가

    }
    function withdrawAllMoney(address payable _to) public{
        _to.transfer(address(this).balance);
    }


}