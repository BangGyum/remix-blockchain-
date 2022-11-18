pragma solidity >= 0.7.0 < 0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SimpleWalletGit2 is Ownable {

    function withDrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    fallback () external payable {}


}