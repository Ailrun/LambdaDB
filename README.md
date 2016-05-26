# Lambda DB #

![](https://img.shields.io/badge/Haskell-lts--5.18-lightgrey.svg?style=plastic)
![](https://img.shields.io/badge/stack->1.1-blue.svg?style=plastic)
![](https://img.shields.io/badge/version-0.0.0.4-green.svg?style=plastic)
![](https://img.shields.io/badge/status-alpha-orange.svg?style=plastic)
![](https://img.shields.io/badge/build-success-green.svg?style=plastic)

## Description ##

On-memory Database based on Lambda function

### Commands ###

All of these commands are case-insensitive.

*Commands with additional inputs will be changed to use options instead of additional inputs*

1. Quit
   Quit command.
   There is no additional inputs.
2. Status
   Status check command.
   *Not implemented correctly yet*
3. Insert
   Insert command.
   Needs 2 additional inputs.
   ```
   <b>insert</b>
   Input Insert Key :
   <b>a</b>
   Input Insert Value :
   <b>[1, 2, 3]</b>
   ```
   *Will be changed*
4. Find
   Find command.
   Needs 1 additional inputs.
   ```
   <b>find</b>
   Input Find Key :
   <b>a</b>
   [1, 2, 3]
   ```

## TODO ##

- [ ] Use Lambda Calculation to reduce lambda.
- [ ] Support more general data structure.
- [x] Change insert value more intuitively.
- [ ] Change commands more program friendly, i.e. without additional inputs.
- [ ] Concerning about using parsec.

## Author ##
Junyoung Clare Jang ([github](https://github.com/ailrun), [blog](https://ailrun.github.io))
