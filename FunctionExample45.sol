pragma solidity >= 0.7.0 < 0.9.0;

contract FunctionExample45 {
    mapping(address=>uint) public balanceReceived; //가스 아끼려고 64로 제한, 15에테르 정도

    address payable owner;

    constructor() public { //배포중 한번만 호출됨
        owner = payable(msg.sender);
    }   
    
    function getOwner() public view returns(address) {
        return owner;
    }
    function convertWeiToEth(uint _amount) public pure returns(uint) {
        return _amount / 1 ether; //1ether = 0이 18개
    }


    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner); //잔액을 소유자에게
    }


    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + uint(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount >=balanceReceived[msg.sender],"not enough money");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount );
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    //위 상태에서는 15정도만 저장이 되기에, 실제로 10보내고 10보내면 , 1555~~ 로 저장돼 있음
    //때문에 보통 Assert  체크를 사용해서 내부 상태가 훼손되지 않도록 해야함

/* //풀백 함수 인데 밑은 0.6 이전
    function () external payable { 
        receiveMoney();
    }
    */
// 0.6 이후
//receive는 순수하게 이더만 받을때 작동
//fallback 은 함수를 실행하면서 이더를 보낼때, 불려진 함수가 없을때 발동
    //기본형 : 불려진 함수가 특정 스마트 컨트랙에 없을때 fallback 함수 발동
    // fallback() external{

    // }
    //payable 적용 : 이더를 받고 나서도 fallback 함수 발동
    fallback() external payable {

    }
    receive() external payable {
        receiveMoney();
    }

}