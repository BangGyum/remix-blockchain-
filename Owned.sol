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