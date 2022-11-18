pragma solidity >= 0.7.0 < 0.9.0;
import "./Owned.sol";

contract SimpleWallet is Owned {

    function withDrawMoney(address payable _to,uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    fallback () external payable {}


}