pragma solidity ^0.5.7;

//https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ownership/Ownable.sol

//allows the contract to be owned by the deployer
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Item{
    
    struct itemStruct{
        string name;  
        bytes32 hash;
        bool isRequested;
        uint price;
        address item_owner;
        //address[] requests; //list of people who requested it
        
        
    }
    
    

}



//deployer of contract is the owner
contract RegisterItems is Ownable {
    
    
    //container for if user has many items
    struct metaItem{
        uint itemListSize;
        mapping(uint=>Item.itemStruct) itemList;
        
    }

    mapping(address => bool) userExists; //check if user exists
    mapping(bytes32 => bool) hashExists; //check if hash exists
    mapping(bytes32 => address) hashToUser;
    mapping(bytes32 => Item.itemStruct) hashToItem;
   
    mapping(address => metaItem) storedItem;//map user address to item (string test)
  
    event Owned(string words, address owner); //garbage event for debugging
    
    function registerNewItem(string memory  _name, uint _price)public payable returns (bool){
 
        bytes32 itemHash = keccak256(bytes(_name)); //make a hash to check for data existence
        
        //CHECK IF ITEM IS DUPLICATE
        if(hashExists[itemHash] == false){
            //initialize item
            /*
             string name;  
            bytes32 hash;
            bool isRequested;
            uint price;
            address owner;
       
            */
            
                                                            //string, bytes32, bool, uint,  address
            Item.itemStruct memory itemnew = Item.itemStruct(_name, itemHash,false,_price, msg.sender);
        
            
            //Set mappings
            hashExists[itemHash] = true;
            hashToUser[itemHash] = msg.sender;
            hashToItem[itemHash] = itemnew;
            
            //set users storedItem
            uint index = storedItem[msg.sender].itemListSize; //index is the size of user's size of items (metalist)
            storedItem[msg.sender].itemListSize++; //increase size
            storedItem[msg.sender].itemList[index] = itemnew; //put item in user's list
           
            
            
            if(userExists[msg.sender] == false){
                //set user to exists
                userExists[msg.sender] = true;
            }
            
            //require(msg.value == 22 ether); //set the price for registering-- goes to contract
            return true;
        }
        else{
            //emit Owned("This item already exists by: ", /*TODO:make findOwnerByItem trash*/ msg.sender);
            
            //DO NOTHING!!! Send verfication problems around!! TODO: figure out confilicts of verifcation
            return false;
        }

    }
    
    //fallback function ??!??
    // function () payable {
        
    // }
    
    
    function findOwnerByItem(bytes32 _hash) public view returns (address _owner){
        return hashToUser[_hash];
 
    }
    //TODO
    //list all items from a user
    function getItems(address _address)public view returns (bool) {  
        //number of items user has
        uint numItems = storedItem[_address].itemListSize;
        for(uint i = 0; i < numItems; i++){
            //find  a way to output ALL items: name + hash should be enough
            
            
        }
        
    }
    
    //helper function : finds the specific index of an item in an address (private)
    function getSpecificItemIndex(address _address, bytes32 _hash)private view returns (int index) {
        
         if(hashExists[_hash] == false){
            return -1;
        }
        //number of items user has
        uint numItems = storedItem[_address].itemListSize;
        //find which index item lives in
        for(uint i = 0; i < numItems; i++){
            if(storedItem[_address].itemList[i].hash == _hash){
                return int(i);
            }

        }
        //if item was not found
        return -1;
        
    }
 
    
    //check if item exists
    function checkItemExistsByHash(bytes32 _hash) public view returns (bool){
        return hashExists[_hash];
       
        
    }
    
    function checkUserExists(address _address) public view returns (bool){
        return (userExists[_address]);
        
    }
    

    //find the cost of owning the item
    function checkPrice(bytes32 _hash) public view returns (uint){
        require(hashExists[_hash] == true);
        return hashToItem[_hash].price;
    }
    
    
    function buyItem(bytes32 _hash) public payable{
        require(hashExists[_hash] == true);
        //get owner of item
        address itemOwner = hashToUser[_hash];
        
        int index = getSpecificItemIndex(itemOwner,_hash);
        uint price = checkPrice(_hash);
        
        require(msg.value == price);
        //change owner
        //remove item from that owner
        //add item to other person
        //storedItem[itemOwner].itemList[uint(index)].
        
        
    }
    
    //only the contract owner sees the balance--
    //onylOwner() modifier comes from Owner.sol (import)
    function getBalance() public view onlyOwner() returns (uint){
        return address(this).balance;
        
    }
}
