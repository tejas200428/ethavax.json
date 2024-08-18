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
