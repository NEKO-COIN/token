pragma solidity ^0.4.23;

/*
 *        È ÈQ__
 *     ^(*ß[ß) ^_
 *   ^|P¾¾P|_^
 *     |        |^
 *     PPPP
 *
 *     ÈÈ   ^PPPPP
 *    (,ß„Dß)ƒ ƒSƒ‹ƒ@I
 *    ¼   ½ _QQQQQ
 *   `|   |
 *     ‚µ `J
 *
 *
 *    /_QQQ^_
 *  ^ Ü   Ü ::  _
 *  |iœj,Aiœj,| 
 *  |,,ƒm(A_, )R   |
 *  |   ƒg]]§':::|
 *  _  MƒjƒjL.::^
 * ^M[]--]]LL_
 *
 *
 *
 *
 *
 *      ##                            ##
 *      ####                        ####
 *      #####                      #####
 *     #######      ########      #######
 *     ##################################
 *    ####################################
 *   ######################################                                                  ###  ##
 *   ######################################     ####      ###  ##########  ###    ###   ### #### ####            ########       ########      ###   ####      ###
 *  ########## ## ############ ## ##########    #####     ###  ##########  ###  ####   #### #### #### ###      ###########    ############    ###   #####     ###
 * #########   ##   ########   ##   #########   ######    ###  ###         #######      ###          #####    ####      ###  ####      ####   ###   ######    ###
 * ########    ##    ######    ##    ########   ### ####  ###  ##########  #####          #########  #####    ###            ###        ###   ###   ### ####  ###
 * ########    ##    ######    ##    ########   ###  #### ###  ###         #######       ###########  ###     ###            ###        ###   ###   ###  #### ###
 * #########   ##   ########   ##   #########   ###   #######  ###         ###  ####    #############         ####      ###  ####      ####   ###   ###   #######
 * ########### ## ############ ## ###########   ###     #####  ##########  ###   ####   ##############         ###########    ############    ###   ###     #####
 *  ########################################    ###      ####  ##########  ###    ####  #############            ########       ########      ###   ###      ####
 *  ########################################                                              #########
 *    ####################################
 *      ################################
 *         ##########################
 *              ################
 *
 */
  
/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}



/**
 * @title Ownable
 * @dev The Ownable contract has an owner address & authority addresses, and provides basic
 * authorization control functions, this simplifies the implementation of user permissions.
 */
contract Ownable {
  address public owner;
  bool public canRenounce = false;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  function enableRenounceOwnership() onlyOwner public {
    canRenounce = true;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function transferOwnership(address _newOwner) onlyOwner public {
    if(!canRenounce){
      require(_newOwner != address(0));
    }
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }
}



/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;

  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }
}



/**
 * @title ERC223
 * @dev ERC223 contract interface with ERC20 functions and events
 *      Fully backward compatible with ERC20
 *      Recommended implementation used at https://github.com/Dexaran/ERC223-token-standard/tree/Recommended
 */
contract ERC223 {
    uint256 public totalSupply;

    // ERC223 and ERC20 functions and events
    function name() public view returns (string _name);
    function symbol() public view returns (string _symbol);
    function decimals() public view returns (uint8 _decimals);
    function balanceOf(address _owner) public view returns (uint256 _balance);
    function totalSupply() public view returns (uint256 _supply);
    function transfer(address _to, uint256 _value) public payable returns (bool _success);
    function transfer(address _to, uint256 _value, bytes _data) public payable returns (bool _success);
    function transferFrom(address _from, address _to, uint256 _value) public payable returns (bool _success);
    function approve(address _spender, uint256 _value) public returns (bool success);
    function allowance(address _owner, address _spender) public view returns (uint256 _remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value, bytes indexed _data);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}



/**
 * @title ContractReceiver
 * @dev Contract that is working with ERC223 tokens
 */
