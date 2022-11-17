pragma solidity >= 0.7.0 < 0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    receive() external payable {

    }
}
/*
소유자 논리를 하나의 스마트 계약에 직접 포함하는 것은 감사하기가 쉽지 않습니다.
 그것을 더 작은 부분으로 나누고 이를 위해 OpenZeppelin의 기존 감사 스마트 계약을 재사용합시다.
  최신 OpenZeppelin 계약에는 더 이상 isOwner() 함수가 없으므로 직접 만들어야 합니다.
   owner()는 Ownable.sol 컨트랙트의 함수입니다.
*/