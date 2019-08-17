pragma solidity >=0.4.24;


import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";


contract StarNotary is ERC721 {
    string public name = "First StarNotary Token";
    string public symbol = "FST";


    struct Star {
        string name;
    }

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    function createStar(string memory _name, uint256 _tokenId) public {
        Star memory newStar = Star(_name);
        tokenIdToStarInfo[_tokenId] = newStar;
        _mint(msg.sender, _tokenId);
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "You can't sale the Star you don't owned");
        starsForSale[_tokenId] = _price;
    }

    function _make_payable(address x) internal pure returns (address payable) {
        return address(uint160(x));
    }

    function buyStar(uint256 _tokenId) public  payable {
        require(starsForSale[_tokenId] > 0, "The Star should be up for sale");
        uint256 starCost = starsForSale[_tokenId];
        address ownerAddress = ownerOf(_tokenId);
        require(msg.value > starCost, "You need to have enough Ether");
        _transferFrom(ownerAddress, msg.sender, _tokenId);
        address payable ownerAddressPayable = _make_payable(ownerAddress);
        ownerAddressPayable.transfer(starCost);
        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
    }

    function lookUptokenIdToStarInfo (uint256 _tokenId) public view returns (string memory) {
       string memory name = tokenIdToStarInfo[_tokenId].name;
       return name;
    }

    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
        address _tokenId1Owner = ownerOf(_tokenId1);
        address _tokenId2Owner = ownerOf(_tokenId2);

          if(_tokenId1Owner == msg.sender || _tokenId2Owner == msg.sender)
        {
        address FirstOwnerAddress = ownerOf(_tokenId1);
        address SecondOwnerAddress = ownerOf(_tokenId2);

        _transferFrom(FirstOwnerAddress,SecondOwnerAddress, _tokenId1);
        _transferFrom(SecondOwnerAddress,FirstOwnerAddress, _tokenId2);
        }
    }

    function transferStar(address _to1, uint256 _tokenId) public {
        address _messageSender = msg.sender;

        if(ownerOf(_tokenId) == _messageSender)
        {
              transferFrom(_messageSender, _to1, _tokenId);
        }
    }

}