pragma solidity ^0.8.1;

contract SendMoneyExample{ 

    uint public balacneReceived; //이거 실시간으로 저장되는 게 아님
                //근데 당연한거 아닌가? withdraw하면 얘는 빼는 펑션이 없잖아

    //계정에서 스마트계약으로 에테르를 전송
    function receiveMoney() public payable { //돈받으려면 payable , 컴파일러가 이 함수로 돈받는다고 인식
    //여기다가 돈을 얼마나 받았는지 기록
        balacneReceived += msg.value;  //메세지는 이 트랜잭션으로 전송된 금액이 웨이로 들어가 있음.

    }

    function getBalance() public view returns(uint){ //리믹스는 잔고 확인 펑션을 만들어줘야하나?
        return address(this).balance; 
         // this는 해당 계약, 
    }

    //돈 빼내오자
    function withdrawMoney() public{
        address payable to = msg.sender; //이 주소로 돈을 보내고싶다고 명확하게 payable로 해줌
        
        to.transfer(this.getBalance()); //전송 함수, 인자는 위 변수에 저장돼 있는 주소로 전송하려는 웨이 양
    }

    function withdrawMoneyTo(address payable _to) public{ //payable 안써도됨. 에테르 안받아서
        _to.transfer(this.getBalance());
    }


    



}