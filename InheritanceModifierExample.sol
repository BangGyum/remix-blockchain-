pragma solidity ^0.8.1;
import "./Owned.sol";

contract InheritanceModifierExample is Owned { //토큰을 생성하기 위한 스.계
        //해당 sol에선 제어자가 무엇인지, 그 활용법

    mapping(address => uint) public tokenBalance;

    //address owner;

    uint tokenPrice = 1 ether;

    constructor() {
        //owner = msg.sender;
        tokenBalance[owner] = 100;
    }
    // modifier onlyOwner { //제어자, 해당 함수의 public 과 중괄호 사이
    //     require(msg.sender == owner, "You are not allowed"); }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        //우리가 소유자가 아니면 소각 미허용
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}
