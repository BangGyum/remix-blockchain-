pragma solidity >= 0.7.0 < 0.9.0;
import "./Allowance.sol";

contract SimpleWalletGit2 is Allowance {
    event moneyWithdraw(address indexed _beneficiary, uint _amount);
    event moneyReceive(address indexed _from, uint _amount);

    function withDrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) { //소유자는 무제한 인출 가능, 소유자가 아닌경우 허용 인출만 가능
        require(address(this).balance >= _amount, "there are not enough funds stored in the smart contract");
        
        if(isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit moneyWithdraw(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }

    fallback () external payable {
        emit moneyReceive(msg.sender,msg.value);

    }


}