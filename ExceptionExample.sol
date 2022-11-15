pragma solidity >= 0.7.0 < 0.9.0;

contract ExceptionExample {
    mapping(address=>uint64) public balanceReceived; //가스 아끼려고 64로 제한, 15에테르 정도

    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        //balanceReceived[msg.sender] += msg.value;
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount >=balanceReceived[msg.sender],"not enough money");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount );
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    //위 상태에서는 15정도만 저장이 되기에, 실제로 10보내고 10보내면 , 1555~~ 로 저장돼 있음
    //때문에 보통 Assert  체크를 사용해서 내부 상태가 훼손되지 않도록 해야함

}