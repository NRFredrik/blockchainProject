pragma solidity ^0.5.7;

contract Item{
    
    struct itemStruct{
        string name;
        //bool isRequested;
        //uint price;
        //uint dlPrice; //download price
        //bool verfiedOwner;
        //date for next fee (download on a time basis)
        
    }
 
}


contract RegisterItems {
    
    //container for if user has many items
    struct metaItem{
        uint itemListSize;
        mapping(uint=>Item.itemStruct) itemList;
        
    }

    mapping(address => bool) userExists; //check if user exists
    mapping(bytes32 => bool) hashExists; //check if hash exists
    mapping(bytes32 => address) hashToUser;
   
    mapping(address => metaItem) storedItem;//map user address to item (string test)
  
    event Owned(string words, address owner);
    
    Item.itemStruct[] itemArray;
    //constructor to create dynamic array 
    
  
   
    function registerNewItem(string memory  _name)public returns (bool){
 
        bytes32 itemHash = keccak256(bytes(_name)); //make a hash to check for data existence
        
        //CHECK IF ITEM IS DUPLICATE
        if(hashExists[itemHash] == false){
            //initialize item
            Item.itemStruct memory itemnew = Item.itemStruct(_name);
            
            //Set mappings
            hashExists[itemHash] = true;
            hashToUser[itemHash] = msg.sender;
            
            //set users storedItem
            uint index = storedItem[msg.sender].itemListSize; //index is the size of user's size of items (metalist)
            storedItem[msg.sender].itemListSize++; //increase size
            storedItem[msg.sender].itemList[index] = itemnew; //put item in user's list
            
            if(userExists[msg.sender] == false){
                //set user to exists
                userExists[msg.sender] = true;
            }
        }
        else{
            //emit Owned("This item already exists by: ", /*TODO:make findOwnerByItem trash*/ msg.sender);
            
            //DO NOTHING!!! Send verfication problems around!! TODO: figure out confilicts of verifcation
        }

    }
    
    //TODO
    function findOwnerByItem(bytes32 _hash) public view returns (address _owner){
        return hashToUser[_hash];
 
    }
    //TODO
    //list all items from a user
    function getItems(address _add)public  returns (bool) {  
    
        
    }
    
    //set a boolean in the item 
    //TODO
    function requestOwnership() public returns(bool){
        
    }
    
    //check if item exists
    function checkItemExistsByHash(string memory _hash) public view returns (bool){
        bytes32 itemHash = keccak256(bytes(_hash));
        return (hashExists[itemHash]);
        
    }
    
    function checkUserExists(address _address) public view returns (bool){
        return (userExists[_address]);
        
    }
    
    //TODO
    //find the cost of owning the item
    function checkPrice(bytes32 _hash) public view returns (bool){
        //have to find item first
        
        
    }
    
    
    
    
    
    
}
