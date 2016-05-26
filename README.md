# Lambda DB #

<a href="https://www.haskell.org/downloads">
	<img src="https://img.shields.io/badge/Haskell-lts--5.18-lightgrey.svg?style=plastic"/>
</>

![](https://img.shields.io/badge/stack->1.1-blue.svg?style=plastic&link=http://docs.haskellstack.org/en/stable/README/)
![](https://img.shields.io/badge/version-0.0.0.4-green.svg?style=plastic&link=http://github.com/ailrun/LambdaDB)
![](https://img.shields.io/badge/status-alpha-orange.svg?style=plastic&link=http://github.com/ailrun/LambdaDB)
![](https://img.shields.io/badge/build-passing-brightgreen.svg?style=plastic&link=http://github.com/ailrun/LambdaDB)

## Table Of Contents ##

* [Table Of Contents](#table-of-contents)
* [Description](#description)
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

## Commands ##

All of these commands are case-insensitive.

### Current commads ###
 Commands | Number of additional inputs | Description
:--------:|:---------------------------:|-------------
 Quit   | 0 | Quit DB process
 Status | 0 | Check DB status
 Insert | 2 | Insert a value data with key
 Find   | 1 | Find the value data using key

*Commands with additional inputs will be changed to use options instead of additional inputs*

#### Quit ####

Quit command.  
There is no additional inputs.
   
#### Status ####
   
Status check command.  
*Not implemented correctly yet*

#### Insert ####
   
Insert command.  
Needs 2 additional inputs.

```
insert
Input Insert Key :
a
Input Insert Value :
[1, 2, 3]
```

*Will be changed*

#### Find ####

Find command.  
Needs 1 additional inputs.

```
find
Input Find Key :
a
[1, 2, 3]
```

### Preserved commads ###
 Commands | Description
:--------:|-------------
 Delete | Delete a data. Same with `Insert Key None`

## TODO ##

- [ ] Support more general data structure.
- [x] Change insert value more intuitively.
- [ ] Change commands more program friendly, i.e. without additional inputs.
- [ ] Seperate server parts and client parts
- [ ] Concerning about using parsec.

## Author ##
Junyoung Clare Jang
* @Ailrun, [github](https://github.com/ailrun)
* [blog](https://ailrun.github.io)

## License ##
Read the [LICENSE](LICENSE) file.
