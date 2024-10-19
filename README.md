# What I learnt in this project

I learnt to use formal verification tools like `HALMOS` and `CERTORA` to mathematically prove that the invariants/properties of the system/contract will hold true. This is helpful because even with large fuzz runs, we can never be 100% sure that there are no edge cases to the invariant. With formal verification, the tool guarantees the result with certainty, provided the test cases are soundly setup with assertions and preconditions.

## Halmos

### Setting up the test cases
After installing Halmos from the docs, writing tests is pretty similar to foundry fuzz tests. It is preferred to start test function name for Halmos with the prefix `check_`. All preconditions for the test are wrapped in a `require` statements instead of using foundry cheatcodes like `bound` or `assume`. Currently Halmos only supports checking invariants and rules through the `assert` keyword.

### Common issues
- **Path explosion**: Sometimes the test can `timeout` due to various reasons, most common being `path explosion`. Path explosion is when there are too many options for the solver to explore within the default time range. Some ways to resolve this is by `increasing the timeout` or `modularizing the functions` to reduce theie complexity. Though these steps don't guarantee to fix the timeout, but are greatly helpful in majority of the cases.

### Useful commands
- Formally verify a specific function
```bash
halmos --function <test_function_name_here>
```
- Increase the solver timeout
```bash
# set timeout to 0 for infinite range
halmos --function <test_function_name_here> --solver-timeout-assertion <timeout_ms_here>
```

## Certora

### Setting up the test cases
Certora works differently than Halmos with a little more effort required to get setup with the test cases. After installing the `certora-cli`, we need to create `conf` and `spec` files for the invariants we want to test. Spec files are used to layout the rules and invariants of a contract with the assertions and preconditions required to test them. Conf files are used to define which contracts are in scope and the which spec files to use to verify them with some additional settings to fine tune the solver according to our needs. Because the solver runs on the cloud, it returns a link as an output which takes us to its UI for more info.

### Common issues
- **Path explosion**: This is the same as Halmos.
- **Testing non public/external functions**: Sometimes, we need to test some functions that are not public or external which Certora is unable to access. A workaround for this is to write `harness` or wrapper contracts to expose function without changing its behaviour. One thing to note is that by using this appraoch, we make our solver unsound.
- **Dealing with loops**: If Certora can approximate the number of times a loop would be executed, it will replace the loop with multiple copies of their body. If it can't, then the default unroll depth is 1 which can be changed with its flag. There are 2 ways to deal with loops that would run too many times in Certora - `optimistic` or `pessimistic` mode. Optimistic mode is unsound because it skips inputs that will cause the loop to run many times.

### Useful commands
- Formally verify an invariant or rule using its conf and spec files
```bash
# ensure CERTORAKEY env is exported
certoraRun <RELATIVE_PATH_FROM_ROOT_DIR_TO_CONF_FILE>
```

# Course challenge completion

- **Transaction hash**: https://sepolia.etherscan.io/tx/0x86c478f24289cffa482b14252e2024f3bb51165b31872e8ce1585241567a766b

- **NFT info**: https://sepolia.etherscan.io/nft/0x31801c3e09708549c1b2c9e1cfbf001399a1b9fa/665