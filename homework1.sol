pragma solidity >= 0.7.0 < 0.9.0;
import "./Owned.sol";
/*
Deposit Funcds with fallback function
Withdrawal fucntion
Permissions using modifier ( 권한분리, 권한승인을 위해 제어자)
*/

contract homework is Owned{

    mapping(address => uint) public balance;

    function receiveMoney() public payable {

    }


}