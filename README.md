# Blogging App Contract

This Solidity program is a simple illustration of the blogging app in which user can register itself. They can also read and write blogs. Admin can delete the blogs as per his/her wish.

## Description

This program is a simple contract written in Solidity for a blogging application on the Ethereum blockchain. It defines structures for users and blogs, allowing users to register, write blogs, and view specific blogs. The contract includes admin functionalities to delete blogs also this contract ensures only registered users can write blogs.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix Ethereum](https://remix.ethereum.org/).

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BloggingApp {

    struct Blog{
        string title;
        string body;
        bool exists;
    }
    struct User{
        string username;
        bool registered;  
    }
    
    // User Functionality

   mapping(address=>User) users;

   function registerUser(string memory username, address _addr) public returns(string memory){
        if(users[_addr].registered) revert("Already registered");

        users[_addr] = User(username, true);
        return string(abi.encodePacked(username, " successfully registered"));
   }

   // Blogging Functionality

   mapping(address=>Blog) blogs;

   function writeBlog(string memory title, string memory body, address _user) public{
        assert(users[_user].registered);
        blogs[_user] = (Blog(title, body, true));
   }

   function viewBlog(address _user) public view returns(Blog memory){
    if(!blogs[_user].exists) revert("Blog doesn't exists");
    return blogs[_user];
   }

   // Admin Functionality

    address admin;

    constructor(){
        admin=msg.sender;
    }

    function deleteBlogs(address _user, address _adminAddr) public {
        require(admin==_adminAddr, "Unauthorized");
        blogs[_user].exists=false;
    }
 
}
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile Token.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Token" contract from the dropdown menu, and then click on the "Deploy" button.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