contract ContractReceiver {
/**
 * @dev Standard ERC223 function that will handle incoming token transfers.
 *
 * @param _from  Token sender address.
 * @param _value Amount of tokens.
 * @param _data  Transaction metadata.
 */
    function tokenFallback(address _from, uint256 _value, bytes _data) external;
}




/**
 * @title NEKO COIN
 * @author BOSSNEKO with Yuki & Tsuchinoko-san
 * @dev NEKO COIN is an ERC223 Token with ERC20 functions and events
 *      Fully backward compatible with ERC20
 */
contract NEKOCOIN is ERC223, Ownable, Pausable {
    using SafeMath for uint256;

    string public name = "NEKOCOIN";
    string public symbol = "NEKO";
    uint8 public decimals = 8;
    uint256 public totalSupply = 18e9 * 1e8;
    uint256 public codeSize = 0;
    bool public mintingFinished = false;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    mapping (address => bool) public cannotSend;
    mapping (address => bool) public cannotReceive;
    mapping (address => uint256) public cannotSendUntil;
    mapping (address => uint256) public cannotReceiveUntil;

    event FrozenFunds(address indexed target, bool cannotSend, bool cannotReceive);
    event LockedFunds(address indexed target, uint256 cannotSendUntil, uint256 cannotReceiveUntil);
    event Burn(address indexed from, uint256 amount);
    event Mint(address indexed to, uint256 amount);
    event MintFinished();

   /** 
     * @dev Constructor is called only once and can not be called again
     */
    constructor() public {
        balanceOf[msg.sender] = totalSupply;
    }

    function name() public view returns (string _name) {
        return name;
    }

    function symbol() public view returns (string _symbol) {
        return symbol;
    }

    function decimals() public view returns (uint8 _decimals) {
        return decimals;
    }

    function totalSupply() public view returns (uint256 _totalSupply) {
        return totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return balanceOf[_owner];
    }
    
    /**
     * @dev Prevent _targets from sending or receiving tokens
     * @param _targets Addresses to be frozen
     * @param _cannotSend Whether to prevent _targets from sending tokens or not
     * @param _cannotReceive Whether to prevent _targets from receiving tokens or not
     */
    function freezeAccounts(address[] _targets, bool _cannotSend, bool _cannotReceive) onlyOwner public {
        require(_targets.length > 0);

        for (uint256 i = 0; i < _targets.length; i++) {
            cannotSend[_targets[i]] = _cannotSend;
            cannotReceive[_targets[i]] = _cannotReceive;
            emit FrozenFunds(_targets[i], _cannotSend, _cannotReceive);
        }
    }

    /**
     * @dev Prevent _targets from sending or receiving tokens by setting Unix time
     * @param _targets Addresses to be locked funds
     * @param _cannotSendUntil Unix time when locking up sending function will be finished
     * @param _cannotReceiveUntil Unix time when locking up receiving function will be finished
     */
    function lockupAccounts(address[] _targets, uint256 _cannotSendUntil, uint256 _cannotReceiveUntil) onlyOwner public {
        require(_targets.length > 0);

        for(uint256 i = 0; i < _targets.length; i++){
            require(cannotSendUntil[_targets[i]] <= _cannotSendUntil
                    && cannotReceiveUntil[_targets[i]] <= _cannotReceiveUntil);

            cannotSendUntil[_targets[i]] = _cannotSendUntil;
            cannotReceiveUntil[_targets[i]] = _cannotReceiveUntil;
            emit LockedFunds(_targets[i], _cannotSendUntil, _cannotReceiveUntil);
        }
    }

    /**
     * @dev Function that is called when a user or another contract wants to transfer funds
     */
    function transfer(address _to, uint256 _value, bytes _data) whenNotPaused public payable returns (bool _success) {
        require(_value > 0
                && cannotSend[msg.sender] == false
                && cannotReceive[_to] == false
                && now > cannotSendUntil[msg.sender]
                && now > cannotReceiveUntil[_to]);

        if (isContract(_to)) {
            return transferToContract(_to, _value, _data);
        } else {
            return transferToAddress(_to, _value, _data);
        }
    }

    /**
     * @dev Standard function transfer similar to ERC20 transfer with no _data
     *      Added due to backwards compatibility reasons
     */
    function transfer(address _to, uint256 _value) whenNotPaused public payable returns (bool _success) {
        require(_value > 0
                && cannotSend[msg.sender] == false
                && cannotReceive[_to] == false
                && now > cannotSendUntil[msg.sender]
                && now > cannotReceiveUntil[_to]);

        bytes memory empty;
        if (isContract(_to)) {
            return transferToContract(_to, _value, empty);
        } else {
            return transferToAddress(_to, _value, empty);
        }
    }

 /**
   * @dev Returns whether the target address is a contract
   * @param _addr address to check
   * @return whether the target address is a contract
   */
  function isContract(address _addr) internal view returns (bool) {
    uint256 size;
    // Currently there is no better way to check if there is a contract in an address
    // than to check the size of the code at that address.
    // See https://ethereum.stackexchange.com/a/14016/36603
    // for more details about how this works.
    // Check this again before the Serenity release, because all addresses will be
    // contracts then.
    // solium-disable-next-line security/no-inline-assembly
    assembly { size := extcodesize(_addr) }
    return size > codeSize ;
  }

    function setCodeSize(uint256 _codeSize) onlyOwner public {
        codeSize = _codeSize;
    }

    // function that is called when transaction target is an address
    function transferToAddress(address _to, uint256 _value, bytes _data) private returns (bool _success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        _to.transfer(msg.value);
        emit Transfer(msg.sender, _to, _value, _data);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // function that is called when transaction target is a contract
    function transferToContract(address _to, uint256 _value, bytes _data) private returns (bool _success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        ContractReceiver receiver = ContractReceiver(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        if(msg.value > 0){
            _to.transfer(msg.value);
        }
        emit Transfer(msg.sender, _to, _value, _data);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another
     *      Added due to backwards compatibility with ERC20
     * @param _from address The address which you want to send tokens from
     * @param _to address The address which you want to transfer to
     * @param _value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address _from, address _to, uint256 _value) whenNotPaused public payable returns (bool _success) {
        require(_to != address(0)
                && _value > 0
                && balanceOf[_from] >= _value
                && allowance[_from][msg.sender] >= _value
                && cannotSend[msg.sender] == false
                && cannotReceive[_to] == false
                && now > cannotSendUntil[msg.sender]
                && now > cannotReceiveUntil[_to]);

        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        if(isContract(_to)) {
            bytes memory empty;
            ContractReceiver receiver = ContractReceiver(_to);
            receiver.tokenFallback(_from, _value, empty);
        }
        if(msg.value > 0){
            _to.transfer(msg.value);
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
     * @dev Allows _spender to spend no more than _value tokens in your behalf
     *      Added due to backwards compatibility with ERC20
     * @param _spender The address authorized to spend
     * @param _value the max amount they can spend
     */
    function approve(address _spender, uint256 _value) public returns (bool _success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender
     *      Added due to backwards compatibility with ERC20
     * @param _owner address The address which owns the funds
     * @param _spender address The address which will spend the funds
     */
    function allowance(address _owner, address _spender) public view returns (uint256 _remaining) {
        return allowance[_owner][_spender];
    }

    /**
     * @dev Burns a specific amount of tokens.
     * @param _from The address that will burn the tokens.
     * @param _unitAmount The amount of token to be burned.
     */
    function burn(address _from, uint256 _unitAmount) onlyOwner public {
        require(_unitAmount > 0
                && balanceOf[_from] >= _unitAmount);

        balanceOf[_from] = balanceOf[_from].sub(_unitAmount);
        totalSupply = totalSupply.sub(_unitAmount);
        emit Burn(_from, _unitAmount);
        emit Transfer(_from, address(0), _unitAmount);

    }
    
    modifier canMint() {
        require(!mintingFinished);
        _;
    }

    /**
     * @dev Function to mint tokens
     * @param _to The address that will receive the minted tokens.
     * @param _unitAmount The amount of tokens to mint.
     */
    function mint(address _to, uint256 _unitAmount) onlyOwner canMint public returns (bool) {
        require(_unitAmount > 0);

        totalSupply = totalSupply.add(_unitAmount);
        balanceOf[_to] = balanceOf[_to].add(_unitAmount);
        emit Mint(_to, _unitAmount);
        emit Transfer(address(0), _to, _unitAmount);
        return true;
    }

    /**
     * @dev Function to stop minting new tokens.
     */
    function finishMinting() onlyOwner canMint public returns (bool) {
        mintingFinished = true;
        emit MintFinished();
        return true;
    }

    /**
     * @dev Function to distribute tokens to the list of addresses by the provided amount
     */
    function batchTransfer(address[] _addresses, uint256 _amount, uint256 _platformAmount) whenNotPaused public payable returns (bool) {
        require(_amount > 0
                && _addresses.length > 0
                && cannotSend[msg.sender] == false
                && now > cannotSendUntil[msg.sender]);

        uint256 totalAmount = _amount.mul(_addresses.length);
        require(balanceOf[msg.sender] >= totalAmount);
        
        uint256 totalPlatformAmount = _platformAmount.mul(_addresses.length);
        require(msg.value >= totalPlatformAmount);

        for (uint256 i = 0; i < _addresses.length; i++) {
            require(_addresses[i] != address(0)
                    && cannotReceive[_addresses[i]] == false
                    && now > cannotReceiveUntil[_addresses[i]]);

            balanceOf[_addresses[i]] = balanceOf[_addresses[i]].add(_amount);
            if(_platformAmount > 0){
                _addresses[i].transfer(_platformAmount);
            }
            emit Transfer(msg.sender, _addresses[i], _amount);
        }
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(totalAmount);
        msg.sender.transfer(msg.value.sub(totalPlatformAmount));
        return true;
    }

    function batchTransfer(address[] _addresses, uint256[] _amounts, uint256[] _platformAmounts) whenNotPaused public payable returns (bool) {
        require(_addresses.length > 0
                && _addresses.length == _amounts.length
                && _addresses.length == _platformAmounts.length
                && cannotSend[msg.sender] == false
                && now > cannotSendUntil[msg.sender]);

        uint256 totalAmount = 0;
        uint256 totalPlatformAmount = 0;

        for(uint256 i = 0; i < _addresses.length; i++){
            require(_amounts[i] > 0
                    && _addresses[i] != address(0)
                    && cannotReceive[_addresses[i]] == false
                    && now > cannotReceiveUntil[_addresses[i]]);

            balanceOf[_addresses[i]] = balanceOf[_addresses[i]].add(_amounts[i]);
            totalAmount = totalAmount.add(_amounts[i]);
            if(_platformAmounts[i] > 0){
                _addresses[i].transfer(_platformAmounts[i]);
            }
            totalPlatformAmount = totalPlatformAmount.add(_platformAmounts[i]);
            emit Transfer(msg.sender, _addresses[i], _amounts[i]);
        }

        require(balanceOf[msg.sender] >= totalAmount);
        require(msg.value >= totalPlatformAmount);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(totalAmount);
        msg.sender.transfer(msg.value.sub(totalPlatformAmount));
        return true;
    }

    /**
     * @dev fallback function
     */
    function() payable public {
        revert();
    }

    /**
     * @dev Reject all ERC223 compatible tokens
     * @param _from address The address that is transferring the tokens
     * @param _value uint256 the amount of the specified token
     * @param _data Bytes The data passed from the caller.
     */
    function tokenFallback(address _from, uint256 _value, bytes _data) external pure {
        _from;
        _value;
        _data;
        revert();
    }
}
