// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "contracts/interfaces/IGaugeFactory.sol";
import "contracts/Gauge.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/access/IAccessControl.sol";

contract GaugeFactory is IGaugeFactory, Ownable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER");

    address public last_gauge;

    function createGauge(
        address _pool,
        address _external_bribe,
        address _ve,
        bool isPair,
        address[] memory allowedRewards
    ) external returns (address) {
        last_gauge = address(
            new Gauge(
                _pool,
                _external_bribe,
                _ve,
                msg.sender,
                address(this),
                isPair,
                allowedRewards
            )
        );

        return last_gauge;
    }
}
