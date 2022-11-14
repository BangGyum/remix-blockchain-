pragma solidity >= 0.7.0 < 0.9.0;

contract SimpleMappingExaple{
    //일반적으로 매핑은 키워드 mapping 부터 시작.
    //키, 값
    //키는 보통 
    //다른 매핑이나 스마트계약 or 주소나 정수같은 기초변수 제외하곤 거의 다 가능
    //초기값은 기존대로
    mapping(uint=>bool) public myMapping;
    mapping(address=>bool) public myAddressMapping;

    //위만 컴파일하면, 알아서 myMapping getter 함수가 생성되고, uint256을 입력 가능
    //해시 맵같은 느낌으로 키로 접근
    //배열처럼 저장되나봄. 0,1,2,3,4 다 기본 false로 저장돼 있음.

    function setValue(uint _index) public {
        myMapping[_index]= true;
    }
    function setMyAddressTrue() public {
        myAddressMapping[msg.sender] = true; // 이 트랜잭션을 초기화(실행?) 주소가 됨
    }

}