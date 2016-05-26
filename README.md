# Lambda DB #

[![](https://img.shields.io/badge/Haskell-lts--5.18-lightgrey.svg?style=plastic)](https://www.haskell.org/downloads)
[![](https://img.shields.io/badge/stack->1.1-blue.svg?style=plastic)](http://docs.haskellstack.org/en/stable/README/)
[![](https://img.shields.io/badge/version-0.0.0.5-green.svg?style=plastic)](http://github.com/ailrun/LambdaDB)
[![](https://img.shields.io/badge/status-alpha-orange.svg?style=plastic)](http://github.com/ailrun/LambdaDB)
[![](https://img.shields.io/badge/build-passing-brightgreen.svg?style=plastic)](http://github.com/ailrun/LambdaDB)

## Table Of Contents ##

* [Table Of Contents](#table-of-contents)
* [Description](#description)
* [Supporting Data Structure](#supporting-data-structure)
* [Commands](#commands)
  * [Current commands](#current-commands)
	* [Quit](#quit)
	* [Status](#status)
	* [Insert](#insert)
	* [Find](#find)
  * [Preserved commands](#preserved-commands)
* [TODO](#todo)
* [Author](#author)
* [License](#license)


## Description ##

On-memory Database based on Lambda function

<b> Stable Version : 0.0.0.4 </b>  
<b> Lastest Version : 0.0.0.5 </b>

## Supporting Data Structure ##

1. None  
   Default Value for all keys.
2. Boolean
   True or False.
3. Int
   Limited Integer Value. Represented by digits.
4. Integer
   Unlimited Integer Value. Represented by digits having character "i" on the end.
5. Character

## Commands ##

All of these commands are case-insensitive.

### Current commads ###
 Commands | Form | Description
:--------:|------|-------------
 Quit   | quit | Quit DB process
 Status | status | Check DB status
 Insert | insert <key> <value> | Insert a value data with key
 Find   | find <key> | Find the value data using key

#### Quit ####

Quit command.
   
#### Status ####
   
Status check command.  
*Not implemented correctly yet*

#### Insert ####
   
Insert command.  
Needs Key(Any String without whitespace) and Values.

```
insert 5 [1, 2, 3]
```

#### Find ####

Find command.  
Needs Key(Any String without whitespace)

```
find 5
[1, 2, 3]
```

### Preserved commads ###
 Commands | Description
:--------:|-------------
 Delete | Delete a data. Same with `Insert Key None`

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
