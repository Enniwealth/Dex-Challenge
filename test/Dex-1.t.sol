// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../src/Dex-1.sol";

contract DexTest is Test {
    Dex public dex;
    address player = makeAddr("playerr");
    address owner = makeAddr("owner");

    SwappableToken public token1;
    SwappableToken public token2;



function setUp() public {
        vm.startPrank(owner);
        token1 = new SwappableToken(owner, 'token1', 'tk-1', 1000);
        token2 = new SwappableToken(owner, 'token2', 'tk-2', 1000);

        dex = new Dex(owner);

        token1.transfer(address(dex), 100);
        token2.transfer(address(dex), 100);

        token1.transfer(address(player), 10);
        token2.transfer(address(player), 10);
        vm.stopPrank();
        
    }


    function test_multiple_swaps() public {

            vm.startPrank(player);
            token1.approve(address(dex), 500);
            token2.approve(address(dex), 500);
            
            console.log(token1.balanceOf(address(dex)));

            dex.swap(address(token1), address(token2), 10);
            dex.swap(address(token2), address(token1), 20);
            dex.swap(address(token1), address(token2), 24);
            dex.swap(address(token2), address(token1), 30);
            dex.swap(address(token1), address(token2), 40);

            console.log(token1.balanceOf(address(dex)));
            console.log(token2.balanceOf(address(dex)));

        vm.startPrank(player);
        token1.approve(address(dex), 100);
        token2.approve(address(dex), 100);
        uint256 token1Expected = token1.balanceOf(address(dex));
        
        dex.swap(address(token1), address(token2), 10);
        dex.swap(address(token2), address(token1), 20);
        dex.swap(address(token1), address(token2), 24);
        dex.swap(address(token2), address(token1), 30);
        dex.swap(address(token1), address(token2), 41);
        dex.swap(address(token2), address(token1), 45);

        uint256 token1Balance = token1.balanceOf(player);
        uint256 token2Balance = token2.balanceOf(player);
        uint256 token2ExpectedAfter = token2.balanceOf(address(dex));
        uint256 token1ExpectedAfter = token1.balanceOf(address(dex));

        assert(token1Balance == token1Expected + 10);
        assertEq(token1ExpectedAfter, 0);
    }

}
   
