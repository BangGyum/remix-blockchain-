pragma solidity >= 0.7.0 < 0.9.0;
import "./_76_Item.sol";
import "./Owned.sol";
/*두가지 접근
1.Manager 스마트계약과 직접 상호 작용할 수 있도록 한 다음
  좀더 깊이 들어가 고객이 돈을 보낼 Item 스.계를 추가로 만듬
*/
contract ItemManager is Owned{
    enum supplyChainState{Created, Paid, Delivered}

    struct s_item{
        Item _item;
        string _identifier;
        uint _itemPrice;
        ItemManager.supplyChainState _state;
    }

    mapping(uint => s_item) public items;
    uint itemIndex ;

    event SupplyChainStep(uint _itemIndex, uint _step,address _itemAddress);
                                                    //이론적으로 이 아이템 주소를 고객한테 주면
                                                    // 고객은 돈을 넣을 수 있음
 
    function createItem(string memory _identifier, uint _priceInWei) public onlyOwner {
        Item item = new Item(this, _priceInWei, itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _priceInWei;
        items[itemIndex]._state = supplyChainState.Created;

        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
        itemIndex++;
    }
 
    function triggerPayment(uint _index) public payable { //이 함수의 함수서명은 triggerPayment(uint)
        require(items[_index]._itemPrice <= msg.value, "Not fully paid");
        require(items[_index]._state == supplyChainState.Created, "Item is further in the supply chain");
        items[_index]._state = supplyChainState.Paid;
        emit SupplyChainStep(_index, uint(items[_index]._state), address(items[_index]._item));
}
 
    function triggerDelivery(uint _index) public onlyOwner {
        require(items[_index]._state == supplyChainState.Paid, "Item is further in the supply chain");
        items[_index]._state = supplyChainState.Delivered;
        emit SupplyChainStep(_index, uint(items[_index]._state), address(items[_index]._item));
    }
    

}