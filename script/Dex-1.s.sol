// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
contract CounterScript is Script {

    Counter counter;
    function setUp() public {}

    function run() external returns (Counter) {
        vm.broadcast();
        counter = new Counter();

        return counter;


    }
}
