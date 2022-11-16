//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract EventExample {

    mapping(address => uint) public tokenBalance;

    event TokensSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }

    //vm으로 하면 return 값 (밑에 창에서 펼쳐보면 decoded output 이 있으나
    //실제론 return이 안되기 때문에  메타마스크 사용하면 decoded output이 없음
    //가상과 실제의 차이는 출력값의 유무
    // 어떻게 스계를 개시한 사람에게 리턴값을 줄까 = 이벤트
    //logs에 뜸
}