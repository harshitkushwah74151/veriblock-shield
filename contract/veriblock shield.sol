// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SecureHesh Vault
 * @dev A minimal and secure vault contract that allows users to deposit, withdraw,
 *      and check balances stored in the vault.
 */
contract SecureHeshVault {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    /**
     * @dev Allows a user to deposit ETH into the vault.
     */
    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev Allows a user to withdraw their deposited ETH.
     * @param amount The amount of ETH to withdraw.
     */
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }

    /**
     * @dev Returns the balance of the caller.
     */
    function getMyBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
