pragma solidity ^0.8.1;

contract Owned{ //이것을 상속, 확장 (솔리디티는 다중상속도 가능)
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    //제어자를 활용하는 중앙 집중 방식의  기본 구조 사용
    //제어자를 추가 및 활용
    modifier onlyOwner { //제어자, 해당 함수의 public 과 중괄호 사이
        require(msg.sender == owner, "You are not allowed");
        _; //밑에 createNewToken 함수 본문이 밑줄 위치로 복사됨
            //그런다음 함수 본문에 다시 복사됨
    }

} 

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
