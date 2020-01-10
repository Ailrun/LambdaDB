# Lambda DB #

[![](https://img.shields.io/badge/stack->=2.1-blue.svg?style=flat)](http://docs.haskellstack.org/en/stable/README/)
[![](https://img.shields.io/badge/status-alpha-orange.svg?style=flat)](http://github.com/ailrun/LambdaDB)
[![](https://img.shields.io/hackage/v/LambdaDB.svg)](http://hackage.haskell.org/package/LambdaDB)
[![](https://travis-ci.org/Ailrun/LambdaDB.svg?branch=v0.0.0.7)](https://travis-ci.org/Ailrun/LambdaDB)

## Description ##

On-memory Database based on Lambda function

<b> Stable Version : 0.0.0.6 </b>  
<b> Lastest Version : 0.0.0.7 </b>

## Table Of Contents ##

* [Description](#description)
* [Table Of Contents](#table-of-contents)
* [Supporting Data Type](#supporting-data-type)
* [Commands](#commands)
  * [Current commands](#current-commands)
	* [Quit](#quit)
	* [Status](#status)
	* [Insert](#insert)
	* [Delete](#delete)
	* [Find](#find)
  * [Preserved commands](#preserved-commands)
* [Test](#test)
* [Update Log](#update-log)
* [TODO](#todo)
* [Author](#author)
* [License](#license)

## Supporting Data Type ##

1. None  
   Default Value for all keys.
2. Boolean  
   True or False.
3. Int  
   Limited Integer Value. Represented by digits. `123`
4. Integer  
   Unlimited Integer Value. Represented by digits having character "i" on the end. `123i`
5. Character  
   Character Value. Represented by a character surrounded with '. `'b'`
6. String  
   String Value. Represented by a character sequence surrounded with ". `"this is string"'`
7. List  
   List Value. Represented like `[1, 2, 3]`  
   In current version, you can write lists like `[1, 'c', 'b']`, but this act will be deprecated.

## Commands ##

All of these commands are case-insensitive.

### Current commads ###
 Commands | Form | Description
:--------:|------|-------------
 Quit   | quit | Quit DB process
 Status | status | Check DB status
 Insert | insert <key> <value> | Insert a value data with key
 Delete | delete <key> | Delete a value data using key
 Find   | find <key> | Find the value data using key

#### Quit ####

Quit command.
   
#### Status ####
   
Status check command.  

```
status
ON RUNNING
CPU TIME: 0.0
MEMORY USAGE: 89KB
```

#### Insert ####
   
Insert command.  
Needs Key(Any String without whitespace) and [Values](#supporting-data-type).

```
insert 5 [1, 2, 3]
OK
```

#### Delete ####

Delete command.  
Needs Key(AnyString without whitespace).

```
delete 5
OK
```

Until options supporting, this command is just a alias of `insert <key> None`.

#### Find ####

Find command.  
Needs Key(Any String without whitespace)

```
find 5
[1, 2, 3]
```

### Preserved commads ###

## Test ##
Basic test with stack is provided.  
Run `stack test` to check the result.

## Update Log ##
See [UpdateLog.md](UpdateLog.md) file.

## TODO ##

- [ ] Support more general data structure.
- [x] Change insert value more intuitively.
- [x] Change commands more program friendly, i.e. without additional inputs.
- [ ] Authorization System.
- [ ] Seperate server parts and client parts.
- [ ] Concerning about using parsec.

## Author ##
Junyoung Clare Jang @ KR
* @Ailrun, [github](https://github.com/ailrun)
* [blog](https://ailrun.github.io)

## License ##
Read the [LICENSE](LICENSE) file.
