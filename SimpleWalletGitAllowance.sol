pragma solidity >= 0.7.0 < 0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);    //allowance의 변경을 알림, 수신 /발신 /이전금액, /새로운금액
                                                                                                            //추후 이벤트 사이트 체임에서 쉽게 검색할 수 있도록 indexed 추가, 

    mapping(address => uint) public allowance; //이제 밑에 허용 함수 추가

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount); //새금액은 amount로 알려주자
        allowance[_who] = _amount;//인출 가능 금액 설정
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner()|| allowance[msg.sender] >= _amount , "You are not allowed!!!" );
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal { //인출한 만큼 허용량 줄여주기
    emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;

    }
}

contract SimpleWalletGit2 is Allowance {
    event moneyReceive();
    event moneyWithdraw();

    function withDrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) { //소유자는 무제한 인출 가능, 소유자가 아닌경우 허용 인출만 가능
        require(address(this).balance >= _amount, "there are not enough funds stored in the smart contract");
        
        if(isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    fallback () external payable {}


}