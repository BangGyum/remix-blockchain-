pragma solidity >= 0.7.0 < 0.9.0;

contract test {
    address owner;

    bool public paused; //초기값 거짓

    constructor() {
        owner = msg.sender; //스마트 게약을 배포하기 위해 트랜잭션을 만드는 주소

    } //생성자, 계약 배포 중 한번만 호출

    function sendMoney() public payable { //에테르 받는 역할

    } 
    function getBalance() public view returns(uint){ //리믹스는 잔고 확인 펑션을 만들어줘야하나?
        return address(this).balance; 
         // this는 해당 계약, 
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner , " You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public { //스마트 계약의 모든 잔금 전송
    /*
        if(msg.sender == owner ) {
            _to.transfer(address(this).balance);
        }else {
            new Exception(...)
        }
        */
        require(!paused,"Contract is paused");  
        require(msg.sender == owner, " You are not the owner"); //거짓이면 예외 발동, 트랜잭션 롤백, 그래서 그전에 뭔일이 있건 반영 x
        _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public  {//가로에 스마트 계약 안에 저장된 나머지 잔고를 받을 주소도 입력
        require(msg.sender==owner ," you are not the owner 3");
        selfdestruct(_to); //스마트계약 파기하려면 해당 내부함수 호출, 인자는 나머지 잔고를 받을 주소
            //msg.sender 로 하면 보낸애가 받겟지
    }

}