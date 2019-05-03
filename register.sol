pragma solidity ^0.5.7;

//https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ownership/Ownable.sol

//allows the contract to be owned by the deployer
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";


//deployer of contract is the owner
contract RegisterItems is Ownable {
    
    
    struct itemStruct{
        string name;  
        string hash;
        uint buyPrice;
        uint ownPrice;
        address item_owner;
        //address[] requests; //list of people who requested it
        
        
    }

    //container for if user has many items
    struct metaItem{
        uint boughtListSize;
        uint ownedListSize;
        mapping(uint => itemStruct) boughtItemList;
        mapping(uint => itemStruct) ownedItemList;

    }

    mapping(address => bool) userExists; //check if user exists
    mapping(string => bool) hashExists; //check if hash exists
    mapping(string => address) hashToOwner;
    mapping(string => itemStruct) hashToItem;
   
    mapping(address => metaItem) storedItem;//map user address to item (string test)
  
    event Owned(string words, address owner); //garbage event for debugging
    event LogDepositReceived(address);
    //name, hash, buy price, own price
    
    function registerNewItem(string memory _hash,string memory _name, uint _buyPrice, uint _ownPrice)public payable returns (bool){
 
        //bytes32 itemHash = keccak256(bytes(_name)); //make a hash to check for data existence
        
        //CHECK IF ITEM IS DUPLICATE
        if(hashExists[_hash] == false){
            //initialize item
            /*
             string name;  
            bytes32 hash;
            bool isRequested;
            uint price;
            address owner;
       
            */
            
                                                            //string, bytes32, uint,  address
            itemStruct memory itemnew = itemStruct(_name, _hash,  _buyPrice, _ownPrice, msg.sender);
        
            
            //Set mappings
            hashExists[_hash] = true;
            hashToOwner[_hash] = msg.sender;
            hashToItem[_hash] = itemnew;
            
            //set users storedItem
            uint index = storedItem[msg.sender].ownedListSize; //(0)index is the size of user's size of items (metalist)
            storedItem[msg.sender].ownedListSize++; //increase size
            storedItem[msg.sender].ownedItemList[index] = itemnew; //put item in user's list
           
            
            
            if(userExists[msg.sender] == false){
                //set user to exists
                userExists[msg.sender] = true;
            }
            
            //require(msg.value == REGISTER_COST); //set the price for registering-- goes to contract
            return true;
        }
        else{
            //emit Owned("This item already exists by: ", /*TODO:make findOwnerByItem trash*/ msg.sender);
            
            //DO NOTHING!!! Send verfication problems around!! TODO: figure out confilicts of verifcation
            return false;
        }

    }
    
    //fallback function ??!??
//   function() payable { 
//       require(msg.data.length == 0); 
//       emit LogDepositReceived(msg.sender); 
       
//   }
    
    function findOwnerByItem(string memory _hash) public view returns (address _owner){
        return hashToOwner[_hash];
 
    }
    //TODO
    //list all items from a user
    function getOwnedItems(address _address)public view returns (bool) {  
        //number of items user has
        uint numItems = storedItem[_address].ownedListSize;
        for(uint i = 0; i < numItems; i++){
            //find  a way to output ALL items: name + hash should be enough
            
            
        }
        
    }
    
    //helper function : finds the specific index of an item in an address (private)
    function getSpecificOwnedItemIndex(address _address, string memory _hash)public view returns (uint index) {
        require(hashExists[_hash] == true);
        
        //number of items user has
        uint numItems = storedItem[_address].ownedListSize;
        //find which index item lives in
        for(uint i = 0; i < numItems; i++){
            if(compareStrings(storedItem[_address].ownedItemList[i].hash, _hash)){
                return uint(i);
            }

        }
        
        
    }
    
    function compareStrings (string memory a, string memory b) private view returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );

    }
 
    
    //check if item exists
    function checkItemExistsByHash(string memory _hash) public view returns (bool){
        return hashExists[_hash];
       
        
    }
    
    function checkUserExists(address _address) public view returns (bool){
        return (userExists[_address]);
        
    }
    

    //find the cost of owning the item
    function checkBuyPrice(string memory _hash) public view returns (uint){
        require(hashExists[_hash] == true);
        return hashToItem[_hash].buyPrice;
    }
    
     //find the cost of owning the item
    function checkOwnPrice(string memory _hash) public view returns (uint){
        require(hashExists[_hash] == true);
        return hashToItem[_hash].ownPrice;
    }
    
    
    function buyItem(string memory _hash) public payable{
        require(hashExists[_hash] == true);
        
        //get owner of item
        address itemOwner = hashToOwner[_hash];
        
        
        uint index = getSpecificOwnedItemIndex(itemOwner,_hash);
        uint price = checkBuyPrice(_hash);
        
        require(msg.value == price);
        
        //check if buyer exists
        if(userExists[msg.sender] == false){
          userExists[msg.sender] = true;
        }
        //add item to other person
        //get the item
        itemStruct memory itemnew = storedItem[itemOwner].ownedItemList[uint(index)];
    
        
        uint buyerIndex = storedItem[msg.sender].boughtListSize; //index is the size of user's size of items (metalist)
        storedItem[msg.sender].boughtListSize++; //increase size
        storedItem[msg.sender].boughtItemList[buyerIndex] = itemnew; //put item in user's list
          
        //added item to user
    
        
       
    }
    
    function ownItem(string memory _hash) public payable{
        require(hashExists[_hash] == true);
        
        //get owner of item
        address itemOwner = hashToOwner[_hash];
        
        
        uint index = getSpecificOwnedItemIndex(itemOwner,_hash);
    
        uint price = checkBuyPrice(_hash);
        
        require(msg.value == price);
        
        //check if buyer exists
        if(userExists[msg.sender] == false){
          userExists[msg.sender] = true;
        }
        //add item to other person
        //get the item
        itemStruct memory itemnew = storedItem[itemOwner].ownedItemList[uint(index)];
        
        //add item to new user's Owned inventory
        hashToOwner[_hash] = msg.sender;
        hashToItem[_hash] = itemnew;
        
        uint buyerIndex = storedItem[msg.sender].ownedListSize; //index is the size of user's size of items (metalist)
        storedItem[msg.sender].ownedListSize++; //increase size
        storedItem[msg.sender].ownedItemList[buyerIndex] = itemnew; //put item in user's list
          
        //remove from previous owner
        //problem not knowing indexes!!!
        
        storedItem[itemOwner].ownedListSize--;
        uint ownedSize = storedItem[itemOwner].ownedListSize;
        
        //if one is removed place last item at end
        uint newSize = storedItem[itemOwner].ownedListSize;
        if(newSize > 1 && index != ownedSize -1){ //if there's more than one item and the item removed wasn't the last item
            //move the last item to the deleted spot
            //delete prev owner index
            //delete storedItem[itemOwner].ownedItemList[uint(index)]; 
            itemnew = storedItem[itemOwner].ownedItemList[ownedSize];//(owned list already -1 so should be good index)get the last thing in the last index and put in old spot
            storedItem[itemOwner].ownedItemList[uint(index)] = itemnew;
            //delete last index
            //delete storedItem[itemOwner].ownedItemList[uint(index)];
            //shift last index to same spot
           
                
            
        }
        else if(index  == newSize +1){
           //delete storedItem[itemOwner].ownedItemList[uint(index)];
            
        }

        
    
        
       
    }
    
    //only the contract owner sees the balance--
    //onylOwner() modifier comes from Owner.sol (import)
    function getBalance() public view onlyOwner() returns (uint){
        return address(this).balance;
        
    }
    
    function withdraw() public onlyOwner() {
        msg.sender.transfer(address(this).balance);
        
    }
    
    function getItemNameFromHash(string memory _hash) public view returns(string memory){
        require(hashExists[_hash] == true);
        address owner = hashToOwner[_hash];
        uint index = getSpecificOwnedItemIndex(owner,_hash);
        
        return storedItem[owner].ownedItemList[index].name;
        
        
        
    }
    
    // function close() public onlyOwner(){
    //     selfdestruct(this.owner);
    // }
}
