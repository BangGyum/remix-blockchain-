pragma solidity >= 0.7.0 < 0.9.0;

import "./_76_ItemManager.sol";
contract Item { //지불 받은 뒤 해당 지불을 ItemManager로  다시 처리 역할
                //따라서 계약 생성 시 추출 항목에 대한 새 인스턴스 지정
                //그래서 인댁스는 i.m에서 얻지만, 실제 지불은 해당 item에서 
    uint public priceInWei;
    uint public paidWei;    
    uint public index;
    uint public pricePaid;
        //아이템 지불이 됐는지  확인
 
    ItemManager parentContract;
 
    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
 
    receive() external payable {
        require(pricePaid ==0 , "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed") ; //전체지불만
        pricePaid += msg.value;
            //나중에 누군가 인출 할 수 있또록
            //수령금액을 i.m으로 보내주기 위한 코드를 
            //첫번째 방법
            //address(parentContract).transfer(msg.value);
            //위의 문제는 i.m에서 어떤 아이템에대한 돈을 보냈는지 알 수 없져
            //따라서 인덱스에 매핑된 아이템 주소를 추가로 매핑
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",index)); //스계로 보내는 전체 금액
        require(success, "Delivery did not work");     
                            //그리고 이것과 함께 보낼 데이터도 설정
                            //가로안에 함수 서명 생성시 사용할 수 있는 특수함 수
                            //2번쨰 매개변수는  어떤 종류의 인덱스를 입력할 것인지.

                            //call 함수는 두개의 return 값 제공
                            //하나는 성공했을떄 불린 / 하나는 return값이 있는 경우
                            //근데 우리가 지정한 함수 트리거에는 리턴이 없기떄문에 하나만 리턴함

    }
 
    fallback () external {
        
    }
 
}
