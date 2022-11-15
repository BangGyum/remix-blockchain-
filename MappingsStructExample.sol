pragma solidity >= 0.7.0 < 0.9.0;

contract MappingsStructExample {

    struct Payment { //구조체는 항상 대문자 시작
        uint amount; 
        uint timestamp;

    }
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    //mapping(address => uint) public balacneReceived; 
    mapping(address => Balance) public balacneReceived; 

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function sendMoney() public payable{
        balacneReceived[msg.sender].totalBalance += msg.value; //보내는 금액만큼 잔고 증가

        Payment memory payment = Payment(msg.value, block.timestamp);

        //payment를 balanceReceived 매핑에 추가해야함. 그리고 그 안에 매핑 payments에도 추가해야함.
        balacneReceived[msg.sender].payments[balacneReceived[msg.sender].numPayments] = payment;  //balacneReceived[msg.sender].payments [-balacneReceived[msg.sender].numPayments-]
        balacneReceived[msg.sender].numPayments ++ ; //인덱스 기반이라 

    }
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balacneReceived[msg.sender].totalBalance >= _amount,"not enough funds") ; //이사람의 잔고가 충분한지
        balacneReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public{ //checks effects interaction 패턴
        uint balanceToSend = balacneReceived[msg.sender].totalBalance; //조회하는 사람의 매핑 금액
        balacneReceived[msg.sender].totalBalance = 0 ;
        _to.transfer(balanceToSend); //스.계 외의 외부 주소 등의 외부와 상호작용
    }


} 